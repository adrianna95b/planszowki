<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pl">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Planszówki - rejestracja</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<h2>Formularz rejestracyjny</h2>
			</div>
		</div>
		<div class="row">
			<form action="Rejestracja" method="post">
				<div class="col-xs-12 col-sm-6">
					<div class="form-group">
						<label for="imie">Imię*:</label>
						<input type="text" id="imie" name="imie" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="nazwisko">Nazwisko*:</label>
						<input type="text" id="nazwisko" name="nazwisko" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="email">Adres email*:</label>
						<input type="email" id="email" name="email" class="form-control" required>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="form-group">
						<label for="login">Login*:</label>
						<input type="text" id="login" name="login" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="haslo">Hasło*:</label>
						<input type="text" id="haslo" name="haslo" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="haslo2">Wprowadź ponownie hasło*:</label>
						<input type="text" id="haslo2" name="haslo2" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="miasto">Miasto*:</label>
						<input type="text" id="miasto" name="miasto" class="form-control" required>
					</div>
				</div>
				<div class="col-xs-12 text-right">
					<button type="submit" class="btn btn-default">Zarejestruj</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>