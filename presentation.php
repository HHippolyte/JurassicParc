<!DOCTYPE HTML>
<!--
	Page de présentation du zoo 
-->
<html>
	<head>
		<title> Présentation ZooPedia </title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'esnsemble du corps --!>
				<!-- Header -->
						<?php include("header.php"); ?>

				<!-- Généralités -->
				<main>
					<div id="main" class="colonne_alpha centrer col12">
					
						<div class="presentation">
							<h1> Présentation de ZooPedia </h1>
							<a href= "Style/images/presentation.png"> <img src="Style/images/presentations-min.png" alt=" Carte du zoo" title ="Cliquez pour voir le plan du zoo"/></a>
							<p> Découvrez le plan de visite de l’Espace Zoologique. <br/>
								Un sens de visite est indiqué afin que vous ne ratiez aucune espèce ! </p>

							<h2> Historique du zoo </h2>
							<p> L'histoire de ce zoo est assez récente, débutant au début des années 2000. Grandissant rapidement au fil des années, il ouvre en 2018 son premier site web permettant à notre petit monde d'interagir plus facilement avec vous, humbles invités et pour d'autres fidèles habitués. </p>
							<h2> Présentation </h2>
							<p> Notre zoo est situé dans un parc protégé proche de Lyon et Genève entre Jura et Alpes. De cette manière vous aurez l'occasion de vous ressourcez dans un cadre naturel tout en apprenant de nouvelles choses.</p>
						</div>

					</div>
				</main>

				<!-- Footer -->
				<?php include("footer.php");?>
			</div>

	</body>
</html>