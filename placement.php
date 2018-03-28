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
		<link rel="stylesheet" href="Style/Styleemploye.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->
					<?php include("header.php"); ?> 

			<center><div> 
				<h1>Placement des animaux existants dans les différents espaces du zoo</h1>
			</div></center>
			<div>
				<form method="post">
					<center><h3>Animal souhaité </h3>
					<select id="animal" name="choix" size="1">
						<?php

						//Fabrication d'une requête SQL
						$animal='SELECT distinct NUM_ANIMAL, NOM_ANIMAL FROM animal';
						//Envoi de la reuqête SELECT
						$result_animal=mysqli_query($connexion,$animal) or die(mysql_error());
							while($data_animal=mysqli_fetch_array($result_animal,MYSQLI_ASSOC))
										{
											echo '<option value="'.$data_animal["NUM_ANIMAL"].'"-"'.$data_animal["NOM_ANIMAL"].'"</option>'.$data_animal["NUM_ANIMAL"].'-'.$data_animal["NOM_ANIMAL"].'<br/>';
										}
						?>
						
					</select>
					
				</center>
				<br/>
			<br/>
		
	</div>
<center><div>

									<center><h3>Selection de l'espace </h3></center>
									

									<select  id="espace" name="choix2" size="1">
									<?php
												//Affichage des résultats liés aux espaces
											$proc='SELECT distinct NUM_ESPACE, LIBELLE_ESPACE FROM espace ' ;
											$result_espace=mysqli_query($connexion,$proc) or die(mysql_error());
							while($res=mysqli_fetch_array($result_espace,MYSQLI_ASSOC))
									
											{

											echo '<option value="'.$res["NUM_ESPACE"].'"-"'.$res["LIBELLE_ESPACE"].'"</option>'.$res["NUM_ESPACE"].'-'.$res["LIBELLE_ESPACE"].'<br/>'; 
											}
									
									?>
								</select>	
							</div>	
						</center>	
						<center><div>	
											<center><h3>Dates prévues</h3></center>

									<label for="datedebplace" > Date de placement dans cet espace: </label>
											<input type="date" name="datedebplace"> <br/> 
									<label for="datefinplace" > Date de fin de placement dans cet espace : </label>
											<input type="date" name="datefinarrive"> <br/> 
						</div>
					</center>

							<center><div>
								<input type="submit" value="Déplacer">
							</div></center>
						</form>
					</div>

					<?php 
					if(!empty($_POST)){
				$choix=$_POST['choix'];
				$choix2=$_POST['choix2'];
				$datedeb=$_POST['datedebplace'];
				$datefinplace=$_POST['datefinarrive'];

						$insertion="INSERT INTO placement VALUES (NULL,'$choix2','$choix','$datedeb','$datefinplace')";
          				$resultat =mysqli_query($connexion,$insertion);
						echo $choix."a bien été déplacé ! <br/>"; 
						echo "Espace : ".$choix2. "<br/>";
						echo "Date de début de placement : ".$datedeb. "<br/>";
						echo "Date de fin de placement : ".$datefinplace. "<br/>";
				}
		else 
		{
			echo "Veuillez renseigner l'ensemble des champs !";
		}

					?>
	
</div>
</body>
</html>