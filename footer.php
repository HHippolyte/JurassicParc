<footer>
	<section>
		<div class="colonne centrer col12">
			<h2>Contactez-nous</h2>
		</div>
			<!-- Ici je mettrais une partie PHP pour l'envoi de messages ;)-->
	<div class="colonne_alpha prefix2 col4"
		<table>
			<form action="contact.php" method="post" >
				<tr> 
					<td colspan="3"><h3>Envoyer un message</h3></td>
				</tr>
				<tr> 
					<td><div align="left">Votre nom :</div></td>
					<td><input type="text" name="nom" size="45" maxlength="100"></td>
				</tr>
				<tr> 
					<td><div align="left">Votre mail :</div></td>
					<td><input type="text" name="mail" size="45" maxlength="100"></td>
				</tr>
				<tr> 
					<td><div align="left">Sujet : </div></td>
					<td><input type="text" name="objet" size="45" maxlength="120"></td>
				</tr>
				<tr> 
					<td><div align="left">Message : </div></td>
					<td><textarea name="message" maxlength="500"></textarea></td>
				</tr>
			<section>
				<tr>
				
						<td>

							<input type="reset" name="Submit" value="Annuler">
						</td>
						<td>
							<input type="submit" name="Submit" value="Envoyer">
						</td>
				</tr>
			</section>
			</form>
		</table>
	</div>

		<div class="colonne prefix1 col5">
				<h3>Réseaux sociaux</h3>
		
		<div class="icone colonne col2">
			<img src="Style/images/twitter.png" width="70" height="70" alt="Twitter">
		</div>
		<div class="icone colonne col2">
			<img src="Style/images/facebook.png" width="65" height="65" alt="Facebook">
		</div>
		<div class="icone colonne col2">
			<img src="Style/images/instagram.png" width="70" height="70" alt="Intsagram">
		</div>
		<div class="icone colonne col2">
			<img src="Style/images/email.png" width="70" height="70" alt="Email">
		</div>
	</section>

</footer>
