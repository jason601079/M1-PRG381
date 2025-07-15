

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <h1>Student Wellness System</h1>
        </header>
        <div class="container">
        <div class="card">
    <h2>Register</h2>

<%
    String message = "", error = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            error = "All fields are required.";
        } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            error = "Invalid email format.";
        } else if (password.length() < 6) {
            error = "Password must be at least 6 characters.";
        } else {
            try {
                Class.forName("org.postgresql.Driver");
               java.sql.Connection conn = java.sql.DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/postgres", "postgres", "Jason1509");


                // Check if student_number or email exists
                java.sql.PreparedStatement check = conn.prepareStatement("SELECT * FROM Users WHERE username = ? ");
                check.setString(1, username);
                java.sql.ResultSet rs = check.executeQuery();

                if (rs.next()) {
                    error = "Username already exists.";
                } else {
                    // Insert new user
                    java.sql.PreparedStatement insert = conn.prepareStatement(
                        "INSERT INTO Users (username, email, password) VALUES (?, ?, ?, )"
                    );              
                    insert.setString(1, username);         
                    insert.setString(2, email);               
                    insert.setString(3, password); // (optional) hash it later

                    int result = insert.executeUpdate();
                    if (result > 0) {
                        message = "Registration successful. You may now log in.";
                    } else {
                        error = "Failed to register.";
                    }
                }
                conn.close();
            } catch (Exception e) {
                error = "Error: " + e.getMessage();
            }
        }
    }
%>

   <form method="post">
        Username <input type="text" name="username" placeholder="Enter a username"><br/>        
        Email: <input type="text" name="email" placeholder="Enter an email"><br/>        
        Password: <input type="password" name="password" placeholder="Enter a password" ><br/>
        <input type="submit" value="Register">
    </form>

<p class="error"><%= error %></p>
<p class="success"><%= message %></p>
        </div>
        </div>
</body>
</html>
