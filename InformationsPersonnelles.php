<!DOCTYPE html>
<html>
<head>
  <title>Informations Personnelles</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
  <div class="container text-center">
    <h1>Informations Personnelles</h1>
    <?php
    session_start();

    if(isset($_SESSION['id_etudiant'])) {
      $id_etudiant = $_SESSION['id_etudiant'];

      require("connecterDataBase.php");

      $requete = "SELECT e.*, f.nom_filiere
                  FROM etudiant e
                  INNER JOIN groupe g ON e.id_groupe = g.id_groupe
                  INNER JOIN filiere f ON g.id_filiere = f.id_filiere
                  WHERE e.id_etudiant = :id";

      $statment = $connecter->prepare($requete);
      $statment->execute(array(":id" => $id_etudiant));
      $etudiant = $statment->fetch();

      if ($etudiant) {
        echo '<div class="container text-center">';
        if ($etudiant['photo_etudiant']) {
          $photo_etudiant = base64_encode($etudiant['photo_etudiant']);
          echo '<img src="data:image/jpeg;base64,' . $photo_etudiant . '" alt="Photo de l\'étudiant" class="img-thumbnail" style="width: 200px; height: 200px;">';
        } else {
          echo "AUCUNE IMAGE";
        }
        echo '</div>';

        $date_naissance = new DateTime($etudiant['date_de_naissance_etudiant']);
        $maintenant = new DateTime();
        $age = $date_naissance->diff($maintenant);
        $age = $age->y;

        echo '<table class="table">';
        echo '<tr><th>Nom</th><td>' . $etudiant['nom_etudiant'] . '</td></tr>';
        echo '<tr><th>Prénom</th><td>' . $etudiant['prenom_etudiant'] . '</td></tr>';
        echo '<tr><th>Date de naissance</th><td>' . $etudiant['date_de_naissance_etudiant'] . '</td></tr>';
        echo '<tr><th>Âge</th><td>' . $age . ' ans</td></tr>';
        echo '<tr><th>CIN</th><td>' . $etudiant['cin_etudiant'] . '</td></tr>';
        echo '<tr><th>Adresse</th><td>' . $etudiant['adresse_etudiant'] . '</td></tr>';
        echo '<tr><th>Filière</th><td>' . $etudiant['nom_filiere'] . '</td></tr>';
        echo '</table>';
      } 
    } else {
      header("location: index.html");
      exit();
    }
    ?>
    <a href="EnvoiMessageAdministration.php" class="btn btn-primary">Envoyer message à l'administration</a>
    <a href="LogOutEtudiant.php" class="btn btn-primary">Déconnexion</a>
  </div>
</body>
</html>