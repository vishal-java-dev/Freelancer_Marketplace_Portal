<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Client Registration</title>
<%@ include file="../Components/allCss.jsp" %>

<style>
body {
  background: url('https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1600&q=80') no-repeat center center fixed;
  background-size: cover;
  font-family: 'Segoe UI', sans-serif;
  margin: 0;
  min-height: 100vh;
}

.navbar-custom {
  background-color: #0d6efd;
  padding: 15px 30px;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.navbar-custom .navbar-brand {
  color: #fff;
  font-weight: 600;
  font-size: 20px;
}

.navbar-custom .nav-link {
  color: #eaeaea;
  margin-left: 20px;
  transition: color 0.3s ease;
}
.navbar-custom .nav-link:hover {
  color: #fff;
  text-decoration: underline;
}

.register-container {
  padding-top: 100px;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  min-height: 100vh;
  padding-bottom: 50px;
}

.register-form {
  background-color: rgba(255, 255, 255, 0.97);
  padding: 40px;
  border-radius: 16px;
  width: 100%;
  max-width: 500px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.form-title {
  font-weight: 600;
  color: #0d6efd;
}

.password-toggle {
  position: relative;
}
.password-toggle i {
  position: absolute;
  top: 73%;
  right: 16px;
  transform: translateY(-50%);
  cursor: pointer;
  color: #666;
}
</style>
</head>
<body>

<!-- ✅ Custom Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
  <div class="container-fluid">
    <a class="navbar-brand" href="../index.jsp">Freelancer Portal</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="../index.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
        <li class="nav-item"><a class="nav-link active" href="register.jsp">Register</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- ✅ Centered Form -->
<div class="register-container">
  <div class="register-form">
    <h3 class="text-center form-title mb-4">
      <i class="fas fa-user-plus me-2"></i>Client Registration
    </h3>

    <form action="../ClientRegisterServlet" method="post" autocomplete="on">
      <div class="mb-3">
        <label for="fullname" class="form-label">Full Name</label> 
        <input type="text" class="form-control" id="fullname" name="fullname" required
               title="Please enter your full name" autocomplete="name">
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email Address</label> 
        <input type="email" class="form-control" id="email" name="email" required
               title="We'll use this for login and communication" autocomplete="email">
      </div>

      <div class="mb-3">
        <label for="company" class="form-label">Company</label> 
        <input type="text" class="form-control" id="company" name="company"
               placeholder="Your company name (optional)">
      </div>

      <div class="mb-3 password-toggle">
        <label for="password" class="form-label">Create Password</label> 
        <input type="password" class="form-control" id="password" name="password"
               required minlength="6" autocomplete="new-password"
               title="Password should be at least 6 characters">
        <i class="fa fa-eye" id="togglePassword"></i>
      </div>

      <div class="mb-3">
        <label for="skills" class="form-label">Skills Needed</label> 
        <input type="text" class="form-control" id="skills" name="skills"
               placeholder="e.g. Java, React, UI Design" title="Mention key skills you’re looking for">
      </div>

      <button type="submit" class="btn btn-primary w-100">Register</button>

      <p class="text-center mt-3 mb-0">
        Already have an account? <a href="login.jsp">Login</a>
      </p>
    </form>
  </div>
</div>

<!-- ✅ Toggle password visibility -->
<script>
  const toggle = document.getElementById('togglePassword');
  const password = document.getElementById('password');

  toggle.addEventListener('click', () => {
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
    toggle.classList.toggle('fa-eye');
    toggle.classList.toggle('fa-eye-slash');
  });
</script>

</body>
</html>
