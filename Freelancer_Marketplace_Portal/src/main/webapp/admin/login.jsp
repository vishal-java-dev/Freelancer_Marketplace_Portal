<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <%@ include file="../Components/allCss.jsp"%>

    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .bg-cover {
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1600&q=80') 
                        no-repeat center center/cover;
            height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding-top: 100px;
        }

        .card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            border-radius: 18px;
            padding: 40px 35px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            max-width: 440px;
            width: 100%;
            color: #333;
            transition: all 0.3s ease-in-out;
        }

        .card:hover {
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .btn-login {
            background-color: #00695c;
            color: #fff;
            font-weight: 500;
            padding: 10px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .btn-login:hover {
            background-color: #004d40;
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
        }
    </style>
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(90deg, #0f2027, #203a43, #2c5364);">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="../index.jsp" style="font-size: 1.5rem;">
            <i class="fas fa-briefcase me-2"></i> WorkLink Admin
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link text-white" href="../index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="../client/login.jsp">Client Login</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="../freelancer/login.jsp">Freelancer Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Login Form Section -->
<div class="bg-cover">
    <div class="card">
        <h4 class="text-center mb-4 fw-semibold text-dark">
            <i class="fas fa-user-shield me-2"></i>Admin Login
        </h4>

        <!-- ✅ Session-based message -->
        <%
            if (session.getAttribute("sucMsg") != null) {
        %>
            <div class="alert alert-success text-center"><%= session.getAttribute("sucMsg") %></div>
        <%
                session.removeAttribute("sucMsg");
            }
        %>

        <!-- ✅ JSTL-based alerts -->
        <c:if test="${param.msg == 'invalid'}">
            <div class="alert alert-danger text-center">❌ Invalid Email or Password</div>
        </c:if>
        <c:if test="${param.msg == 'logout'}">
            <div class="alert alert-info text-center">✅ Logged out successfully</div>
        </c:if>

        <form action="../AdminLoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Email address</label>
                <input type="email" class="form-control" name="email" required placeholder="example@email.com">
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="password-wrapper">
                    <input type="password" class="form-control" name="password" id="password" required>
                    <i class="fas fa-eye-slash toggle-password" id="togglePassword"></i>
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-login">Login</button>
            </div>
        </form>
    </div>
</div>

<!-- ✅ Password Toggle Script -->
<script>
    const togglePassword = document.getElementById("togglePassword");
    const passwordInput = document.getElementById("password");

    togglePassword.addEventListener("click", function () {
        const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
        passwordInput.setAttribute("type", type);
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
    });
</script>

</body>
</html>
