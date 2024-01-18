<?php
    $servername = "sql302.infinityfree.com";
    $username = "if0_35358345";
    $password = "Bu7EV6dW7i8y";
    $dbname = "if0_35358345_universitate";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Conexiune eșuată: " . $conn->connect_error);
    }
?>
