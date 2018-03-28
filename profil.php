<?php 
session_start();
?>
<!DOCYPE html>


<html>
	<head>
		<title>Mon profil - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
		<div id="conteneur"> 
				<!-- Header -->
					<?php include("header.php"); ?> 
			<div class="colonne_alpha col12 centrer">
				<div class="cadre">
					<div class="titre">
						Vos informations
					</div>

						<?php

							$connexion=mysqli_connect("localhost","root","","zoopedia")
							or die(mysql_error());


								$affiprofil='SELECT * FROM employe';
								$result_connexion=mysqli_query($connexion,$affiprofil) or die(mysql_error());

									//Affichage des informations de l'employé
									$data_connexion=mysqli_fetch_array($result_connexion,MYSQLI_ASSOC);
									if ($_SESSION['nom']==$data_connexion['NOM_EMPLOYE'] and $_SESSION['prenom']==$data_connexion['PRENOM_EMPLOYE'] )
										{
												echo "Votre nom : " .$data_connexion['NOM_EMPLOYE']."<br/>";
												echo "Votre prénom : " .$data_connexion['PRENOM_EMPLOYE']."<br/>";
												echo "Votre mail : " .$data_connexion['MAIL_EMPLOYE']."<br/>";
												echo "Votre téléphone : " .$data_connexion['TEL_EMPLOYE']."<br/>";
												echo "Votre fonction : " .$data_connexion['FONCTION_EMPLOYE']."<br/>";

											}
								else 
									{
										echo "Un problème est survenu";
									}
						?>
				</div>
				<div class="cadre">
						<div class="titre">
							Modification du mot de passe:
						</div>
	
						<form method="post">
							<label for="passwordactuel" >Votre mot de passe : </label><br/>
							<input type="password" name="passwordactuel"> <br/>
							<label for="password" >Votre nouveau mot de passe : </label><br/>
							<input type="password" name="password"> <br/>
							<label for="password_confirm" >Votre nouveau mot de passe : </label><br/>
							<input type="password" name="password_confirm"> <br/>
							<input type="submit" value='envoyer'>
					    </form>
				</div>
				<div class="contenu">
							<?php
							$connexion=mysqli_connect("localhost","root","","zoopedia")
							or die(mysql_error());





										if(!empty($_POST)){
							$amdp=$_POST['passwordactuel'];
							$modp=$_POST['password'];
							$nmdp=$_POST['password_confirm'];
							$login=$_SESSION['nom'];
							$prenom=$_SESSION['prenom'];
							    				if ($modp==$nmdp)
							       				{
							       					$prepare="UPDATE employe SET PASS_EMPLOYE='$nmdp' WHERE NOM_EMPLOYE='$login' AND PRENOM_EMPLOYE='$prenom'";
							       					$resultat=mysqli_query ($connexion,$prepare);
							       					echo "Votre mot de passe est bien mis à jour";
							       					$_SESSION['PASS_EMPLOYE']=$nmdp;
							       					header ('location: connexion.php');
							       				}
							       				else 
							       				{
							       					echo "Vos deux nouveaux mots de passe ne correspondent pas !";
							       				}

							       			}
							       			
							       		
							       		else 
							       		{
							       			echo "champs incomplets !";
							       		}
											
									 ?>

				</div>					 
			</div>
		</div>
	</body>
	<!-- Footer-->
	<?php include("footer.php");?>
</html>



