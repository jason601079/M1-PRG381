<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
<head><title>Dashboard</title></head>
<body>
    <h2>Welcome, <%= username %>!</h2>
    <a href="index.jsp">Logout</a>
</body>
</html>
