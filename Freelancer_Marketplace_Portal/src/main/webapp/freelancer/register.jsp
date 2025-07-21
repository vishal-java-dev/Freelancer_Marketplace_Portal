<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Freelancer Registration</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1650&q=80') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar-custom {
            background-color: #20c997; /* ✅ Teal */
            padding: 15px 30px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 999;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .navbar-custom .navbar-brand {
            color: #fff;
            font-weight: 600;
            font-size: 20px;
        }

        .navbar-custom .nav-link {
            color: #e9f7f6;
            margin-left: 20px;
            transition: color 0.3s ease;
        }

        .navbar-custom .nav-link:hover {
            color: #fff;
            text-decoration: underline;
        }

        .register-card {
            max-width: 600px;
            margin: 120px auto 60px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.96);
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .form-label {
            font-weight: 600;
            color: #222;
        }

        .form-control:focus {
            border-color: #20c997;
            box-shadow: 0 0 0 0.2rem rgba(32, 201, 151, 0.25);
        }

        .password-toggle {
            position: relative;
        }

        .password-toggle i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #777;
        }

        .text-center a {
            text-decoration: none;
        }

        .btn-custom {
            background-color: #20c997;
            border: none;
        }

        .btn-custom:hover {
            background-color: #17b89b;
        }
    </style>
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="../index.jsp">Freelancer Portal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="../index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="register.jsp">Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Registration Form -->
<div class="container">
    <div class="register-card">
        <h3 class="text-center mb-4" style="color: #20c997;">
            <i class="fa-solid fa-user-plus me-2"></i>Freelancer Registration
        </h3>

        <form action="../FreelancerRegisterServlet" method="post" autocomplete="on">
            <div class="mb-3">
                <label for="fullname" class="form-label">Full Name</label>
                <input type="text" name="fullname" class="form-control" id="fullname" required autocomplete="name">
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" id="email" required autocomplete="email">
            </div>

            <div class="mb-3">
                <label for="skills" class="form-label">Skills</label>
                <input type="text" name="skills" class="form-control" id="skills" placeholder="e.g. Java, HTML, MySQL" required>
            </div>

            <div class="mb-3">
                <label for="experience" class="form-label">Experience (in years)</label>
                <input type="number" name="experience" class="form-control" id="experience" min="0" required>
            </div>

            <div class="mb-3 password-toggle">
                <label for="password" class="form-label">Create Password</label>
                <input type="password" name="password" class="form-control" id="password" required minlength="6"
                       autocomplete="new-password">
                <i class="fa-solid fa-eye" id="togglePassword"></i>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-custom text-white">
                    <i class="fa-solid fa-user-plus me-1"></i> Register
                </button>
            </div>

            <div class="text-center mt-3">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </form>
    </div>
</div>

<!-- ✅ Toggle password visibility -->
<script>
    const togglePassword = document.getElementById('togglePassword');
    const passwordField = document.getElementById('password');

    togglePassword.addEventListener('click', () => {
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
        togglePassword.classList.toggle('fa-eye');
        togglePassword.classList.toggle('fa-eye-slash');
    });
</script>

</body>
</html>
