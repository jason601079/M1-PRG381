<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Login</title></head>
<body>
    <h2>Student Login</h2>
    <form method="post" action="LoginServlet">
        Student Number: <input type="text" name="student_number" required /><br/>
        Password: <input type="password" name="password" required /><br/>
        <input type="submit" value="Login" />
    </form>
    <p><a href="register.jsp">Register here</a></p>
    <p style="color:red;">${error}</p> 
</body>
</html>
