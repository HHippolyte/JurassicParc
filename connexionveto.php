<!DOCYPE html>

<html>
	<head>
		<title>connexion veto - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
		<div id="conteneur"> 
			<!-- Header -->
			<?php include("header.php"); ?>
				<div class="formulaire"> 
					<form method="get">
						<p><center><legend><h1>Connexion à l'Espace Vétérinaire</h1> </legend></center></p>

						<p>
							<label for="code_veto"> <h3>Votre code ordinal :</h3> </label>
							<input type="text" name="code_veto">
							<label for="pass_veto" ><h3>Votre mot de passe :</h3> </label>
							<input type="password" name="pass_veto">
							<input type="submit" value='envoyer'>
						</p>
					</form>
				</div>
				<div class="contenu centrer">
					<?php

					//Connexion au serveur MySQL et sélection de la base
					$connexion=mysqli_connect("localhost","root","","zoopedia")
					or die(mysql_error());

					//Vérification que le formulaire n'est pas vide
					if(!empty($_GET))
					{
					//Renommer les données reçues du formulaire
					$codevet=$_GET['code_veto'];
					$passvet=$_GET['pass_veto'];
							//Fabrication de la requête SQL
							$requete_connexion='SELECT * FROM veterinaire';

							//Envoi de la requête SELECT
							$result_connexion=mysqli_query($connexion,$requete_connexion) or die(mysql_error());

							//Récupération des données de la requête
							$data_connexion=mysqli_fetch_array($result_connexion,MYSQLI_ASSOC);
								if ($codevet==$data_connexion['CODE_ORDINAL_VETERINAIRE'] and $passvet==$data_connexion['PASS_VETO'] )
								{
									session_start();
								    $_SESSION['nom'] = $data_connexion['NOM_VETERINAIRE'];
								    $_SESSION['prenom'] = $data_connexion['PRENOM_VETERINAIRE'];
								    $_SESSION['numveto'] = $data_connexion['CODE_ORDINAL_VETERINAIRE'];
								    header('Location: veterinaire.php');
								    

								}
								else
								{
								    echo 'Mauvais identifiant ou mot de passe !';
							    }
					}
					?>
				</div>
		</div>

		<!-- Footer-->
		<?php include("footer.php");?>
	</body>
</html>
