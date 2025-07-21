<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<style>
	.custom-dark-nav {
		background-color: #1f1f2e; /* modern dark tone */
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	}
	.custom-dark-nav .nav-link,
	.custom-dark-nav .navbar-brand {
		color: #f1f1f1 !important;
	}
	.custom-dark-nav .nav-link:hover {
		color: #00c6ff !important; /* modern cyan-blue hover */
	}
	.dropdown-menu {
		background-color: #2c2c3c;
	}
	.dropdown-menu .dropdown-item {
		color: #f1f1f1;
	}
	.dropdown-menu .dropdown-item:hover {
		background-color: #3a3a50;
		color: #00c6ff;
	}
</style>

<nav class="navbar navbar-expand-lg custom-dark-nav">
	<div class="container-fluid">
		<a class="navbar-brand fw-bold" href="index.jsp">
			<i class="fa-solid fa-briefcase"></i> FreeLancePro
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">

				<!-- Not Logged In -->
				<c:if test="${empty userObj}">
					<li class="nav-item">
						<a class="nav-link" href="freelancer/register.jsp">
							<i class="fa-solid fa-user-plus"></i> Become a Freelancer
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="client/register.jsp">
							<i class="fa-solid fa-user-plus"></i> Hire Talent
						</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">
							<i class="fa-solid fa-right-to-bracket"></i> Login
						</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown">
							<li><a class="dropdown-item" href="client/login.jsp">Client Login</a></li>
							<li><a class="dropdown-item" href="freelancer/login.jsp">Freelancer Login</a></li>
							<li><a class="dropdown-item" href="admin/login.jsp">Admin Login</a></li>
						</ul>
					</li>
				</c:if>

			</ul>
		</div>
	</div>
</nav>
