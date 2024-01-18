<?php
    include "conexiune.php";
    
    require_once('phpmailer/phpmailer/class.phpmailer.php');
    require_once('phpmailer/phpmailer/mail_config.php');
    session_start();

    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    function validateFields($nr_matricol, $cnp, $telefon, $data_nastere) {
        if (!preg_match('/^\d{1,4}\/\d{4}$/', $nr_matricol)) {
            echo "Numărul matricol gresit";
            return false;
        }

        if (strlen($cnp) !== 13) {
            echo "CNP gresit";
            return false;
        }

        if ($data_nastere >= 2007) {
            echo "Varsta minima este de 16 ani";
            return false;
        }

        if (!preg_match('/^0\d{9}$/', $telefon) || strlen($telefon) !== 10) {
            echo "Numărul de telefon gresit";
            return false;
        }

        return true;
    }




    // Verifică dacă s-a trimis formularul de înregistrare
    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['register'])) {
        $nume = $_POST['nume'];
        $email = $_POST['email'];
        $parola = password_hash($_POST['parola'], PASSWORD_BCRYPT);
        $id_facultate = $_POST['facultate'];
        $nr_matricol = $_POST['nr_matricol'];
        $grupa = $_POST['grupa'];
        $cnp = $_POST['cnp'];
        $data_nastere = $_POST['data_nastere'];
        $telefon = $_POST['telefon'];

        if (validateFields($nr_matricol, $cnp, $telefon, $data_nastere)) {

            // Verifică dacă email-ul este deja înregistrat
            $stmt_check_email_student = $conn->prepare("SELECT * FROM STUDENT WHERE email = ?");
            $stmt_check_email_student->bind_param("s", $email);
            $stmt_check_email_student->execute();
            $result_check_email_student = $stmt_check_email_student->get_result();

            $stmt_check_email_profesor = $conn->prepare("SELECT * FROM PROFESOR WHERE email = ?");
            $stmt_check_email_profesor->bind_param("s", $email);
            $stmt_check_email_profesor->execute();
            $result_check_email_profesor = $stmt_check_email_profesor->get_result();

            if ($result_check_email_student->num_rows == 0 && $result_check_email_profesor->num_rows == 0) {
                $stmt_get_id_grupa = $conn->prepare("SELECT id_grupa FROM GRUPA WHERE numar_grupa = ? AND id_specialitate IN (SELECT id_specialitate FROM SPECIALITATE WHERE id_facultate = ?)");
                $stmt_get_id_grupa->bind_param("si", $grupa, $id_facultate);
                $stmt_get_id_grupa->execute();
                $result_get_id_grupa = $stmt_get_id_grupa->get_result();

                if($result_get_id_grupa->num_rows == 1){

                    $row_get_id_grupa = $result_get_id_grupa->fetch_assoc();
                    $id_grupa = $row_get_id_grupa['id_grupa'];

                    $verificationCode = rand(100000, 999999);
                    // Mesajul
                    $message = "Codul pentru verificarea email-ului este: '$verificationCode'";

                    // În caz că vre-un rând depășește N caractere, trebuie să utilizăm
                    // wordwrap()
                    $message = wordwrap($message, 160, "<br />\n");


                    $mail = new PHPMailer(true); 

                    $mail->IsSMTP();

                    try {
                    
                    $mail->SMTPDebug  = 0;                     
                    $mail->SMTPAuth   = true; 

                    $mail->SMTPSecure = "ssl";                 
                    $mail->Host       = "smtp.gmail.com";      
                    $mail->Port       = 465;                   
                    $mail->Username   = $username;  			// GMAIL username
                    $mail->Password   = $password;            // GMAIL password
                    //$mail->AddReplyTo('rapceacatalinc@gmail.comm', 'Rapcea Catalin');
                    $mail->AddAddress($email, $nume);
                    
                    $mail->SetFrom('rapceacatalinc@gmail.com', 'Rapcea Catalin');
                    $mail->Subject = 'Cod pentru verificare';
                    $mail->AltBody = 'To view this post you need a compatible HTML viewer!'; 
                    $mail->MsgHTML($message);
                    $mail->Send();
                    echo "Message Sent OK</p>\n";
                    } catch (phpmailerException $e) {
                    echo $e->errorMessage(); //error from PHPMailer
                    } catch (Exception $e) {
                    echo $e->getMessage(); //error from anything else!
                    }

                    $_SESSION['nr_matricol'] = $nr_matricol;
                    $_SESSION['id_grupa'] = $id_grupa;
                    $_SESSION['cnp'] = $cnp;
                    $_SESSION['nume'] = $nume;
                    $_SESSION['data_nastere'] = $data_nastere;
                    $_SESSION['email'] = $email;
                    $_SESSION['parola'] = $parola;
                    $_SESSION['telefon'] = $telefon;
                    $_SESSION['verificationCode'] = $verificationCode;

                    header("Location: verificare.php");
                    exit();
                
                }
                else{
                    "Nu exista grupa";
                }
            } else {
                echo "Email-ul există deja. Alegeți un alt email.";
            }
        }
    }
    
    // Închide conexiunea
    $conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Înregistrare</title>
    <meta name="description" content="Aplicatia web pentru gestionarea activitatilor universitare ofera o solutie eficienta pentru administrarea informatiilor legate de studenti, profesori, cursuri si note. Descopera avantajele platformei noastre.">
    <meta name="keywords" content="gestiune universitate, activitati universitare, proiect PHP, student, profesor, admin, baza de date">
</head>
<body>
    <h2>Înregistrare</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Nume: <input type="text" name="nume" required><br>
        Email: <input type="text" name="email" required><br>
        Parolă: <input type="password" name="parola" required><br>
        Facultate:
        <select name="facultate">
            <?php
                include "conexiune.php";
                $query_facultati = "SELECT * FROM FACULTATE";
             
                $result_facultati = $conn->query($query_facultati);

            // Verifică dacă există facultăți înainte de a le afișa
                if ($result_facultati->num_rows > 0) {
                    foreach ($result_facultati as $row) {
                        $selected = ($row['id_facultate'] == $id_facultate_selectat) ? "selected" : "";
                        echo '<option value="'.$row['id_facultate'].'" '.$selected.'>'.$row['nume_facultate']."</option>";
                    }
                
                } else {
                    echo '<option value="" disabled>Nicio facultate disponibilă</option>';
                }
            ?>
            <option SELECTED VALUE="">Select...</option>
        </select><br>
        Nr. Matricol: <input type="text" name="nr_matricol" required><br>
        Grupa: <input type="text" name="grupa" required><br>
        CNP: <input type="text" name="cnp" required><br>
        Data Nașterii: <input type="date" name="data_nastere" required><br>
        Telefon: <input type="text" name="telefon" required><br>
        <input type="submit" name="register" value="Înregistrare">
    </form>

    <p>Înregistrat deja? <a href="https://universitate.great-site.net/login.php">Autentifică-te aici</a>.</p>
</body>
</html>
