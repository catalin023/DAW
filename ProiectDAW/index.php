<?php
$REMOTE_ADDR = $_SERVER['HTTP_X_FORWARDED_FOR'];
$current_users_file = 'users.txt';
if (!file_exists($current_users_file)) fclose(fopen($current_users_file, "w"));
$users = file($current_users_file);
$found = false;
$user_count = count($users);
$fp = fopen($current_users_file, "w");
foreach($users as $user) {
    $user = explode("|", $user);
    if ($user[1]+300 < time()) {
        $user_count--;
        continue;
    } elseif ($user[0] == $REMOTE_ADDR) {
        $user[1] = time();
        $found = true;
    }
    $user = trim(implode("|", $user))."";
    fputs($fp, $user);
}
if (!$found) {
    fputs($fp, $REMOTE_ADDR."|".time()."");
    $user_count++;
}
fclose($fp);

?>

<!DOCTYPE html>
<html lang="ro">
    <head>
        <title>Gestiunea Activităților Universitare - Proiect PHP</title>
        <meta name="description" content="Aplicatia web pentru gestionarea activitatilor universitare ofera o solutie eficienta pentru administrarea informatiilor legate de studenti, profesori, cursuri si note. Descopera avantajele platformei noastre.">
        <meta name="keywords" content="gestiune universitate, activitati universitare, proiect PHP, student, profesor, admin, baza de date">

        <meta charset="UTF-8">
        <meta name="charset" content="utf-8">
        <meta name="author" content="Catalin">
        <link rel="stylesheet" href="style-index.css">
        <!-- <link rel="icon" href="./icon.png"> -->
        <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <script type="text/javascript" src="index.js"></script> -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-JZH2BPFZK7"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'G-JZH2BPFZK7');
        </script>
    </head>
    <body>
        <header>
            <div class = "title"> 
                <h2 class="proiect">Proiect PHP</h2>
                <h2 class="nume">Gestiunea activitatilor din Universitate</h2>
            </div>        
        </header>
        <main>
            <div>
                <h3>Descriere</h3>
                <p>Aplicatia web este dedicata gestionării activităților universitare reprezintand o platformă esențială, oferind o soluție eficientă pentru administrarea și monitorizarea
                        informațiilor legate de studenți, profesori, cursuri și note. Acest website, denumit oferă o serie de caracteristici și funcționalități cheie pentru a simplifica procesele
                        academice și pentru a aduce avantaje atât pentru elevi, cât și pentru cadrele didactice și personalul administrativ.</p>
            </div>
            <div>
                <h3>Utilitati</h3>
                <ul>
                    <li>Bază de date completă cu informații detaliate despre toți studenții si profesorii înregistrați</li>
                    <li>Actualizarea si monitorizarea usoara a datelor si a rezultatelor obtinute la examene</li>
                    <li>informații suplimentare despre cursuri</li>
                    <li>Clasificarea studentilor pe speccializari si grupe</li>
                </ul>
            </div>
            <div>
                <h3>Utilizatori</h3>
                <ol>
                    <li>Admin</li>
                        <ul>
                            <li>Toate drepturile: inserarea, modificarea, stergerea datelor din baza de date</li>
                        </ul>
                    <li>Profesor</li>
                    <ul>
                        <li>Inserarea sau modificarea notelor studentilor</li>
                        <li>Vizualizarea notelor doar pentru cursurile care preda</li>
                    </ul>
                    <li>Student</li>
                        <ul>
                            <li>Vizualizarea notelor personale din tabel</li>
                        </ul>
                </ol>
            </div>
            <div>
                <h3>Diagrama conceputala</h3>
                <div class="img"><img src="./baza.jpg" alt="Diagrama Conceptuala - Gestiunea Activitatilor Universitare"></div>
            </div>
        
        </main>
    </body>
</html>
