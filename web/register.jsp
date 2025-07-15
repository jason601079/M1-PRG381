

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
        String studentNumber = request.getParameter("student_number");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (studentNumber.isEmpty() || name.isEmpty() || surname.isEmpty() ||
                email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            error = "All fields are required.";
        } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            error = "Invalid email format.";
        } else if (!phone.matches("\\d{10}")) {
            error = "Phone number must be exactly 10 digits.";
        } else if (password.length() < 6) {
            error = "Password must be at least 6 characters.";
        } else {
            try {
                Class.forName("org.postgresql.Driver");
               java.sql.Connection conn = java.sql.DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/WebAppPRG", "postgres", "12345678");


                // Check if student_number or email exists
                java.sql.PreparedStatement check = conn.prepareStatement("SELECT * FROM users WHERE email = ? OR student_number = ?");
                check.setString(1, email);
                check.setString(2, studentNumber);
                java.sql.ResultSet rs = check.executeQuery();

                if (rs.next()) {
                    error = "Email or Student Number already exists.";
                } else {
                    // Insert new user
                    java.sql.PreparedStatement insert = conn.prepareStatement(
                        "INSERT INTO users (student_number, name, surname, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)"
                    );
                    insert.setString(1, studentNumber);
                    insert.setString(2, name);
                    insert.setString(3, surname);
                    insert.setString(4, email);
                    insert.setString(5, phone);
                    insert.setString(6, password); // (optional) hash it later

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
        Student Number: <input type="text" name="student_number" placeholder="Enter student number"><br/>
        Name: <input type="text" name="name" placeholder="Enter name"><br/>
        Surname: <input type="text" name="surname" placeholder="Enter surname"><br/>
        Email: <input type="text" name="email" placeholder="Enter email"><br/>
        Phone: <input type="text" name="phone" placeholder="Enter phone number"><br/>
        Password: <input type="password" name="password" placeholder="Enter password" ><br/>
        <input type="submit" value="Register">
    </form>

<p class="error"><%= error %></p>
<p class="success"><%= message %></p>
        </div>
        </div>
</body>
</html>
