<?php include("common.php");
session_start();
?>
<!DOCYPE html>
<html>
	<head>
		<title>Confirmationplacement animal - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>

	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->
				<?php include("header.php"); ?> 
				<div class="colonne_alpha col12 center">
					<div class="cadre centrer">
						<h2> confirmation du placement </h2>
							<?php 
								if(!empty($_POST))
									{

										//Connexion au serveur MySQL et sélection de la base

										$numespace=substr($_POST['choixespace'], "11");
										

										if(isset($_POST['numanimal']))
										{$numanimal=$_POST['numanimal'];}
										if(isset($_POST['datedebplace']))
											{$datedebplace=$_POST['datedebplace'];}
										if(isset($_POST['datefinplace']))
											{$datefinplace=$_POST['datefinplace'];}

									$insertion="INSERT INTO placement VALUES ('','$numespace','$numanimal','$datedebplace','$datefinplace')";

				          				$resultat=mysqli_query($connexion,$insertion);
				
				          				
										echo "L'animal ID numéro ".$numanimal." a bien été placé dans l'espace selectionné <br/>";

									}
									else 
									{
										echo "Veuillez renseigner l'ensemble des champs !";
									}
							?>
					</div>

				</div>
				<!-- Footer -->
				<?php include("footer.php");?>
			</div>
	</body>
</html>
