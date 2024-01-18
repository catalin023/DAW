<?php

//     error_reporting(E_ALL);
// ini_set('display_errors', 1);

include "conexiune.php";
require_once('phpmailer/phpmailer/class.phpmailer.php');
require_once('phpmailer/phpmailer/mail_config.php');
require('fpdf/fpdf.php');
//require('../mc_table.php');

class PDF extends FPDF
{

	protected $widths;
    protected $aligns;
	protected $min_nb;

    function SetWidths($w)
    {
        // Set the array of column widths
        $this->widths = $w;
    }

	function Setnb($m){
		$this->min_nb = $m;
	}


    function SetAligns($a)
    {
        // Set the array of column alignments
        $this->aligns = $a;
    }

    function Row($data)
    {
        // Calculate the height of the row
        $nb = 0;
        for($i=0;$i<count($data);$i++)
            $nb = max($nb,$this->NbLines($this->widths[$i],$data[$i]));
		if($this->min_nb > $nb)
			$nb = $this->min_nb;
        $h = 6*$nb;
        // Issue a page break first if needed
        $this->CheckPageBreak($h);
        // Draw the cells of the row
        for($i=0;$i<count($data);$i++)
        {
            $w = $this->widths[$i];
            $a = isset($this->aligns[$i]) ? $this->aligns[$i] : 'L';
            // Save the current position
            $x = $this->GetX();
            $y = $this->GetY();
            // Draw the border
            $this->Rect($x,$y,$w,$h);
            // Print the text
            $this->MultiCell($w,6,$data[$i],0,$a);
            // Put the position to the right of the cell
            $this->SetXY($x+$w,$y);
        }
        // Go to the next line
        $this->Ln($h);
    }

    function CheckPageBreak($h)
    {
        // If the height h would cause an overflow, add a new page immediately
        if($this->GetY()+$h>$this->PageBreakTrigger)
            $this->AddPage($this->CurOrientation);
    }

    function NbLines($w, $txt)
    {
        // Compute the number of lines a MultiCell of width w will take
        if(!isset($this->CurrentFont))
            $this->Error('No font has been set');
        $cw = $this->CurrentFont['cw'];
        if($w==0)
            $w = $this->w-$this->rMargin-$this->x;
        $wmax = ($w-2*$this->cMargin)*1000/$this->FontSize;
        $s = str_replace("\r",'',(string)$txt);
        $nb = strlen($s);
        if($nb>0 && $s[$nb-1]=="\n")
            $nb--;
        $sep = -1;
        $i = 0;
        $j = 0;
        $l = 0;
        $nl = 1;
        while($i<$nb)
        {
            $c = $s[$i];
            if($c=="\n")
            {
                $i++;
                $sep = -1;
                $j = $i;
                $l = 0;
                $nl++;
                continue;
            }
            if($c==' ')
                $sep = $i;
            $l += $cw[$c];
            if($l>$wmax)
            {
                if($sep==-1)
                {
                    if($i==$j)
                        $i++;
                }
                else
                    $i = $sep+1;
                $sep = -1;
                $j = $i;
                $l = 0;
                $nl++;
            }
            else
                $i++;
        }
        return $nl;
    }

// Page header
function Header()
{
    $this->SetFont('Arial','',20);
    $this->Cell(100, 10, 'Universitatea din Bucuresti', 0, 1, 'C');
    $this->SetFont('Arial','',10);
    $this->Cell(50, 6, 'Anul 2023-2024', 0, 1, 'L');
    $this->Cell(50, 6, 'Data: '. date("y.m.d"), 0, 1, 'L');
    $this->Ln(10);
}

// Page footer
function Footer()
{

}

}


session_start();

if (!isset($_SESSION['email'])) {
    header("Location: login.php");
    exit();
}

$email = $_SESSION['email'];
$result = $conn->query("SELECT nume_materie, nota, nr_credite FROM NOTA JOIN MATERIE ON NOTA.id_materie = MATERIE.id_materie WHERE nr_matricol = (SELECT nr_matricol FROM STUDENT WHERE email = '$email')");

$materii = array();

if ($result->num_rows > 0) {
    $rows = $result->fetch_all(MYSQLI_ASSOC);

    foreach ($rows as $row) {
        $materii[] = array('nume_materie' => $row['nume_materie'], 'nota' => $row['nota'], 'nr_credite'=> $row['nr_credite']);
    }
}

$result = $conn->query("SELECT student_nume FROM STUDENT WHERE email = '$email'");
$row = $result->fetch_assoc();

$studentName = $row['student_nume'];

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
//echo 'Online users ' . $user_count . '';


// Procesare formular de contact
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {
    if(isset($_POST['g-recaptcha-response']) && !empty($_POST['g-recaptcha-response'])){ 
            // Google reCAPTCHA API secret key 
            $secret_key = '6LddxDcpAAAAALwkyl0kA1_SxLxyUcCAmYBQooYU'; 
             
            // reCAPTCHA response verification
            $verify_captcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret='.$secret_key.'&response='.$_POST['g-recaptcha-response']); 
            
            // Decode reCAPTCHA response 
            $verify_response = json_decode($verify_captcha); 
             
            // Check if reCAPTCHA response returns success 
            if($verify_response->success){ 
                $intrebare = $_POST['intrebare'];

                // $to = "rapceacatalinc@gmail.com";
                // $subject = "This is a test";
                // $message = "This is a PHP plain text email example.";
                // $headers = "From: rapceacatalinc@gmail.com";
                // if(mail($to, $subject, $message, $headers))
                //     // Poți adăuga și un mesaj pentru utilizator pentru a confirma că întrebarea a fost trimisă
                //     $confirmare = "Intrebarea ta a fost trimisă cu succes!";
                // else {$confirmare =  error_get_last()['message'];}



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
                $mail->AddAddress("rapceacatalinc@gmail.com", "Rapcea Catalin");
                
                $mail->SetFrom($email, $studentName);
                $mail->Subject = 'Intrebare';
                $mail->AltBody = 'To view this post you need a compatible HTML viewer!'; 
                $mail->MsgHTML($intrebare);
                $mail->Send();
                $confirmare = "Mesaj trimis";
                } catch (phpmailerException $e) {
                echo $e->errorMessage(); //error from PHPMailer
                } catch (Exception $e) {
                echo $e->getMessage(); //error from anything else!
                }
            } else{ 
            
			$confirmare = 'Please check the CAPTCHA box.'; 
        }
    }
            
}


if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['generate_pdf'])) {

    // Create a PDF object
    $pdf = new PDF('P','mm','A4');

//A4 => w:210 h: 297
    $left=9;
    $right=9;
    $pdf->SetLeftMargin($left);
    $pdf->SetRightMargin($right);
    $pdf->SetFont('Times', 'B', 12);
    $centru=192;
    $pdf->AddPage();

    $dim = array(15, 60, 30, 25, 35);
    $pdf->SetWidths($dim);
    $pdf->SetAligns('C');
    $pdf->SetDrawColor(47,140,158);
	$pdf->SetTextColor(0,0,0);
	$pdf->SetLineWidth(0.1);
    $pdf->Row(array('Nr.crt.', 'Materia', 'Nota', 'Nr. credite', 'Nr. puncte credite'));

    $nr = 1;

    $pdf->SetFont('Times', '', 12);
    foreach ($materii as $materie) {
        $pdf->Row(array($nr, $materie['nume_materie'], $materie['nota'], $materie['nr_credite'], ($materie['nota']>=5) ? $materie['nota']*$materie['nr_credite']: 0));
        $nr++;
    }



    // Output the PDF
    $pdf->Output('note.pdf', 'D');
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Nota Student</title>
    <meta name="description" content="Aplicatia web pentru gestionarea activitatilor universitare ofera o solutie eficienta pentru administrarea informatiilor legate de studenti, profesori, cursuri si note. Descopera avantajele platformei noastre.">
    <meta name="keywords" content="gestiune universitate, activitati universitare, proiect PHP, student, profesor, admin, baza de date">
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-JZH2BPFZK7"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-JZH2BPFZK7');
    </script>
</head>
<body>
    <p>Online users: <?php echo $user_count?></p>
    <h2>Notele Tale</h2>
    <ul>
        <?php foreach ($materii as $materie): ?>
            <li><?php echo $materie['nume_materie'] . ": " . $materie['nota']; ?></li>
        <?php endforeach; ?>
    </ul>

    <br>
    <br>

    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Desccarca note.pdf: <input type="submit" name="generate_pdf" value="Generate PDF">
    </form>


    <br>
    <br>

    <h2>Contactează-ne</h2>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        Intrebare: <textarea name="intrebare" rows="4" cols="50" required></textarea><br>
        <div class="g-recaptcha" data-sitekey = "6LddxDcpAAAAAO69CGOhUyQqqMAsrjq07bapsJ-q"></div>
        <input type="submit" name="submit" value="Trimite Intrebarea">
    </form>

    <?php if (isset($confirmare)): ?>
        <p><?php echo $confirmare; ?></p>
    <?php endif; ?>

    <br>
    <br>
    <h2>News</h2>
    <?php
        $apiKey = 'c705450a2da94d03a0b8cf531d03e76a';
        $endpoint = 'https://newsapi.org/v2/everything';
        $params = [
            'q' => 'programming',
            'language' => 'en',
            'pageSize' => '5',
            'apiKey' => $apiKey,
        ];

        $url = $endpoint . '?' . http_build_query($params);
        //echo $url;
        $newsData = json_decode(file_get_contents($url), true);

        if (isset($newsData['status']) && $newsData['status'] === 'ok') {
            // Obținem primele 5 articole
            $articles = array_slice($newsData['articles'], 0, 5);

            // Parcurgem și afișăm informațiile pentru fiecare articol
            foreach ($articles as $article) {
                echo '<h3>' . $article['title'] . '</h3>';
                echo '<p>' . $article['description'] . '</p>';
                echo '<a href="' . $article['url'] . '" target="_blank">Citeste mai mult</a>';
                echo '<hr>';
            }
        } else {
            // Afișăm un mesaj de eroare în cazul în care răspunsul API nu este valid
            echo 'Eroare: Nu s-au putut obține știrile.';
        }
    ?>

    <br>
    <br>
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <input type="submit" name="logout" value="Logout">
    </form>


</body>
</html>
