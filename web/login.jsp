
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <header>
            <h1>Student Wellness System</h1>
        </header>
        <div class="container">
            <div class="card">
                <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="Enter username" required/><br/>
            <input type="password" name="password" placeholder="Enter password" required/><br/>
        <input type="submit" value="Login"/>
    </form>
         <%-- show error message if login fails --%>
        <p class="error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </p> 
        </div>
        </div>
    </body>
</html>
