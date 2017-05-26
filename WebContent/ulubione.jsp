<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pl">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Planszówki - ogloszenia</title>
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
		.panel p {
			margin-bottom: 0;
		}
	</style>
</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp">Planszówki</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a></li>
				<c:if test="${logged == true}">
					<li><a href="ogloszenia.jsp">Ogłoszenia</a></li>
					<li><a href="dodaj_ogloszenie.jsp">Dodaj ogloszenie</a></li>
					<li class="active"><a href="ulubione.jsp">Ulubione</a></li>
				</c:if>
			</ul>
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
						<li><a href="rejestracja.jsp"><span class="glyphicon glyphicon-user"></span> Zarejestruj</a></li>
					</ul>
				</c:when>
			</c:choose>
		</div>
	</nav>	
	
	<div class="container">
		<div class="row">
			<div class="col-xs-12 text-center">
				<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
			         url = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true"
			         user = "root"  password = "mleko"/>
				
				<sql:query dataSource = "${snapshot}" var = "result">
					SELECT ogloszenia.tytul, ulubione.Ogloszenia_og_id
					FROM ulubione
					INNER JOIN ogloszenia ON ulubione.Ogloszenia_og_id=ogloszenia.og_id
					WHERE ogloszenia.Uzytkownicy_uz_id=${userId};
				</sql:query>
				
				<h2 class="header">Ulubione ogłoszenia</h2>
				<hr class="separator">
				
				<c:forEach var = "row" items = "${result.rows}">
					<div class="row">
						<div class="col-xs-6 text-left">${row.tytul}</div>
						<div class="col-xs-6 text-right">
							<a href="ogloszenie_szczeg.jsp?og_id=${row.Ogloszenia_og_id}">Szczegóły</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
</body>
</html>