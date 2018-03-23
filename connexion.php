<!DOCYPE html>

<html>
	<head>
		<title>Réservations - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->
					<?php include("header.php"); ?> 
							<!-- Logo -->
					<div> 
						<form method="post">
						<p><center><legend><h3>Informations personelles</h3> </legend></center></p>

								<p>
									<label for="code_employe"> Votre numéro d'employé : </label>
									<input type="text" name="CODE_EMPLOYE">
									<label for="pass_employe" >Votre mot de passe : </label>
									<input type="password" name="PASS_EMPLOYE">
									<input type="submit" value='envoyer'>
								</p>
						</form>
				<div>

<?php


//Connexion au serveur MySQL et sélection de la base
$connexion=mysqli_connect("localhost","root","","zoopedia")
or die(mysql_error());

//Vérification que le formulaire n'est pas vide
if(!empty($_POST))
{
//Renommer les données reçues du formulaire
$codemp=$_POST['CODE_EMPLOYE'];
$passemp=$_POST['PASS_EMPLOYE'];
		//Fabrication de la requête SQL
		$requete_connexion='SELECT * FROM employe';

		//Envoi de la requête SELECT
		$result_connexion=mysqli_query($connexion,$requete_connexion) or die(mysql_error());

		//Récupération des données de la requête
		$data_connexion=mysqli_fetch_array($result_connexion,MYSQLI_ASSOC);

			if ($codemp==$data_connexion['CODE_EMPLOYE'] and $passemp==$data_connexion['PASS_EMPLOYE'] )
			{
				session_start();
			    $_SESSION['nom'] = $data_connexion['NOM_EMPLOYE'];
			    $_SESSION['prenom'] = $data_connexion['PRENOM_EMPLOYE'];
			    $_SESSION['numemploye'] = $data_connexion['CODE_EMPLOYE'];
			    header('Location: employe.php');
			    

			}
			else
			{
			    echo 'Mauvais identifiant ou mot de passe !';
		    }
}

?>

			</div>
	</body>
</html>