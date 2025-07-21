<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Freelancer Login - WorkLink</title>
<%@ include file="../Components/allCss.jsp"%>

<style>
html, body {
	height: 100%;
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
}

.bg-cover {
	background-image:
		url('https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1600&q=80');
	
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.navbar-custom {
	background-color: rgba(0, 77, 64, 0.95);
	padding: 12px 30px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.navbar-custom .navbar-brand, .navbar-custom .nav-link {
	color: #fff;
}

.navbar-custom .nav-link:hover {
	color: #b2dfdb;
}

.login-container {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
}

.card {
	border-radius: 16px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
	padding: 30px;
	background-color: rgba(255, 255, 255, 0.95);
	color: #333;
	width: 100%;
	max-width: 480px;
}

.form-label {
	font-weight: 600;
}

.btn-login {
	background-color: #00695c;
	color: #fff;
	font-weight: 500;
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

	<div class="bg-cover">

		<!-- ✅ Navbar -->
		<nav class="navbar navbar-expand-lg navbar-custom">
			<div class="container-fluid">
				<a class="navbar-brand" href="../index.jsp"><i
					class="fas fa-briefcase"></i> Freelancer Worklink</a>
				<div class="collapse navbar-collapse">
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link" href="../index.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../admin/login.jsp">Admin Login</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../client/login.jsp">Client Login</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- ✅ Login Form -->
		<div class="login-container">
			<div class="card">
				<h4 class="text-center mb-4 text-success">
					<i class="fas fa-user"></i> Freelancer Login
				</h4>

				<%
				String success = (String) session.getAttribute("sucMsg");
				if (success != null) {
				%>
				<div class="alert alert-success text-center"><%=success%></div>
				<%
				session.removeAttribute("sucMsg");
				}
				%>

				<c:if test="${param.msg == 'invalid'}">
					<div class="alert alert-danger text-center">❌ Invalid Email
						or Password</div>
				</c:if>
				<c:if test="${param.msg == 'logout'}">
					<div class="alert alert-info text-center">✅ Logged out
						successfully</div>
				</c:if>
				<c:if test="${param.msg == 'success'}">
					<div class="alert alert-success text-center">✅ Registered
						successfully. Please log in.</div>
				</c:if>

				<form action="../FreelancerLoginServlet" method="post">
					<div class="mb-3">
						<label class="form-label">Email Address</label> <input
							type="email" name="email" class="form-control" required
							placeholder="example@email.com">
					</div>

					<div class="mb-3">
						<label class="form-label">Password</label>
						<div class="password-wrapper">
							<input type="password" id="password" name="password"
								class="form-control" required placeholder="Enter your password">
							<i class="fas fa-eye-slash toggle-password" id="togglePassword"></i>
						</div>
					</div>

					<div class="d-grid">
						<button type="submit" class="btn btn-login">Login</button>
					</div>

					<div class="mt-3 text-center">
						<small>Don't have an account? <a href="register.jsp">Register
								here</a></small>
					</div>
				</form>
			</div>
		</div>

	</div>

	<!-- ✅ Password Toggle Script -->
	<script>
		const togglePassword = document.getElementById("togglePassword");
		const passwordField = document.getElementById("password");

		togglePassword
				.addEventListener(
						"click",
						function() {
							const type = passwordField.getAttribute("type") === "password" ? "text"
									: "password";
							passwordField.setAttribute("type", type);
							this.classList.toggle("fa-eye");
							this.classList.toggle("fa-eye-slash");
						});
	</script>

</body>
</html>
