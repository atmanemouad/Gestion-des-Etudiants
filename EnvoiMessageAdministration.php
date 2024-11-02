<!DOCTYPE html>
<html>
<head>
  <title>Envoi de Message à l'administration</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1>Envoi de Message à l'administration</h1>
    <?php
    session_start();
    date_default_timezone_set('Africa/Casablanca');
    
    if(isset($_SESSION['id_etudiant'])) {
      $id_etudiant = $_SESSION['id_etudiant'];

      if($_SERVER['REQUEST_METHOD'] === 'POST') {
        require("connecterDataBase.php");

        $sujet_message = $_POST['sujet_message'];
        $contenu_message = $_POST['contenu_message'];
        $date_envoi_message = date("Y-m-d H:i:s");

        $requete = "INSERT INTO message (id_etudiant, sujet_message, contenu_message, date_envoi_message)
                    VALUES (:id_etudiant, :sujet_message, :contenu_message, :date_envoi_message)";

        $statment = $connecter->prepare($requete);
        $statment->execute(array(
          ":id_etudiant" => $id_etudiant,
          ":sujet_message" => $sujet_message,
          ":contenu_message" => $contenu_message,
          ":date_envoi_message" => $date_envoi_message
        ));

        // Afficher un message de succès ou de redirection
        echo '<div class="alert alert-success" role="alert">Le message a été envoyé avec succès !</div>';
        echo '<meta http-equiv="refresh" content="2;url=InformationsPersonnelles.php">';
        exit();
      }
    } else {
      header("location: index.html");
      exit();
    }
    ?>

    <form method="post" action="#">
      <div class="form-group">
        <label for="sujet_message">Sujet du message :</label>
        <input type="text" class="form-control" id="sujet_message" name="sujet_message" required>
      </div>
      <div class="form-group">
        <label for="contenu_message">Contenu du message :</label>
        <textarea class="form-control" id="contenu_message" name="contenu_message" rows="5" required></textarea>
      </div>
      <button type="submit" class="btn btn-primary">CONFIRMER</button>
    </form>

    <a href="InformationsPersonnelles.php" class="btn btn-secondary">Retour</a>
  </div>
</body>
</html>