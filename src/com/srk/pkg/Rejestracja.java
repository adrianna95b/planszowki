package com.srk.pkg;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
		String message = " ";
		
		
		if (!haslo.equals(haslo2))  {
			message = "Wpisz dwa identyczne hasła.";
			}
		
		String connectionString = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true";
		Connection connection;
		Statement command;
		ResultSet data;
		
			
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
			command.execute("INSERT INTO uzytkownicy (login, haslo, email, imie, nazwisko, miasto) VALUES ('" + login + "','" + haslo + "','" + email + "','" + imie + "','" + nazwisko + "','" + miasto + "');");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("message", message);
        request.getRequestDispatcher("/rejestracja.jsp").forward(request, response);	
		}

	}