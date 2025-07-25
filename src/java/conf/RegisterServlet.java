/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {     
        String name = request.getParameter("username");
        String email = request.getParameter("email");   
        String password = request.getParameter("password");

        if (name == null || name.isEmpty()|| email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("message", "Please fill in all required fields");          
            request.setAttribute("prevName", name);          
            request.setAttribute("prevEmail", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);

            return;

        }

        // <editor-fold defaultstate="collapsed" desc="post method + connect">
        try {

            try (Connection conn = utils.ConnectionDB.getConnection()) {

                String checkQuery = "SELECT 1 FROM users WHERE email = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                    checkStmt.setString(1, email);                 

                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            request.setAttribute("message", "Email already exists.");
                            request.getRequestDispatcher("register.jsp").forward(request, response);
                            return;
                        }
                    }
                }               

                String insertQuery = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
          
                    insertStmt.setString(1, name);    
                    insertStmt.setString(2, email);               
                    insertStmt.setString(3, password);

                    int rowsInserted = insertStmt.executeUpdate();

                    if (rowsInserted > 0) {
                        request.setAttribute("registrationSuccess", "Registration successful! You can now log in.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);

                    } else {
                        request.setAttribute("message", "Registration failed. Please try again.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}

// </editor-fold>

