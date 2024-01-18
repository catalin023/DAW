<?php
// error_reporting(E_ALL);
// ini_set('display_errors', 1);

include "conexiune.php";
require 'jpgraph/src/jpgraph.php';
require 'jpgraph/src/jpgraph_pie.php';
require 'jpgraph/src/jpgraph_pie3d.php';
session_start();

if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

$email_profesor = $_SESSION['email'];
$result = $conn->query("SELECT id_profesor FROM PROFESOR WHERE email = '$email_profesor'");
$id_profesor = $result->fetch_assoc()['id_profesor'];

$result_materii = $conn->query("SELECT id_materie, nume_materie FROM MATERIE WHERE id_profesor = '$id_profesor'");

$materii = array(); 

if ($result_materii->num_rows > 0) {
    $materii = $result_materii->fetch_all(MYSQLI_ASSOC);
}

if (isset($_POST['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

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
echo 'Online users ' . $user_count . '';


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    foreach ($_POST['note'] as $nr_matricol => $note_materii) {
        foreach ($note_materii as $id_materie => $nota) {
            $nota = $conn->real_escape_string($nota);
            if($nota>=0 && $nota<=10)
                $conn->query("UPDATE NOTA SET nota = '$nota' WHERE nr_matricol = '$nr_matricol' AND id_materie = '$id_materie'");
        }
    }
    header("Location: profesor.php");
    exit();
}


?>

<!DOCTYPE html>
<html>
<head>
    <title>Notare Studenți</title>
    <meta name="description" content="Aplicatia web pentru gestionarea activitatilor universitare ofera o solutie eficienta pentru administrarea informatiilor legate de studenti, profesori, cursuri si note. Descopera avantajele platformei noastre.">
        <meta name="keywords" content="gestiune universitate, activitati universitare, proiect PHP, student, profesor, admin, baza de date">
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-JZH2BPFZK7"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-JZH2BPFZK7');
    </script>
</head>
<body>
    <h2>Notare Studenți</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <?php
            $nr=0;

         foreach ($materii as $materie): ?>
            <h3><?php echo $materie['nume_materie']; ?></h3>
            
            <?php
            $id_materie = $materie['id_materie'];
            // Obține lista de grupe pentru materia curentă
            $result_grupe = $conn->query("SELECT id_grupa, numar_grupa FROM GRUPA WHERE id_specialitate = (SELECT id_specialitate FROM MATERIE WHERE id_profesor = '$id_profesor' AND id_materie = '$id_materie')");
            
            // Verifică dacă există grupe
            if ($result_grupe->num_rows > 0) {
                $grupe = $result_grupe->fetch_all(MYSQLI_ASSOC);

                foreach ($grupe as $grupa) {
                    $id_grupa = $grupa['id_grupa'];
                    $numar_grupa = $grupa['numar_grupa'];

                    $result_stud = $conn->query("SELECT s.nr_matricol, s.student_nume, n.nota FROM STUDENT s JOIN NOTA n ON n.nr_matricol = s.nr_matricol WHERE s.id_grupa = '$id_grupa' AND n.id_materie = '$id_materie'");
                    $note_stud = $result_stud->fetch_all(MYSQLI_ASSOC);

                    $promovati = 0;
                    $restantieri = 0;
            ?>
            
            <h4>Grupa: <?php echo $numar_grupa; ?></h4>
            
            <table border="1">
                <tr>
                    <th>Nr. Matricol</th>
                    <th>Nume Student</th>
                    <th>Nota</th>
                </tr>
                <?php foreach ($note_stud as $stud) : ?>
                    <tr>
                        <td><?php echo $stud['nr_matricol']; ?></td>
                        <td><?php echo $stud['student_nume']; ?></td>
                        <td><input type="text" name="note[<?php echo $stud['nr_matricol']; ?>][<?php echo $id_materie; ?>]" value="<?php echo $stud['nota']; ?>" /></td>
                    </tr>
                <?php if($stud['nota']>=5) $promovati++; else $restantieri++;
                endforeach; ?>
            </table>
            <br>
            <?php
                $fimg ='jpgraph-3d_pie'.$nr.'.png';

                $graph = new PieGraph(300,200);
                $theme_class= new VividTheme;
                $graph->SetTheme($theme_class);

                $graph->title->Set('Rata de promovare');
                $graph->title->SetFont(FF_FONT1,FS_BOLD);
                $data = array($promovati, $restantieri);

                $p1 = new PiePlot3D($data);
                $p1->ExplodeSlice(1);
                $p1->SetCenter(0.5);
                $p1->SetLegends(array("promovati", "restantieri"));
                $graph->legend->Pos(.088,0.8);

                $graph->Add($p1);
                $graph->Stroke($fimg);

                if(file_exists($fimg)) echo '<img src="'. $fimg .'" />';
                else echo 'Unable to create: '. $fimg;
                                          
                $nr++;

                }

            }

            ?>
        <?php endforeach;    
        ?>
        <br>
        <input type="submit" value="Actualizare Note">
    </form>

    <br>
    <br>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <input type="submit" name="logout" value="Logout">
    </form>

</body>
</html>
