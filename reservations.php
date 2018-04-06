
<!DOCTYPE HTML>

<?php 
//Connexion au serveur MySQL et sélection de la base
$connexion=mysqli_connect("localhost","root","","zoopedia")
or die(mysql_error());
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
							<form method="post">


								<fieldset> 
									<section>
									<center><legend><h3>Informations personnelles</h3> </legend></center>
									<input type="text" name="nom" placeholder="Nom">
									<input type="text" name="prenom" placeholder="Prénom">
									<input type="text" name="CP" placeholder="Code Postal" maxlength="5"><br/>
									<input type="email" name="email" placeholder="Adresse mail" maxlength="30"> <br/>
									</section>
								</fieldset>

								<fieldset>
									<section>
										<label for="catégorie" > Catégorie du visiteur : </label>
														
											<select name="categorie" id="categorie">
												<option value="Enfant">Enfant (0-18 ans) </option>
												<option value="Adulte">Adulte</option>
												<option value="Senior">Senior (à partir de 60 ans)</option>
												<option value="Etudiant">Etudiant (sur présentation d'un justificatif)</option>
											</select>
										</label>
									</section>
								</fieldset>

								<fieldset>
									<center><legend><h3>Visites</h3></legend></center>
									<p> Dates souhaitées <br/></p>	

									<input type="date" name="datevisite"><br/><br/>
									<center><input type="submit" value="Spectacles et ateliers du jour"/></center>

									<div class="contenu">
									<?php

									if(!empty($_POST))
									{
										//Vérification des champs
										if(isset($_POST['nom']) && $_POST['nom'] !="")
											{$nom=$_POST['nom'];}
										if(isset($_POST['prenom']) && $_POST['prenom'] !="")
											{$prenom=$_POST['prenom'];}
										if(isset($_POST['CP']) && $_POST['CP'] !="")
											{$CP=$_POST['CP'];}
										if(isset($_POST['email']) && $_POST['email'] !="")
											{$email=$_POST['email'];}
										if(isset($_POST['categorie']) && $_POST['categorie'] !="")
											{$categorie=$_POST['categorie'];}
										if(isset($_POST['datevisite']) && $_POST['datevisite'] !="")
											{$datevisite=$_POST['datevisite'];}
										else{die;}

										//Si tout est okay, on enregistre visiteur dans BDD
										if(isset($nom) && isset($prenom) && isset($CP) && isset($email) && isset($categorie))
										{
											$nouveauvisiteur="INSERT INTO visiteur VALUES (NULL,'$nom','$prenom','$categorie','$CP','$email')";
										}

										//Envoi de la requête insert into
										$result_nouveauvisiteur=mysqli_query($connexion,$nouveauvisiteur);
										echo "Bonjour ".$nom." ".$prenom." vous trouverez ci-dessous les spectacles et les ateliers ayant lieu le jour de votre visite du zoo <br/>";

										//On enregistre entree dans BdD
										if(isset($categorie) && isset($datevisite))
										{
											if($categorie=="Enfant")
											{
												$nouvelleentree="INSERT INTO entree 
																	(
																				NUM_ENTREE,
																				CODE_TARIF_TICKET,
																				CODE_EMPLOYE,
																				DATE_ACHAT_ENTREE,
																				DATE_VISITE,
																				PRIX_ENTREE, 
																				CODE_VISITEUR
																	) 
																VALUES (
																				NULL, 
																				1, 
																				2, 
																				CURRENT_DATE(), 
																				date_format('$datevisite','%Y-%m-%d'), 
																				10 ,
																				(SELECT CODE_VISITEUR FROM visiteur ORDER BY CODE_VISITEUR DESC LIMIT 1)
																		)";
												$prixentree=10*0.5;
												echo "Tarif entree enfant : $prixentree euros";
											}

											if($categorie=="Etudiant")
											{
												$nouvelleentree="INSERT INTO entree 
																	(
																				NUM_ENTREE,
																				CODE_TARIF_TICKET,
																				CODE_EMPLOYE,
																				DATE_ACHAT_ENTREE,
																				DATE_VISITE,
																				PRIX_ENTREE, 
																				CODE_VISITEUR
																	) 
																VALUES (
																				NULL, 
																				2, 
																				2, 
																				CURRENT_DATE(), 
																				date_format('$datevisite','%Y-%m-%d'), 
																				10 ,
																				(SELECT CODE_VISITEUR FROM visiteur ORDER BY CODE_VISITEUR DESC LIMIT 1)
																		)";
												$prixentree=10*0.7;
												echo "Tarif entree etudiant : $prixentree euros";
											}

											if($categorie=="Adulte")
											{
												$nouvelleentree="INSERT INTO entree 
																	(
																				NUM_ENTREE,
																				CODE_TARIF_TICKET,
																				CODE_EMPLOYE,
																				DATE_ACHAT_ENTREE,
																				DATE_VISITE,
																				PRIX_ENTREE, 
																				CODE_VISITEUR
																	) 
																VALUES (
																				NULL, 
																				3, 
																				2, 
																				CURRENT_DATE(), 
																				date_format('$datevisite','%Y-%m-%d'), 
																				10 ,
																				(SELECT CODE_VISITEUR FROM visiteur ORDER BY CODE_VISITEUR DESC LIMIT 1)
																		)";
												$prixentree=10*1;
												echo "Tarif entree adulte : $prixentree euros";
											}

											if($categorie=="Senior")
											{
												$nouvelleentree="INSERT INTO entree 
																	(
																				NUM_ENTREE,
																				CODE_TARIF_TICKET,
																				CODE_EMPLOYE,
																				DATE_ACHAT_ENTREE,
																				DATE_VISITE,
																				PRIX_ENTREE, 
																				CODE_VISITEUR
																	) 
																VALUES (
																				NULL, 
																				4, 
																				2, 
																				CURRENT_DATE(), 
																				date_format('$datevisite','%Y-%m-%d'), 
																				10 ,
																				(SELECT CODE_VISITEUR FROM visiteur ORDER BY CODE_VISITEUR DESC LIMIT 1)
																		)";
												$prixentree=10*0.8;
												echo "Tarif entree senior : $prixentree euros";
											}
										}

										$result_nouvelleentree=mysqli_query($connexion,$nouvelleentree);

									}

									?>
								</div>

								</fieldset>

							</form>

						
							<form method="post" action="ticketvisiteur.php">

								<fieldset>

									<center><legend><h3>Spectacles</h3></legend></center>
									<div class="presentation">
									<p> Choix des spectacles (maximum 3) <br/></p> <!--3 spectales au max-->
									</div>

									<div class="contenu">
										<?php

											if(isset($_POST['datevisite']))
											{

												echo "<label for='spectacle' > Sélectionnez les spectacles :  </label> <br/>";
												//Récupérer la variable de la date de visite
												$datevisite=$_POST['datevisite'];

												//Fabrication d'une requête SQL
												$requête='SELECT distinct * FROM spectacle S';
												//Envoi de la requête SELECT
												$result=mysqli_query($connexion,$requête) or die(mysql_error());
												
												while($data=mysqli_fetch_array($result,MYSQLI_ASSOC))
												{
													//transformer le format string de la date de visite en date
													$datetime5= new DateTime($datevisite);

													//transformer le format string de la date de visite en date
													$datetime3= new DateTime($data["DATE_SPECTACLE"]);

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
													if($datetime3==$datetime5)
													{
														echo "<input type='checkbox' name='article[]' value='".$data['NOM_SPECTACLE'].' de '.$data['HEURE_DEBUT_SPECTACLE'].' à '.$data['HEURE_FIN_SPECTACLE'].' le '.$data['DATE_SPECTACLE']."'>".$data['NOM_SPECTACLE'].' de '.$heuredebutspec.'h'.$mindebutspec.'  à '.$heurefinspec.'h'.$minfinspec.' le '.$jour.'/'.$mois;
														echo "<br/>";

													}
												}
											}
										?>
									</div>

								</fieldset>
							
								<fieldset>
									<div class="presentation">
									<center><legend><h3>Ateliers</h3></legend></center>
									<p> Choix des ateliers (maximum 3) <br/></p>
									</div>
								<div class="contenu">
									<?php

											if(isset($_POST['datevisite']))
											{
												echo "<label for='atelier' > Sélectionnez les ateliers :  </label> <br/>";

												//Récupérer la variable de la date de visite
												$datevisiteat=$_POST['datevisite'];

												//Fabrication d'une requête SQL
												$reqatelier='SELECT distinct * FROM atelier A';
												//Envoi de la requête SELECT
												$resultatelier=mysqli_query($connexion,$reqatelier) or die(mysql_error());
												
												while($dataatelier=mysqli_fetch_array($resultatelier,MYSQLI_ASSOC))
												{
													//transformer le format string de la date de visite en date
													$datetime1= new DateTime($datevisiteat);

													//transformer le format string de la date de visite en date
													$datetime2= new DateTime($dataatelier["DATE_ATELIER"]);

													//Pour mieux afficher la date
													$datetime6= $dataatelier['DATE_ATELIER'];
													$datetime6 = explode ("-", $datetime6); 
													// Transforme la date en array
													$annee = $datetime6[0];
													$mois = $datetime6[1];
													$jour = $datetime6[2];
													//Pour mieux afficher l'heure
													$timedebutatelier= explode (":", $dataatelier['HEURE_DEBUT_ATELIER']);
													//Transforme l'heure en array
													$heuredebutatelier= $timedebutatelier[0];
													$mindebutatelier= $timedebutatelier[1];
													$secdebutatelier= $timedebutatelier[2];
													$timefinatelier= explode (":", $dataatelier['HEURE_FIN_ATELIER']);
													//Transforme l'heure en array
													$heurefinatelier= $timefinatelier[0];
													$minfinatelier= $timefinatelier[1];
													$secfinatelier= $timefinatelier[2];
													if($datetime1==$datetime2)
													{
													echo "<input type='checkbox' name='articleatel[]' value='".$dataatelier['NOM_ATELIER'].' de '.$dataatelier['HEURE_DEBUT_ATELIER'].' à '.$dataatelier['HEURE_FIN_ATELIER'].' le '.$dataatelier['DATE_ATELIER']."'>".$dataatelier['NOM_ATELIER'].' de '.$heuredebutatelier.'h'.$mindebutatelier.'  à '.$heurefinatelier.'h'.$minfinatelier.' le '.$jour.'/'.$mois;
													echo "<br/>";
													}
												}
											}
										;?>
								</fieldset>
							</div>
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
