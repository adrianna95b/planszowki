package com.srk.pkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Dodaj_ogloszenie
 */
public class Dodaj_ogloszenie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dodaj_ogloszenie() {
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
			
		String tytul = request.getParameter("tytul");
		String wiekMin = request.getParameter("wiek_min");
		String graczeMin = request.getParameter("gracze_min");
		String graczeMax = request.getParameter("gracze_max");
		String miasto = request.getParameter("miasto");
		String tekst = request.getParameter("tekst");
		String userId = request.getParameter("uz_id");
		String message = "";
		
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
				
				command.execute("INSERT INTO ogloszenia (tytul, data_dodania, wiek_min, gracze_min, gracze_max, miasto_og, tekst, Uzytkownicy_uz_id) VALUES ('" + tytul + "', now(),'" + wiekMin + "','" + graczeMin + "','" + graczeMax + "','" + miasto + "','" + tekst + "','" + userId + "');");
				request.setAttribute("message", message);
				request.getRequestDispatcher("/dodaj_ogloszenie.jsp").forward(request, response);
			} 
			catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	}
}
