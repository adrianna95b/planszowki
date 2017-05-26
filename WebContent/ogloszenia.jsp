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
					<li class="active"><a href="ogloszenia.jsp">Ogłoszenia</a></li>
					<li><a href="dodaj_ogloszenie.jsp">Dodaj ogloszenie</a></li>
					 <li><a href="ulubione.jsp">Ulubione</a></li>
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
				<h2 class="header">Ogłoszenia</h2>
				<hr class="separator">
				<div class="row">
					<div class="col-xs-12">
						<form class="form-inline" action=ogloszenia.jsp method=”GET”>
							<div class="form-group">
								<label for="tytul">Tytuł</label>
								<input type="text" class="form-control" id="tytul" name="tytul">
							</div>
							<div class="form-group">
								<label for="wiek_min">Wiek min:</label>
								<input type="number" size ="2" class="form-control" id="wiek_min" name="wiek_min">
							</div>
							<div class="form-group">
								<label for="gracze_min">Graczy od:</label>
								<input type="number" class="form-control" id="gracze_min" name="gracze_min">
							</div>
							<div class="form-group">
								<label for="gracze_max">Graczy do:</label>
								<input type="number" class="form-control" id="gracze_max" name="gracze_max">
							</div>
							<div class="form-group">
								<label for="miasto_og">Miasto:</label>
								<input type="text" class="form-control" id="miasto_og" name="miasto_og">
							</div>
							<div class="form-group">
								<label for="sortuj">Sortuj:</label>
								<select name="sort" value="sort">
									<option value="desc">Najnowsze</option>
									<option value="asc">Najstarsze</option>
								</select>
							</div>
							<button type="submit" class="btn btn-default">Filtruj</button>
						</form>
					</div>
				</div>
				
				<hr class="separator">
				
				
				<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
			         url = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true"
			         user = "root"  password = "mleko"/>
				
				<sql:query dataSource = "${snapshot}" var = "result">
			         SELECT * from ogloszenia WHERE 1=1 
			         <c:if test="${not empty param.tytul}">AND tytul = '${param.tytul}'</c:if>
			         <c:if test="${not empty param.wiek_min}">AND wiek_min >= ${param.wiek_min}</c:if> 
			         <c:if test="${not empty param.gracze_min}">AND gracze_min >= ${param.gracze_min}</c:if> 
			         <c:if test="${not empty param.gracze_max}">AND gracze_max <= ${param.gracze_max}</c:if> 
			         <c:if test="${not empty param.miasto_og}">AND miasto_og = '${param.miasto_og}'</c:if> 
			         ORDER BY data_dodania <c:choose>
						<c:when test="${not empty param.sort}">
							${param.sort}
						</c:when>
						<c:when test="${empty param.sort}">
							desc
						</c:when>
					</c:choose>;
			    </sql:query>
			    
				<div class="row">
					<c:forEach var = "row" items = "${result.rows}">
					
						<div class="col-xs-12 col-md-6">
							<div class="panel panel-default text-left">
								<div class="panel-heading">
									<div class="row">
										<div class="col-xs-6">
											<p><strong>${row.tytul}</strong></p>
										</div>
										<div class="col-xs-6 text-right">
											<p>${row.miasto_og}</p>
										</div>								
									</div>
								</div>
								<div class="panel-body">
									<ul class="list-inline">
										<li>Liczba graczy: ${row.gracze_min} - ${row.gracze_max}</li>
										<li>Min wiek: ${row.wiek_min}</li>
										<li>Dodano: ${row.data_dodania}</li>
									</ul>
									${tytul}
									<a href="ogloszenie_szczeg.jsp?og_id=${row.og_id}">Szczegóły</a>
								</div>
							</div>
						</div>
					</c:forEach>
					
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>