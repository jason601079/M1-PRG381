<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>
</head>
<body>
    <h2>Register</h2>

    <%-- Display message if any (success or error) --%>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <form action="RegisterServlet" method="post">
        <label for="name">Name:</label><br/>
        <input type="text" id="name" name="name" required /><br/><br/>

        <label for="surname">Surname:</label><br/>
        <input type="text" id="surname" name="surname" required /><br/><br/>

        <label for="email">Email:</label><br/>
        <input type="email" id="email" name="email" required /><br/><br/>

        <label for="phone">Phone:</label><br/>
        <input type="text" id="phone" name="phone" required /><br/><br/>

        <label for="password">Password:</label><br/>
        <input type="password" id="password" name="password" required /><br/><br/>

        <label for="confirmPassword">Confirm Password:</label><br/>
        <input type="password" id="confirmPassword" name="confirmPassword" required /><br/><br/>

        <input type="submit" value="Register" />
    </form>
</body>
</html>
