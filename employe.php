<?php 
session_start();
?>
<!DOCYPE html>


<html>
	<head>
		<title>Employes - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->

					<?php include("header.php"); ?> 

					<!-- Page générale -->
					<main>
						<div class="colonne_alpha col12 titre">
						Espace Employé
						</div>
						<div class="contenu">
						<?php 
						echo 'Vous êtes connecté '.$_SESSION['nom'].' '.$_SESSION['prenom'].' !';
						?>
						</div>
	       <!-- Réalisation d'un menu employé pour la gestion du zoo -->
				
									
								<section>
									<div class="profil">
										<form method="post" action="profil.php">
											<input type="submit" value=" Accédez à votre profil" />
										</form>
									</div>
								</section>	
								<section>
								<div class="presentation">
									<div class="colonne_alpha col4 centrer" id="distribution">
										<a href="distribution.php">
											<h2> Distribution </h2>
											<div class="contenu">
												<p> Carnet de distribution de la nourriture</p><br><br>
											</div>
										</a>	
									</div>

									<div class="colonne col4" id="animaux"> 
										<a href="placement.php">
											<h2>Placement animal</h2>
											<div class="contenu">
												<p> Gestion de l'espace </p><br><br>
											</div>
										</a>
									</div>

									<div class="colonne col4" id="ajout">
										<a href="creation.php">
											<h2>Création fiche animal</h2>
											<div class="contenu">
												<p> Enregistrer un nouvel arrivant </p><br><br>
											</div>
										</a>
									</div>
								</div>
								</section>
					</main>
					<!-- Footer -->
				<?php include("footer.php");?>				
			</div>
	</body>
</html>
