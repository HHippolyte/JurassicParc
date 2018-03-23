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
<?php 
echo 'Vous êtes connecté '.$_SESSION['nom'].' '.$_SESSION['prenom'].' !';
?>