<?php include("common.php");
?>
<!DOCYPE html>


<html>
	<head>
		<title>Placement animal - ZooPedia</title>
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
							<div class="cadre">
								<div class="titre">
									<h2> Nos animaux</h2>

									<p> Zoopedia dispose d'un grand nombre d'animaux répartis dans notre parc. Trouvez dans cette liste les animaux actuellement visibles </p>

								<?php
								$listanim='SELECT NOM_ANIMAL, DATE_NAISSANCE_ANIMAL, DATE_ARRIVEE_ANIMAL, POIDS_ANIMAL_KG, SEXE_ANIMAL, PROVENANCE_ANIMAL,LIBELLE_ESPECE, DESCRIPTION_ESPECE FROM animal INNER JOIN espece ON animal.CODE_ESPECE=espece.CODE_ESPECE ORDER BY LIBELLE_ESPECE';
								$result_animal=mysqli_query($connexion,$listanim) or die(mysql_error());
								$listanimaux = $listanim->fetchAll();
								 if(isset($listanimaux)): ?>
								<h3>Nos animaux :</h3>
								<?php if($listanimaux): ?>
									<table border=1>
										<tr>
									<td>Libelle espèce :</td>
									<td>Nom de l'animal :</td>  
									<td>Date de naissance :</td>
									<td>Date d'arrivée à Zoopédia :</td>
									<td>Poids :</td>
									<td>Sexe :</td>
									<td>Sa provenance  :</td>
									<td>Description de l'espèce :</td>
										</tr>
			<?php foreach($listanimaux as $animaux): ?>
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




