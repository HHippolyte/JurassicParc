<?php 
session_start();
?>
<!DOCYPE html>


<html>
	<head>
		<title>Fiche Animal - ZooPedia</title>
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
						<div class="titre">
							Création d'une fiche animal:
						</div>
							<div class="cadre"
								<form method="post">
									<label for="nomanimal" > Saisissez son nom : </label><br/>
										<input type="text" name="nomanimal"> <br/>
									<label for="codeespece" >Saisissez son code espèce : </label><br/>
										<input type="number" name="codeespece"> <br/>
									<label for="codegroupe"> Saississez le code groupe, par défaut sa valeur est 0 :</label><br/>
										<input type="number" name="codegroupe"> <br/>
									<label for="datenaissance"> Date de naissance de l'animal : :</label><br/>
										<input type="date" name="datenaissance"> <br/>
									<label for="datearrive" > Date d'arrivée dans le zoo : </label><br/>
										<input type="date" name="datearrive"> <br/> 
									<label for="poidsanimal"> Poids de l'animal : </label><br/>
										<input type="number" name="poidsanimal"> <br/>
									 <p>Veuillez saisir le sexe de l'animal : <br/>
									 	<input type="radio" name="sexe" value="M" id="M" /> <label for="M"> M </label><br />
									 	<input type="radio" name="sexe" value="F" id="F" /> <label for="F"> F </label><br/>
									 </p>
									<label for="provenance">Provenance de l'animal : </label><br/>
										<input type="text" name="provenance" size="30"><br/>
									<label for="commentaire"> Commentaire à ajouter : </label><br/>
										<input type="textarea" name="commentaire" size="70"><br/> 

											<input type="submit" value='Créer'>
			    				</form>
			    				
							</div>
					
							<div class="contenu centrer">
								<br/>
								<?php 
									$connexion=mysqli_connect("localhost","root","","zoopedia")
									or die(mysql_error());


										if(!empty($_POST)){
												$nom=$_POST['nomanimal'];
												$espece=$_POST['codeespece'];
												$groupe=$_POST['codegroupe'];
												$daten=$_POST['datenaissance'];
												$datea=$_POST['datearrive'];
												$poids=$_POST['poidsanimal'];
												$sexe=$_POST['sexe'];
												$prov=$_POST['provenance'];
												$comm=$_POST['commentaire'];
														$insertion="INSERT INTO animal VALUES (NULL,'$nom','$espece','$groupe','$daten','$datea','$poids','$sexe','$prov',NULL,'$comm')";
								          				$resultat =mysqli_query($connexion,$insertion);
														echo $nom."a bien été ajouté ! <br/>"; 
														echo "Code de l'espèce : ".$espece. "<br/>";
														echo "Code groupe : ".$groupe. "<br/>";
														echo "Date de naissance : ".$daten. "<br/>";
														echo "Date d'arrivée dans le zoo : ".$poids. "<br/>";
														echo "Poids de l'animal : ".$poids. "<br/>";
														echo "Sexe : ".$sexe."<br/>";
														echo "prov : ".$prov. "<br/>";
														echo "Eventuel commentaire : " .$comm. "<br/>";
														
											}
										else 
										{
											echo "Veuillez renseigner l'ensemble des champs !";
										}
								?>
							</div>
					</div>
			</div>
	</body>
	<!-- Footer-->
	<?php include("footer.php");?>
</html>


