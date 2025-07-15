/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Packages;

import Packages.ConnectionDB;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentNumber = request.getParameter("student_number");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

//validation
        if (studentNumber.isEmpty() || name.isEmpty() || surname.isEmpty() ||
                email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

//email format check
        if (!email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

//phone number check
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Phone number must be exactly 10 digits.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

//password length check
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = ConnectionDB.getConnection()) {
            //Check for duplicate email or student number
            String checkQuery = "SELECT * FROM users WHERE email = ? OR student_number = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            checkStmt.setString(2, studentNumber);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("error", "Email or Student Number already exists.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            //Insert new user with hashed password
            String insertQuery = "INSERT INTO users (student_number, name, surname, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, studentNumber);
            insertStmt.setString(2, name);
            insertStmt.setString(3, surname);
            insertStmt.setString(4, email);
            insertStmt.setString(5, phone);
            insertStmt.setString(6, hashPassword(password));

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("message", "Registration successful. You can now log in.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }} catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occured: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}
