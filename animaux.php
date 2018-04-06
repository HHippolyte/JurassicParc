<?php include("common.php");
?>
<!DOCYPE html>


<html>
	<head>
		<title>Animaux - ZooPedia</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="structure/structure-main.css"/>
		<link rel="stylesheet" href="Style/Style.css"/>
	</head>
	<body>
			<div id="conteneur"> <!-- ex wrapper correspond à l'ensemble du corps --!>
				<!-- Header -->
				<?php include("header.php"); ?> 

				<div id="colonne_alpha centrer col12 presentation">
							
								<div class="titre">
									<center><h2> Nos animaux</h2><center>
								</div>
							<div class="cadre">
								<div class="presentation alignegauche">
									<p> Zoopedia dispose d'un grand nombre d'animaux répartis dans l'ensemble du parc. Trouvez dans cette liste les animaux actuellement visibles et de premières informations sur les espèces présentes. </p>
								</div>
							</div>

							
								
								
							<?php
								// connexion à la base de données à l'aide içi de PDO :
							$pdo = new PDO('mysql:host=localhost;dbname=zoopedia;charset=utf8','root', '',
							array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, 
								PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC));
								$query = $pdo->prepare("SELECT LIBELLE_ESPECE, NOM_ANIMAL, DATE_NAISSANCE_ANIMAL, DATE_ARRIVEE_ANIMAL, POIDS_ANIMAL_KG, SEXE_ANIMAL, PROVENANCE_ANIMAL, DESCRIPTION_ESPECE FROM animal INNER JOIN espece ON animal.CODE_ESPECE=espece.CODE_ESPECE ORDER BY LIBELLE_ESPECE");
								$query->execute();
								$anim = $query->fetchAll(); ?>
								<!-- Affichage des animaux dans un tableau -->
							<?php  if(isset($anim)): ?>
				<div class="cadre">
	<center><h2>Animaux actuellement visibles :</h2><center>
	<?php if($anim): ?>
		<table id="tableau" border = 1 >
			<tr>
				<td>Espèces</td>  
				<td>Nom de l'animal</td> 
				<td>Date de naissance</td>
				<td>Date d'arrivée dans le zoo</td>
				<td>Poids de l'animal</td>
				<td>Sexe</td>
				<td>Provenance</td>
				<td>Description de l'espèce</td>
			</tr>
			<?php foreach($anim as $animaux): ?>
				<tr>
					<td><?= $animaux['LIBELLE_ESPECE'] ?></td>  
					<td><?= $animaux['NOM_ANIMAL'] ?></td> 
					<td><?= $animaux['DATE_NAISSANCE_ANIMAL'] ?></td>
					<td><?= $animaux['DATE_ARRIVEE_ANIMAL'] ?></td>
					<td><?= $animaux['POIDS_ANIMAL_KG'] ?></td>
					<td><?= $animaux['SEXE_ANIMAL'] ?></td>
					<td><?= $animaux['PROVENANCE_ANIMAL'] ?></td>
					<td><?= $animaux['DESCRIPTION_ESPECE'] ?></td>
				</tr>
			<?php endforeach; ?>
		</table>
	<?php endif; ?>
<?php endif; ?>
</div>
</body>
</html>
