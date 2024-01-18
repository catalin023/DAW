<?php
    include "conexiune.php";
    session_start();

    error_reporting(E_ALL);
ini_set('display_errors', 1);

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $email = $_POST['email'];
        $password = $_POST['password'];

        $stmt_profesor = $conn->prepare("SELECT * FROM PROFESOR WHERE email=?");
        $stmt_profesor->bind_param("s", $email);
        $stmt_profesor->execute();
        $result_profesor = $stmt_profesor->get_result();

        if ($result_profesor->num_rows > 0) {
            $row = $result_profesor->fetch_assoc();
            if (password_verify($password, $row['parola'])) {
                $_SESSION['email'] = $email;
                header("Location: profesor.php");
                exit();
            } 
        }
        else {
            $stmt_student = $conn->prepare("SELECT * FROM STUDENT WHERE email=?");
            $stmt_student->bind_param("s", $email);
            $stmt_student->execute();
            $result_student = $stmt_student->get_result();

            if ($result_student->num_rows > 0) {
                $row = $result_student->fetch_assoc();
                if (password_verify($password, $row['parola'])) {
                    $_SESSION['email'] = $email;
                    header("Location: student.php");
                    exit();
                } 
            }   
        }
        echo "Email sau parola gresita";
    }

    $conn->close();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Autentificare</title>
    <meta name="description" content="Aplicatia web pentru gestionarea activitatilor universitare ofera o solutie eficienta pentru administrarea informatiilor legate de studenti, profesori, cursuri si note. Descopera avantajele platformei noastre.">
    <meta name="keywords" content="gestiune universitate, activitati universitare, proiect PHP, student, profesor, admin, baza de date">
</head>
<body>
    <h2>Autentificare</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Email: <input type="text" name="email" required><br>
        Parolă: <input type="password" name="password" required><br>
        <input type="submit" value="Autentificare">
    </form>
    <p><a href="https://universitate.great-site.net/signup.php">Inregistreaza-te aici</a>.</p>
</body>
</html>
