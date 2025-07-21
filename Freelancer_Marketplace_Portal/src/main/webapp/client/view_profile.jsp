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
    background-image: url('https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?auto=format&fit=crop&w=1950&q=80');
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    min-height: 100vh;
    padding-top: 80px;
  }

  .profile-card {
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  }

  .profile-header {
    font-size: 1.5rem;
    font-weight: 600;
  }

  .profile-label {
    font-weight: 500;
    color: #555;
  }

  .profile-value {
    color: #333;
  }
</style>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="profile-card mt-5">

        <!-- Success/Error Alert -->
        <c:if test="${not empty successMsg}">
          <div class="alert alert-success" role="alert">${successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
        </c:if>
        <c:if test="${not empty errorMsg}">
          <div class="alert alert-danger" role="alert">${errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
          <h3 class="profile-header"><i class="fas fa-user-circle me-2"></i>Your Profile</h3>
          <a href="edit_profile.jsp" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Edit</a>
        </div>
        <hr>
        <div class="row mb-3">
          <div class="col-md-4 profile-label">Full Name:</div>
          <div class="col-md-8 profile-value">${clientObj.fullname}</div>
        </div>
        <div class="row mb-3">
          <div class="col-md-4 profile-label">Email:</div>
          <div class="col-md-8 profile-value">${clientObj.email}</div>
        </div>
        <div class="row mb-3">
          <div class="col-md-4 profile-label">Company:</div>
          <div class="col-md-8 profile-value">${clientObj.company}</div>
        </div>
        <div class="row mb-3">
          <div class="col-md-4 profile-label">Skills:</div>
          <div class="col-md-8 profile-value">
            <c:out value="${clientObj.skills != null ? clientObj.skills : 'N/A'}"/>
          </div>
        </div>
        <div class="row mb-3">
          <div class="col-md-4 profile-label">Registered On:</div>
          <div class="col-md-8 profile-value">${clientObj.regDate}</div>
        </div>
      </div>
    </div>
  </div>
</div>
