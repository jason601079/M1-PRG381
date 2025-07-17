<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    if (session == null || session.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head><title>Dashboard</title></head>
<body>
    <h2>Welcome, <%= session.getAttribute("studentName") %>!</h2>
    <form action="LogoutServlet" method="post">
        <input type="submit" value="Logout" />
    </form>
</body>
</html>
