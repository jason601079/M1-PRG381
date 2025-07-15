<%-- 
    Document   : dashboard
    Created on : 09 Jul 2025, 09:53:27
    Author     : Cosmo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String studentName = (String) session.getAttribute("studentName");

    if (studentName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Wellness Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <header>
            <h1>Student Wellness System</h1>
        </header>
        <div class="container">
            <div class="card">    
       <h2>Welcome, <%= studentName %>!</h2>
        <p>You are logged in to the Student Wellness System!</p>
        
       <form action="LogoutServlet" method="post">
       <input type="submit" value="Logout" class="logout-btn">
       </form>
        </div>
        </div>
    </body>
</html>
