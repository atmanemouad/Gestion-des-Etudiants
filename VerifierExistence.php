<?php
session_start();
$nom = $_POST['nom'];
$prenom = $_POST['prenom'];
$cin = $_POST['cin'];
$date_naissance = $_POST['date_naissance'];
if (!isset($_POST["nom"])) {
    header("location: LogInEtudiant.html");
    exit();
}

if (
    !empty($nom) && isset($nom) && !empty($prenom) && isset($prenom) && !empty($cin) && isset($cin)
    && !empty($date_naissance)) {
    require("connecterDataBase.php");

    $requete = "SELECT * 
    FROM etudiant
    WHERE nom_etudiant = :nom AND prenom_etudiant = :prenom AND cin_etudiant = :cin AND date_de_naissance_etudiant = :date_naissance";

    $statment = $connecter->prepare($requete);
    $statment->execute(array(":nom" => $nom, ":prenom" => $prenom, ":cin" => $cin, ":date_naissance" => $date_naissance));
    $data = $statment->fetch();

    if ($data != null) {
        $id_etudiant = $data['id_etudiant'];
        $_SESSION['id_etudiant'] = $id_etudiant;
        header("location: InformationsPersonnelles.php");
        exit();
    } else {
        header("location: index.html");
        exit();
    }
}
?>
