<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Freelancer Marketplace Portal</title>
  <%@ include file="Components/allCss.jsp" %>
  <style>
    .hero {
      background: url('https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=1600') center/cover no-repeat;
      position: relative;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }

    .hero .overlay {
      z-index: 1;
    }

    .hero .container {
      z-index: 2;
    }

    .hero h1, .hero p {
      color: #fff;
    }
    
    .hero h1:hover, .hero p:hover{
    color:  #ffc107;
    }

    .hero .btn {
      padding: 0.75rem 1.5rem;
      font-size: 1.1rem;
    }

    /* Features hover */
    .features .card {
      border: none;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .features .card:hover {
      transform: translateY(-8px);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
    }

    /* How It Works hover */
    .steps .step {
      text-align: center;
      padding: 1rem;
      background-color: #fff;
      border-radius: 8px;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .steps .step:hover {
      transform: translateY(-8px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    .steps .step i {
      font-size: 3rem;
      color: #0d6efd;
      margin-bottom: 0.5rem;
    }

    /* Testimonials hover */
    .testimonial-card {
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .testimonial-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }

    .footer {
      background: #f8f9fa;
      padding: 2rem 0;
      margin-top: 2rem;
      text-align: center;
    }
  </style>
</head>
<body>

<%@ include file="Components/Navbar.jsp" %>

<!-- Hero Section -->
<section class="hero position-relative">
  <div class="overlay position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-75"></div>
  <div class="container position-relative text-white text-center py-5">
    <h1 class="display-4 fw-bold mb-3 ">Find the Perfect Match for Your Projects</h1>
    <p class="lead mb-4">Hire expert freelancers, grow your skills, and manage your workflow efficiently.</p>
    <a href="freelancer/register.jsp" class="btn btn-lg btn-primary me-3">Join Now</a>
    <a href="#how-it-works" class="btn btn-lg btn-outline-light">Learn More</a>
  </div>
</section>

<!-- Features -->
<section class="features py-5">
  <div class="container">
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card text-center p-4">
          <i class="fas fa-user-tie fa-3x text-primary mb-3"></i>
          <h5>For Clients</h5>
          <p>Post projects, review bids, and hire skilled freelancers with confidence.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center p-4">
          <i class="fas fa-laptop-code fa-3x text-primary mb-3"></i>
          <h5>For Freelancers</h5>
          <p>Explore opportunities, bid on projects, and grow your portfolio with ease.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center p-4">
          <i class="fas fa-users-cog fa-3x text-primary mb-3"></i>
          <h5>For Admins</h5>
          <p>Manage users, track transactions, and maintain platform integrity effortlessly.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- How It Works -->
<section id="how-it-works" class="py-5 bg-light">
  <div class="container">
    <h2 class="text-center mb-4">How It Works</h2>
    <div class="row steps g-4">
      <div class="col-md-3 step">
        <i class="fas fa-pencil-alt"></i>
        <h6>Post Project</h6>
        <p>Describe your needs and set a budget.</p>
      </div>
      <div class="col-md-3 step">
        <i class="fas fa-gavel"></i>
        <h6>Review Bids</h6>
        <p>Get bids from talented freelancers and choose the best fit.</p>
      </div>
      <div class="col-md-3 step">
        <i class="fas fa-cogs"></i>
        <h6>Start Work</h6>
        <p>Collaborate, track progress, and communicate easily.</p>
      </div>
      <div class="col-md-3 step">
        <i class="fas fa-hand-holding-usd"></i>
        <h6>Pay & Review</h6>
        <p>Securely release payment and rate your experience.</p>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials -->
<section class="py-5 bg-light text-center">
  <div class="container">
    <h2 class="mb-5">What Our Users Say</h2>
    <div class="row g-4 justify-content-center">

      <!-- Client Testimonial -->
      <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 h-100 testimonial-card">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" class="rounded-circle mx-auto mb-3" alt="Client Image" width="80" height="80">
          <h5 class="fw-bold">Ayesha Kapoor</h5>
          <small class="text-muted">Startup Founder</small>
          <p class="mt-3">“I posted a project and hired a developer within 48 hours. Seamless experience and top-quality work!”</p>
        </div>
      </div>

      <!-- Freelancer Testimonial -->
      <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 h-100 testimonial-card">
          <img src="https://randomuser.me/api/portraits/men/32.jpg" class="rounded-circle mx-auto mb-3" alt="Freelancer Image" width="80" height="80">
          <h5 class="fw-bold">Rahul Sharma</h5>
          <small class="text-muted">Full-Stack Developer</small>
          <p class="mt-3">“WorkLink helped me land consistent freelance projects and build my portfolio quickly.”</p>
        </div>
      </div>

      <!-- Admin Testimonial -->
      <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 h-100 testimonial-card">
          <img src="https://randomuser.me/api/portraits/men/85.jpg" class="rounded-circle mx-auto mb-3" alt="Admin Image" width="80" height="80">
          <h5 class="fw-bold">Kunal Verma</h5>
          <small class="text-muted">Platform Admin</small>
          <p class="mt-3">“Managing users, payments, and projects is extremely easy through the admin dashboard.”</p>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <p>&copy; 2025 Freelancer Marketplace Portal (WorkLink). All Rights Reserved.</p>
    <small>Designed for freelancers, clients, and admins to collaborate and grow together.</small>
  </div>
</footer>

</body>
</html>
