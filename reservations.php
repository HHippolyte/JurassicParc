<!DOCTYPE HTML>

<?php include("common.php");
session_start();
?>

<html>
	<head>
		<title>Réservations - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'esnsemble du corps --!>
				<!-- Header -->
				<?php include("header.php"); ?>

				<!-- Généralités et formulaires -->
					<div id="main">
						<div class="presentation colonne_alpha col12 centrer">
							<form method="post" action="">


								<fieldset> 
									<section>
									<center><legend><h3>Informations personelles</h3> </legend></center>
									<input type="text" name="nom" placeholder="Nom">
									<input type="text" name="prenom" placeholder="Prénom">
									<input type="text" name="CP" placeholder="Code Postal" maxlength="5">
									<input type="email" name="email" placeholder="Adresse mail" maxlength="30"> <br/>
									</section>
									<section>
										<label for="catégorie" > Quel est votre catégorie ? </label> <br/>
									
											<select name="catégorie" id="catégorie">
												<option value="enfant">Enfant (0-18 ans) </option>
												<option value="adulte">Adulte</option>
												<option value="senior">Senior (à partir de 60 ans)</option>
												<option value="etudiant">Etudiant (sur présentation d'un justificatif)</option>
											</select>
											</label>
									</section>
								</fieldset>

								<fieldset>
									<center><legend><h3>Visites</h3></legend></center>
									<p> Dates souhaitées <br/></p>
									<p>

										<select id="datevisite" name="datevisite" size="1" onChange="THEFUNCTION(this.selectedIndex);">
										<?php

										//Fabrication d'une requête SQL
										$entree='SELECT distinct DATE_VISITE FROM entree';

										//Envoi de la reuqête SELECT
										$result_entree=mysqli_query($connexion,$entree) or die(mysql_error());

										while($data_entree=mysqli_fetch_array($result_entree,MYSQLI_ASSOC))
										{
											//transformer le format string de la date de visite en date
											$datetime1 = new DateTime($data_entree["DATE_VISITE"]);
											//affecter à $datetime2 la date du jour
											$datetime2 = new DateTime('');

											if($datetime1>=$datetime2)
											{
												echo '<option value="'.$data_entree["DATE_VISITE"].'">'.$data_entree["DATE_VISITE"].'</option><br/>';
											}
										}

										;?>
										</select>
										<br/><br/>

									</p>

								</fieldset>

								<fieldset>

									<center><legend><h3>Spectacles</h3></legend></center>
									<p> Choix des spectacles (maximum 3) <br/></p> <!--3 spectales au max-->
									
									<div style="display:none;" id="divSpectacles">

									<label for="spectacle" > Sélectionnez les spectacles :  </label> <br/>

										<?php

											//Fabrication d'une requête SQL
											$requête='SELECT * FROM spectacle S, place_spectacle PS, entree E where S.CODE_SPECTACLE=PS.CODE_SPECTACLE and PS.NUM_ENTREE=E.NUM_ENTREE';

											//Envoi de la requête SELECT
											$result=mysqli_query($connexion,$requête) or die(mysql_error());
											
											while($data=mysqli_fetch_array($result,MYSQLI_ASSOC))
											{
												$datetime3= new DateTime($data['DATE_VISITE']);

												//Pour mieux afficher la date
												$datetime4= $data['DATE_SPECTACLE'];
												$datetime4 = explode ("-", $datetime4); // Transforme la date en array
												$annee = $datetime4[0];
												$mois = $datetime4[1];
												$jour = $datetime4[2];

												//Pour mieux afficher l'heure
												$timedebutspec= explode (":", $data['HEURE_DEBUT_SPECTACLE']);//Transforme l'heure en array
												$heuredebutspec= $timedebutspec[0];
												$mindebutspec= $timedebutspec[1];
												$secdebutspec= $timedebutspec[2];

												$timefinspec= explode (":", $data['HEURE_FIN_SPECTACLE']);//Transforme l'heure en array
												$heurefinspec= $timefinspec[0];
												$minfinspec= $timefinspec[1];
												$secfinspec= $timefinspec[2];

												if($datetime1=$datetime3)
												{
												echo "<input type='checkbox' name='article[]' value='".$data['NOM_SPECTACLE'].' de '.$data['HEURE_DEBUT_SPECTACLE'].' à '.$data['HEURE_FIN_SPECTACLE'].' le '.$data['DATE_SPECTACLE']."'>".$data['NOM_SPECTACLE'].' de '.$heuredebutspec.'h'.$mindebutspec.'  à '.$heurefinspec.'h'.$minfinspec.' le '.$jour.'/'.$mois;
												echo "<br/>";
												}
											}

										;?>


									<script type="text/javascript">
										function THEFUNCTION(i)
										{
											var divSpectacles= document.getElementById('divSpectacles');
											switch(i)
											{
												case 0 : divSpectacles.style.display ='';break;
												default : divSpectacles.style.display='none'; break;
											}
										}
									</script>

									</div>

								</fieldset>

								<fieldset>
									<center><input type="submit" value="Envoyer"/></center>
								</fieldset>

							</form>
						</div>
					</div>
				<!-- Footer -->
				<?php include("footer.php");?>
			</div>
	</body>
</html>
