package com.srk.pkg;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Rejestracja
 */
public class Rejestracja extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Rejestracja() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		PrintWriter out = response.getWriter();
		out.print("Odebrano formularz metoda post");
		
		String imie = request.getParameter("imie");
		String nazwisko = request.getParameter("nazwisko");
		String email = request.getParameter("email");
		String login = request.getParameter("login");
		String haslo = request.getParameter("haslo");
		String haslo2 = request.getParameter("haslo2");
		String miasto = request.getParameter("miasto");
		
		String message = "";
		
		if ( !haslo.equals(haslo2) )  {
			message = "Wpisz dwa identyczne has≥a.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("/rejestracja.jsp").forward(request, response);
			return;
		}
		
		
		// do Bazy
		String connectionString = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true";
		Connection connection;
		Statement command;
		ResultSet checkLogin = null;
		ResultSet checkMail = null;
	
		int countLogin = 0;
		int countMail = 0;
		
		try {
		    Class.forName("com.mysql.jdbc.Driver");
		    System.out.println("Driver loaded!");
		}
		catch (ClassNotFoundException e) {
		    throw new IllegalStateException("Cannot find the driver in the classpath!", e);
		}
		
		try {
			connection = DriverManager.getConnection(connectionString, "root", "mleko");
			command = connection.createStatement();
			
			checkLogin = command.executeQuery("SELECT COUNT(login) FROM uzytkownicy WHERE login = '" + login + "';");
			if (checkLogin.first()) {
				countLogin = checkLogin.getInt(1);
			}
			checkLogin.close();
			
			checkMail = command.executeQuery("SELECT COUNT(email) FROM uzytkownicy WHERE email = '" + email + "';");
			if (checkMail.first()) {
				countMail = checkMail.getInt(1);
			}
			checkMail.close();
			
			if (countLogin != 0)  {
				message = "Nazwa użytkownika jest już zajęta.";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/rejestracja.jsp").forward(request, response);
				return;
			}
			
			if (countMail != 0)  {
				message = "Adres email jest już zajęty.";
				request.setAttribute("message", message);
				request.getRequestDispatcher("/rejestracja.jsp").forward(request, response);
				return;
			}
			
			command.execute("INSERT INTO uzytkownicy (login, haslo, email, imie, nazwisko, miasto) VALUES ('" + login + "','" + haslo + "','" + email + "','" + imie + "','" + nazwisko + "','" + miasto + "');");
			request.getRequestDispatcher("/rejestracja.jsp").forward(request, response);
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}