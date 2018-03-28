
<html>
	<head>
		<title> Notre zoo </title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
		<div id="conteneur"> <!-- ex wrapper correspond à l'esnsemble du corps --!>
				<!-- Header -->
			<?php include("header.php"); ?>

				<!-- Page générale -->
					<main>
						<!--présentation-->
						<div class="colonne col12 centrer presentation">
							<div class="presentation">
							
								<h1>Bienvenue à ZooPedia, lieu magique, unique et pédagogique <br />
								</h1>
								<p> Implanté dans l'Est de la France entre Genève et Lyon, ZooPedia vous invite à découvrir et comprendre le mode de vie de ses animaux dans un cadre bucolique et convivial.</p>
							</div>
							<div class="reservez">
								<form method="post" action="reservations.php">
								<input type="submit" value="Réservez maintenant" />
							</form>
							</div>
						</div>
						<!-- correspond aux blocs généraux-->
						<!-- première section de 3 blocs généraux-->
							<section> 
								<div class="colonne_alpha col4" id="parc">
									<a href="presentation.php">

										<h2>LE PARC</h2>
										<div class="contenu">
											<p>Présentation du parc</p><br><br>
										</div>
									</a>
								</div>
								<div class="colonne col4" id="métiers">
									<a href="metiers.html">
										<h2>LES METIERS</h2>
										<div class="contenu">
											<p> Les différents métiers existants au sein de notre parc</p><br><br>
										</div>
									</a>
										
								</div>
								<div class="colonne col4" id="animaux"> <!-- à voir -->
									<a href="animaux.html">
										<h2>NOS ANIMAUX</h2>
										<div class="contenu">
											<p> L'ensemble de nos stars méritant toute notre attention </p><br><br>
										</div>
									</a>
								</div>
							</section>
							<!-- deuxième section de 3 blocs généraux-->
							<section>
								<div class="colonne_alpha col4" id="animations">
									<a href="animations.php">
										<h2>NOS ANIMATIONS</h2>
										<div class="contenu">
											<p> Un parc dynamique proposant un grand nombre d'activités</p><br><br>
										</div>
									</a>
								</div>
								<div class="colonne col4" id="visites">
									<a href="visites.html">
										<h2>VISITES DE GROUPE</h2>
										<div class="contenu">
											<p>Notre parc accueille les groupes scolaires mais également les entreprises</p><br>
										</div>
									</a>
								</div>
								<div class="colonne col4" id="actualités">
									<a href="generic.html">
										<h2>ACTUALITES</h2>
										<div class="contenu">
											<p>Les dernières news </p><br><br>
										</div>
									</a>
								</div>
							</section>
						
					</main>

			<!-- Footer -->
			<?php include("footer.php");?>

		</div>

	</body>
</html>
