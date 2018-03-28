<!DOCTYPE html>

<?php include("common.php");
session_start();
?>

<html>
	<head>
		<title>Ticket d'un visiteur - ZooPedia</title>
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

						<?php echo "<br/><h3>Ticket d'un visiteur </h3><br/>"; ?>

						<fieldset>
							<?php
								echo "Prix de l'entrée au zoo : ";
								if(isset($_POST['catégorie']))
								{	
									$categorie=$_POST['catégorie'];

									if($categorie=="enfant")
									{
										$prixentree=10*0.5;
										echo "$prixentree euros.";
									}
									if($categorie=="adulte")
									{
										$prixentree=10;
										echo "$prixentree euros.";
									}
									if($categorie=="senior")
									{
										$prixentree=10*0.8;
										echo "$prixentree euros.";
									}
									if($categorie=="etudiant")
									{
										$prixentree=10*0.7;
										echo "$prixentree euros.";
									}
								}

							?>
						</fieldset>	

						<fieldset>
							<?php

							//Vérification des champs et récupération des spectacles
							if(isset($_POST['article']))
							{
								$spectacle=$_POST['article'];
								echo"Places de spectacle réservées : <br/>";
								if(isset($spectacle[0]))
									{	
										$spectacle1=$spectacle[0];
										echo substr($spectacle1, 0, -38)."<br/>";
									}
								if(isset($spectacle[1]))
									{
										$spectacle2=$spectacle[1];							
										echo substr($spectacle2, 0, -38)."<br/>";
									}
								if(isset($spectacle[2]))
									{
										$spectacle3=$spectacle[2];
										echo substr($spectacle1, 0, -38)."<br/>";
									}

								echo "<br/>";
							}
							?>
						</fieldset>

						<fieldset>
							<?php

							//Vérification du choix de la catégorie
							if(isset($_POST['catégorie']))
							{	
								$categorie=$_POST['catégorie'];

								//Vérification des champs et récupération des ateliers
								if(isset($_POST['articleatel']))
								{
									$atelier=$_POST['articleatel'];
									echo"Prix des ateliers réservés : <br/>";
									if(isset($atelier[0]))
										{	
											$atelier1=$atelier[0];
											echo substr($atelier1, 0, -38)." : ";
											if($categorie=="enfant")
											{
												$prixatel1=8*0.5;
												echo "$prixatel1 euros.";
											}
											if($categorie=="adulte")
											{
												$prixatel1=8;
												echo "$prixatel1 euros.";
											}
											if($categorie=="senior")
											{
												$prixatel1=8*0.8;
												echo "$prixatel1 euros.";
											}
											if($categorie=="etudiant")
											{
												$prixatel1=8*0.7;
												echo "$prixatel1 euros.";
											}
										}
									if(isset($atelier[1]))
										{
											$atelier2=$atelier[1];							
											echo substr($atelier2, 0, -38)." : ";
											if($categorie=="enfant")
											{
												$prixatel2=8*0.5;
												echo "$prixatel2 euros.";
											}
											if($categorie=="adulte")
											{
												$prixatel2=8;
												echo "$prixatel2 euros.";
											}
											if($categorie=="senior")
											{
												$prixatel2=8*0.8;
												echo "$prixatel2 euros.";
											}
											if($categorie=="etudiant")
											{
												$prixatel2=8*0.7;
												echo "$prixatel2 euros.";
											}
										}
									if(isset($atelier[2]))
										{
											$atelier3=$atelier[2];
											echo substr($atelier3, 0, -38)." : ";
											if($categorie=="enfant")
											{
												$prixatel3=8*0.5;
												echo "$prixatel3 euros.";
											}
											if($categorie=="adulte")
											{
												$prixatel3=8;
												echo "$prixatel3 euros.";
											}
											if($categorie=="senior")
											{
												$prixatel3=8*0.8;
												echo "$prixatel3 euros.";
											}
											if($categorie=="etudiant")
											{
												$prixatel3=8*0.7;
												echo "$prixatel3 euros.";
											}
										}
								}
							}


							?>
						</fieldset>
					</div>
				</div>
				<!-- Footer -->
				<?php include("footer.php");?>
			</div>
	</body>



</html>