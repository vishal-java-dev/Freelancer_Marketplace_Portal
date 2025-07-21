<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../Components/allCss.jsp" %>
<%@ include file="navbar.jsp" %>

<%
    com.entity.Client clientObj = (com.entity.Client) session.getAttribute("clientObj");
    if (clientObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<style>
  body {
    background-image: url('https://images.unsplash.com/photo-1535223289827-42f1e9919769?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    min-height: 100vh;
    padding-top: 80px;
    font-family: 'Segoe UI', sans-serif;
  }

  .project-form {
    background-color: rgba(255, 255, 255, 0.94);
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    margin-top: 50px;
  }

  .form-label {
    font-weight: 500;
  }

  .btn-submit {
    width: 100%;
  }

  .form-title {
    font-weight: 600;
    color: #0d6efd;
  }

  input, textarea, select {
    background-color: #fdfdfd;
  }
</style>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="project-form">
        <h3 class="text-center form-title mb-4">
          <i class="fas fa-briefcase me-2"></i>Post a New Project
        </h3>

        <!-- Optional message alert -->
        <c:if test="${not empty param.error}">
          <div class="alert alert-danger">${param.error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
          <div class="alert alert-success">${param.success}</div>
        </c:if>

        <form action="../PostProjectServlet" method="post">
          <div class="mb-3">
            <label for="title" class="form-label">Project Title</label>
            <input type="text" class="form-control" id="title" name="title" required>
          </div>

          <div class="mb-3">
            <label for="category" class="form-label">Category</label>
            <select class="form-select" id="category" name="category" required>
              <option value="">-- Select Category --</option>
              <option value="Web Development">Web Development</option>
              <option value="Mobile App">Mobile App</option>
              <option value="UI/UX Design">UI/UX Design</option>
              <option value="Data Entry">Data Entry</option>
              <option value="Other">Other</option>
            </select>
          </div>

          <div class="mb-3">
            <label for="description" class="form-label">Project Description</label>
            <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
          </div>

          <div class="mb-3">
            <label for="skills" class="form-label">Required Skills</label>
            <input type="text" class="form-control" id="skills" name="skills" placeholder="e.g., Java, MySQL, HTML" required>
          </div>

          <div class="mb-3">
            <label for="budget" class="form-label">Estimated Budget (INR)</label>
            <input type="number" class="form-control" id="budget" name="budget" min="100" required>
          </div>

          <div class="mb-3">
            <label for="deadline" class="form-label">Deadline</label>
            <input type="date" class="form-control" id="deadline" name="deadline" required>
          </div>

          <!-- Hidden fields for required non-input DB values -->
          <input type="hidden" name="clientId" value="<%= clientObj.getId() %>">
          <input type="hidden" name="clientEmail" value="<%= clientObj.getEmail() %>">
          <input type="hidden" name="freelancerName" value=""> <!-- required for NOT NULL -->

          <button type="submit" class="btn btn-primary btn-submit">
            <i class="fas fa-paper-plane me-1"></i>Post Project
          </button>
        </form>
      </div>
    </div>
  </div>
</div>
