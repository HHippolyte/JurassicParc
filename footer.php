<footer>
	
	<div class="colonne_alpha col12 footer">

			<div class="colonne col12 centrer">
				<h2>Contactez-nous</h2>
			</div>
				<!-- Ici je mettrais une partie PHP pour l'envoi de messages ;)-->

			<div class="colonne_alpha prefix1 col5 contact">

				<table>
					<form action="contact.php" method="post" >
						
							<h3>Envoyer un message</h3>
						
						<tr>
							<td><div align="right">Votre nom :</div></td>
							<td><input type="text" name="nom" size="45" maxlength="100"></td>
						</tr>
						<tr> 
							<td><div align="right">Votre mail :</div></td>
							<td><input type="text" name="mail" size="45" maxlength="100"></td>
						</tr>
						<tr> 
							<td><div align="right">Sujet : </div></td>
							<td><input type="text" name="objet" size="45" maxlength="120"></td>
						</tr>
						<tr> 
							<td><div align="right">Message : </div></td>
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
					</form>
				</table>
			</div>

			<div class="colonne col6 contact">
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

			</div>
		</section>
	</div>

</footer>
