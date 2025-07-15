<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg = "";
    String action = request.getParameter("action");

    if ("register".equals(action)) {
        String username = request.getParameter("reg_username");
        String email = request.getParameter("reg_email");
        String password = request.getParameter("reg_password");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                  "jdbc:postgresql://localhost:5432/M1", "postgres", "Jason1509");

            PreparedStatement ps = conn.prepareStatement("INSERT INTO students(username, email, password) VALUES (?, ?, ?)");

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            int rows = ps.executeUpdate();

            msg = (rows > 0) ? "Registration successful!" : "Registration failed!";
            conn.close();
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }

    } else if ("login".equals(action)) {
        String username = request.getParameter("login_username");
        String password = request.getParameter("login_password");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/M1", "postgres", "Jason1509");

           PreparedStatement ps = conn.prepareStatement("SELECT * FROM students WHERE username=? AND password=?");

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("username", username);
                response.sendRedirect("success.jsp");
            } else {
                msg = "Invalid credentials!";
            }
            conn.close();
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Login / Register Form</title>
  <link rel="stylesheet" href="css/style.css" />
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
</head>
<body>
<div class="container">
  <div class="form-box">
    <div class="form-toggle" id="toggleForm">
      <div id="formText">Hello, Welcome!</div>
      <button id="switchBtn">Register</button>
    </div>

    <div class="slider">
      <div class="slider-inner" id="sliderInner">
        <!-- REGISTER FORM -->
        <div class="form register-form">
          <h1>Registration</h1>
          <form method="post">
            <input type="hidden" name="action" value="register" />
            <div class="input-box">
              <input type="text" name="reg_username" placeholder="Username" required />
              <i class="bx bxs-user"></i>
            </div>
            <div class="input-box">
              <input type="email" name="reg_email" placeholder="Email" required />
              <i class="bx bxs-envelope"></i>
            </div>
            <div class="input-box">
              <input type="password" name="reg_password" placeholder="Password" required />
              <i class="bx bxs-lock"></i>
              <i class="bx bxs-lock toggle-password"></i>
            </div>
            <button type="submit" class="btn">Register</button>
            <div class="social">
                or register with
                <div class="icons">
                  <i class="bx bxl-google"></i>
                  <i class="bx bxl-facebook"></i>
                  <i class="bx bxl-github"></i>
                  <i class="bx bxl-linkedin"></i>
                </div>
            </div>    
          </form>
        </div>

        <!-- LOGIN FORM -->
        <div class="form login-form">
          <h1>Login</h1>
          <form method="post">
            <input type="hidden" name="action" value="login" />
            <div class="input-box">
              <input type="text" name="login_username" placeholder="Username" required />
              <i class="bx bxs-user"></i>
            </div>
            <div class="input-box">
              <input type="password" name="login_password" placeholder="Password" required />
              <i class="bx bxs-lock"></i>
              <i class="bx bxs-lock toggle-password"></i>
            </div>
            <a href="#" class="forgot-link">Forgot Password?</a>
            <button type="submit" class="btn">Login</button>
            <div class="social">
                or login with
                <div class="icons">
                  <i class="bx bxl-google"></i>
                  <i class="bx bxl-facebook"></i>
                  <i class="bx bxl-github"></i>
                  <i class="bx bxl-linkedin"></i>
                </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<% if (!msg.isEmpty()) { %>
  <script>alert("<%= msg %>");</script>
<% } %>

<script>
    document.querySelectorAll('.toggle-password').forEach(icon => {
    icon.addEventListener('click', () => {
      const input = icon.parentElement.querySelector('.password');
      const isVisible = input.type === 'text';

      input.type = isVisible ? 'password' : 'text';
      icon.classList.toggle('bx-show', isVisible);
      icon.classList.toggle('bx-hide', !isVisible);
    });
  });
    
  const toggleBtn = document.getElementById("switchBtn");
  const formText = document.getElementById("formText");
  const sliderInner = document.getElementById("sliderInner");

  let isLogin = false;

  toggleBtn.addEventListener("click", () => {
    isLogin = !isLogin;
    sliderInner.style.transform = isLogin ? "translateX(-50%)" : "translateX(0%)";
    formText.textContent = isLogin ? "Welcome Back!" : "Hello, Welcome!";
    toggleBtn.textContent = isLogin ? "Login" : "Register";
  });
</script>
</body>
</html>
