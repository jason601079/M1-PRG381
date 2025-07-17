/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package conf;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get form data from login.jsp 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
                
        //validating input
        if (username == null || username.isEmpty() || password == null || password.isEmpty() ){
            request.setAttribute("error", "Please enter both username and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = utils.ConnectionDB.getConnection()){
            //query the database for the student
            String sql = "SELECT username, password FROM users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()){                          
                String dbPassword = rs.getString("password");
                
                if (password.equals(dbPassword)){
                    //Login succesfull; redirect to dashboard and create session
                   HttpSession session = request.getSession();
                   session.setAttribute("username", username);               
                   response.sendRedirect("dashboard.jsp");
                }else{
                    //incorrect password; redirect to login
                    request.setAttribute("error", "Incorrect Password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }else {
                //student not found: redirect to login
                request.setAttribute("error", "Username not Found");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Login failed due to error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        
    }
    
 
    
  // Handles POST requests from login.jsp
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}

// Handles GET requests 
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    processRequest(request, response);
}

// Description of the servlet
@Override
public String getServletInfo() {
    return "Handles student login authentication";
}

   
}
