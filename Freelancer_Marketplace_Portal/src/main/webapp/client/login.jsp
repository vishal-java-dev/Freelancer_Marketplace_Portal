<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../Components/allCss.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Login</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .bg-cover {
            background: url('https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=1600&q=80') 
                        no-repeat center center/cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 60px;
        }

        .login-form {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .form-title {
            font-weight: 600;
            color: #0d6efd;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: none;
        }

        .custom-navbar {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #0d6efd;
            color: white;
            padding: 10px 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            z-index: 999;
        }

        .custom-navbar a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            margin-left: 15px;
        }

        .custom-navbar a:hover {
            text-decoration: underline;
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
<div class="custom-navbar d-flex justify-content-between align-items-center">
    <div class="brand fw-bold fs-5">
        Freelancer Portal
    </div>
    <div>
        <a href="../index.jsp">Home</a>
        <a href="../admin/login.jsp">Admin Login</a>       
        <a href="../freelancer/login.jsp">Freelancer Login</a>
    </div>
</div>

<!-- ✅ Login Form -->
<div class="bg-cover">
    <div class="login-form">
        <h3 class="text-center form-title mb-4">
            <i class="fas fa-sign-in-alt me-2"></i>Client Login
        </h3>

        <!-- ✅ Java error from session -->
        <c:if test="${not empty sessionScope.errorMsg}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMsg" scope="session" />
        </c:if>

        <!-- ✅ JSTL param-based error -->
        <c:if test="${param.msg == 'invalid'}">
            <div class="alert alert-danger text-center">
                ❌ Invalid Email or Password
            </div>
        </c:if>

        <form action="../ClientLoginServlet" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" id="email" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="password-wrapper">
                    <input type="password" name="password" class="form-control" id="password" required>
                    <i class="fas fa-eye-slash toggle-password" id="togglePassword"></i>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100">Login</button>

            <p class="text-center mt-3 mb-0">
                Don't have an account? <a href="register.jsp">Register</a>
            </p>
        </form>
    </div>
</div>

<!-- ✅ Password Toggle Script -->
<script>
    const togglePassword = document.getElementById("togglePassword");
    const passwordField = document.getElementById("password");

    togglePassword.addEventListener("click", function () {
        const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
        passwordField.setAttribute("type", type);
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
    });
</script>

</body>
</html>
