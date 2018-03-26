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
		<link rel="stylesheet" href="Style/Styleemploye.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->
					<?php include("header.php"); ?> 
<?php 
echo 'Vous êtes connecté '.$_SESSION['nom'].' '.$_SESSION['prenom'].' !';
?>
       <!-- Réalisation d'un menu employé pour la gestion du zoo -->
			<section> 
								<div class="colonne_alpha col4" id="profil">
									<a href="profil.php">

										<center><h2>Mon profil</h2><center>
										<div class="content">
											<p>Accédez à votre profil</p><br><br>
										</div>
									</a>
								</div>
								<div class="colonne col4" id="distribution">
									<a href="distribution.php">
										<center><h2> Distribution de la nourriture</h2><center>
										<div class="content">
											<p> Carnet de distribution de la nourriture</p><br><br>
										</div>
									</a>
										
								</div>
								<div class="colonne col4" id="animaux"> 
									<a href="placement.php">
										<center><h2>Placement animal</h2><center>
										<div class="content">
											<p> Gestion de l'espace </p><br><br>
										</div>
									</a>
								</div>
							</section>





















</div>
</body>
</html>