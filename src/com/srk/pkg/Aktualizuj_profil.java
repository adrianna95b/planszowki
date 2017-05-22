package com.srk.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Aktualizuj_profil
 */
public class Aktualizuj_profil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Aktualizuj_profil() {
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
		
		response.setCharacterEncoding("UTF-8");
		
		String imie = request.getParameter("imie");
		String nazwisko = request.getParameter("nazwisko");
		String email = request.getParameter("email");
		String haslo = request.getParameter("haslo");
		String haslo2 = request.getParameter("haslo2");
		String miasto = request.getParameter("miasto");
				
		String message = "";
		
		HttpSession session = request.getSession();
		
		String login = "";
		
		if (session != null){
			login = (String) session.getAttribute("login");
		}
		
		if ( !haslo.isEmpty() && !haslo.equals(haslo2) )  {
			message = "Wpisz dwa identyczne has³a.";
			request.setAttribute("message", message);
			request.setAttribute("haslo", haslo);
			request.setAttribute("email", email);
			request.setAttribute("imie", imie);
			request.setAttribute("nazwisko", nazwisko);
			request.setAttribute("miasto", miasto);
			request.getRequestDispatcher("/edytuj_profil.jsp").forward(request, response);
			return;
		}
				
				
		// enter to a DB
		String connectionString = "jdbc:mysql://localhost:3306/planszowki?verifyServerCertificate=false&useSSL=true";
		Connection connection;
		Statement command;
				
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
			
			if ( haslo.isEmpty() ) {
				command.execute("UPDATE Uzytkownicy SET email = '" + email + "', imie = '" + imie + "', nazwisko = '" + nazwisko + "', miasto = + '" + miasto + "' WHERE login = '" + login + "'");
			}
			
			else {
				command.execute("UPDATE Uzytkownicy SET email = '" + email + "', haslo = '" + haslo + "', imie = '" + imie + "', nazwisko = '" + nazwisko + "', miasto = + '" + miasto + "' WHERE login = '" + login + "'");
			}
			
			request.setAttribute("message", message);
			request.setAttribute("haslo", haslo);
			request.setAttribute("email", email);
			request.setAttribute("imie", imie);
			request.setAttribute("nazwisko", nazwisko);
			request.setAttribute("miasto", miasto);
			request.getRequestDispatcher("/edytuj_profil.jsp").forward(request, response);
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
