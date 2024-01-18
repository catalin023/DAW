<?php    
    include 'conexiune.php';
    session_start();

    if (!isset($_SESSION['email']) && !isset($_SESSION['verificationCode'])) {
        header("Location: login.php");
        exit();
    }
    
    $nr_matricol = $_SESSION['nr_matricol'];
    $id_grupa = $_SESSION['id_grupa'];
    $cnp = $_SESSION['cnp'];
    $nume = $_SESSION['nume'];
    $data_nastere = $_SESSION['data_nastere'];
    $email = $_SESSION['email'];
    $parola = $_SESSION['parola'];
    $telefon = $_SESSION['telefon'];
    $verificationCode = $_SESSION['verificationCode'];


    // unset($_SESSION['nr_matricol']);
    // unset($_SESSION['id_grupa']);
    // unset($_SESSION['cnp']);
    // unset($_SESSION['nume']);
    // unset($_SESSION['data_nastere']);
    // unset($_SESSION['parola']);
    // unset($_SESSION['telefon']);
    // unset($_SESSION['verificationCode']);

    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['verifica'])) {
        $cod_verificare = $_POST['cod_verificare'];

        if($cod_verificare == $verificationCode){
            // Inserează datele în baza de date
           $stmt_insert = $conn->prepare("INSERT INTO STUDENT VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt_insert->bind_param("ssssssss", $nr_matricol, $id_grupa, $cnp, $nume, $data_nastere, $email, $parola, $telefon);
            if ($stmt_insert->execute()) {
                // Selectarea materiilor pentru grupa respectivă
                $stmt_materii = $conn->prepare("SELECT id_materie FROM MATERIE WHERE id_specialitate = (SELECT id_specialitate FROM GRUPA WHERE id_grupa = ?)");
                $stmt_materii->bind_param("s", $id_grupa);
                $stmt_materii->execute();
                $result_materii = $stmt_materii->get_result();

                if ($result_materii->num_rows > 0) {
                    $materii_rows = $result_materii->fetch_all(MYSQLI_ASSOC);
                    $materii = array_column($materii_rows, 'id_materie');

                    // Inserarea notelor pentru fiecare materie
                    $stmt_insert_nota = $conn->prepare("INSERT INTO NOTA VALUES (?, ?, 0)");
                    $stmt_insert_nota->bind_param("ss", $nr_matricol, $id_materie);

                    foreach($materii as $id_materie) {
                        $stmt_insert_nota->execute();
                    }
                }

                header("Location: student.php");
                exit();
            } else {
                echo "Eroare la înregistrare: " . $stmt_insert->error;
            }

            $stmt_insert->close();
            $stmt_materii->close();
            $stmt_insert_nota->close();
        } else {
            echo "Cod gresit";
        }
    }


?>


<!DOCTYPE html>
<html>
<head>
    <title>Înregistrare</title>
</head>
<body>
    <h2>Înregistrare</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Cod: <input type="text" name="cod_verificare" required><br>
        <input type="submit" name="verifica" value="Verifica">
    </form>

</body>
</html>
