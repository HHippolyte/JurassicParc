<?php include("common.php");
session_start();
?>
<!DOCYPE html>
<html>
	<head>
		<title>Placement animal - ZooPedia</title>
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
						<h2>Placement des animaux existants dans les différents espaces du zoo</h2>
						<h3>Veuillez rentrer l'ID de l'animal à placer:</h3>
						<form method="post">
							<input type="number" name="animal"  value="<?php if(isset($_POST['animal'])){echo $_POST['animal'];} ?>">
							<input type="submit">
						</form>
					</div>
					<div class="cadre centrer">
						<h3> Informations de l'animal selectionné:</h3>
						<?php
						if(!empty($_POST))
											{
												//Vérification des champs
												if(isset($_POST['animal']) && $_POST['animal'] !="")
													{$animal=$_POST['animal'];}
											}
						$requete="SELECT NUM_ANIMAL, NOM_ANIMAL, e.LIBELLE_ESPECE, DATE_NAISSANCE_ANIMAL FROM animal AS a INNER JOIN espece AS e ON a.CODE_ESPECE=e.CODE_ESPECE  WHERE NUM_ANIMAL=$animal";
						$result_animal=mysqli_query($connexion,$requete) or die(mysql_error());
												while($ligne=mysqli_fetch_array($result_animal)){
															
													echo 'ID animal: '.$ligne["NUM_ANIMAL"].'" - Nom animal: "'.$ligne["NOM_ANIMAL"].'" - Espece animal: "'.$ligne["LIBELLE_ESPECE"].'"- Date naissance animal: "'.$ligne["DATE_NAISSANCE_ANIMAL"];
												}


						?>
						<form action="confirmationplacement.php" method="post">
							<h3>Veuillez choisir un espace:</h3>
							<select name="choixespace">
								<?php
								
										
									if(!empty($_POST))
											{
												//Vérification des champs
												if(isset($_POST['animal']) && $_POST['animal'] !="")
													{$animal=$_POST['animal'];}
											}

									$proc="CALL SP_espaces_correspondant_p_numanimal($animal)";
									$result_espace=mysqli_query($connexion,$proc) or die(mysql_error());
												while($ligne=mysqli_fetch_array($result_espace))
													{
																
														echo '<option value="ID espace: '.$ligne["NUM_ESPACE"].'" - libelle espace: "'.$ligne["LIBELLE_ESPACE"].'" - localisation espace: "'.$ligne["LOCALISATION_ESPACE"].'"</option> ID espace: '.$ligne["NUM_ESPACE"].' - libelle espace: '.$ligne["LIBELLE_ESPACE"].' - localisation espace: '.$ligne["LOCALISATION_ESPACE"].'<br/>';
													}
									

								?>
							</select>
							<br/>
						<h3>Dates prévues du placement de l'animal:</h3>
						
									
									<input type="hidden" name="numanimal" value="<?php if(isset($_POST['animal'])){echo $_POST['animal'];} ?>">
									<p><label for="datedebplace" > Date de placement dans cet espace: </label></p>
									<input type="date" name="datedebplace"> <br/> 
									<p><label for="datefinplace"> Date de fin de placement dans cet espace : </label></p>
									<input type="date" name="datefinplace"> <br/> 
									<input type="submit" value="Enregistrer le placement">
						</form>
					</div>
				</div>
				<!-- Footer -->
				<?php include("footer.php");?>
			</div>
	</body>
</html>
