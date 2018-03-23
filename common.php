<?php

try
{
// Connexion à la BDD, page simplement rappelée par la suite, utilisation de PDO 
$bdd=new PDO ('mysql:host=localhost;dbname=scolarite;charset=utf8', 
				'root','');
//Gestion des erreurs avec SQL puis dans le catch les erreurs liés à la connexion à la bdd
$bdd->setAttribute (PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}
catch (Exception $e)
{
	die('Erreur de connexion :'.$e->getMessage());
}
?>