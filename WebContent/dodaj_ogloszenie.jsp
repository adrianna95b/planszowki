<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pl">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Planszówki - dodaj ogłoszenie</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<style>
		body {
			padding-bottom: 40px;
		}
		
		.navbar {
			border-radius: 0;
		}
		
		.header {
			margin-top: 40px;
			margin-bottom: 30px;
		}
		
		.form-group {
			margin-bottom: 20px;
		}
		
		.separator {
			margin-top: 30px;
			margin-bottom: 30px;
		}
	</style>
</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp">Planszówki</a>
			</div>
			<c:choose>
				<c:when test="${logged == true}">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="doaj_ogloszenie.jsp">Dodaj ogłoszenie</a></li>
					</ul>
				</c:when>
				<c:when test="${empty logged or logged == false}">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp">Home</a></li>
						<li class="active"><a href="dodaj_ogloszenie.jsp">Dodaj ogłoszenie</a></li>
					</ul>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${logged == true}">
					<ul class="nav navbar-nav navbar-right">
						<li><p class="navbar-text">Zalogowany jako ${login}</p></li>
						<li><a href="Edytuj_profil">Edytuj profil</a></li>
						<li><a href="Logout">Wyloguj</a></li>
					</ul>
				</c:when>
				<c:when test="${empty logged or logged == false}">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
						<li class="active"><a href="rejestracja.jsp"><span class="glyphicon glyphicon-user"></span> Zarejestruj</a></li>
					</ul>
				</c:when>
			</c:choose>
		</div>
	</nav>	
	
	<div class="container">	
		<div class="row">
			<div class="col-xs-12 text-center">
				<h2 class="header">Dodaj ogłoszenie</h2>
			</div>
		</div>
		
		<div class="row">	
			<div class="col-xs-12 col-sm-6 col-sm-push-3">
				<c:choose>
				    <c:when test="${message == ''}">
				    	<div class="alert alert-success" role="alert">
							Udało Ci się dodać ogłoszenie! Powróć do <a href="index.jsp">strony głównej</a>!
						</div>
				    </c:when>
				    <c:when test="${not empty message}">
				        <div class="alert alert-danger" role="alert">
							Wystąpił błąd podczas dodania ogłoszenia. ${message} Spróbuj ponownie.
						</div>
				    </c:when>
				</c:choose>
			</div>
		</div>
		
		<div class="row">
			<form action="Dodaj_ogloszenie" method="post">
				<div class="col-xs-12 col-sm-6 col-sm-push-3">
					<div class="form-group">
						<label for="tytul">Tytuł ogłoszenia*:</label>
						<input type="text" id="tytul" name="tytul" class="form-control" required>
					</div>
					
					<hr class="separator">
					
					<div class="form-group">
						<label for="wiek_min">Min wiek:</label>
						<input type="number" min="1" max="99" id="wiek_min" name="wiek_min" class="form-control">
					</div>
					<div class="form-group">
						<label for="gracze_min">Min liczba graczy:</label>
						<input type="number" min="1" max="99" id="gracze_min" name="gracze_min" class="form-control">
					</div>
					<div class="form-group">
						<label for="gracze_max">Max liczba graczy:</label>
						<input type="number" min="1" max="99" id="gracze_max" name="gracze_max" class="form-control">
					</div>
					<div class="form-group">
						<label for="miasto">Miasto*:</label>
						<input type="text" id="miasto" name="miasto" class="form-control" value="${miasto}" required>
					</div>
					<hr class="separator">
					<div class="form-group">
						<label for="miasto">Tekst ogloszenia*:</label>
						<textarea id="miasto" name="tekst" class="form-control" rows="10" required></textarea>
					</div>
					<input type="hidden" name="uz_id" value="${userId}" class="form-control">
					<hr class="separator">
				<div class="col-xs-12 text-center">
					<button type="submit" class="btn btn-primary btn-lg">Dodaj ogłoszenie</button>
				</div>
			</form>
		</div>
		
	</div>
</body>
</html>