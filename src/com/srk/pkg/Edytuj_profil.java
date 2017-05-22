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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Edytuj_profil
 */
public class Edytuj_profil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Edytuj_profil() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		    
		HttpSession session = request.getSession();
				
		String login = "";
		String imie = "";
		String nazwisko = "";
		String email = "";
		String haslo = "";
		String miasto = "";
		
		if (session != null){
			login = (String) session.getAttribute("login");
		}
		else {
			return;
		}
		
		// enter to a DB
		String connectionString = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true";
		Connection connection;
		Statement command;
		ResultSet userDetails = null;
				
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
			
			userDetails = command.executeQuery("SELECT haslo, email, imie, nazwisko, miasto FROM uzytkownicy WHERE login = '" + login + "';");
			
			if (userDetails.first()) {
				haslo = userDetails.getString(1);
				email = userDetails.getString(2);
				imie = userDetails.getString(3);
				nazwisko = userDetails.getString(4);
				miasto = userDetails.getString(5);
			}
			userDetails.close();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		request.setAttribute("haslo", haslo);
		request.setAttribute("email", email);
		request.setAttribute("imie", imie);
		request.setAttribute("nazwisko", nazwisko);
		request.setAttribute("miasto", miasto);
		request.getRequestDispatcher("/edytuj_profil.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
