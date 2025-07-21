<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        background-image: url('https://images.unsplash.com/photo-1506377585622-bedcbb027afc?auto=format&fit=crop&w=1950&q=80');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        padding-top: 100px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .form-container {
        background-color: rgba(255, 255, 255, 0.98);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25);
        max-width: 600px;
        margin: auto;
    }

    .form-title {
        font-size: 1.8rem;
        font-weight: 600;
        color: #0d6efd;
        margin-bottom: 30px;
        text-align: center;
    }

    .input-group-text {
        background-color: transparent;
        border-left: 0;
        cursor: pointer;
    }

    .form-control:focus {
        box-shadow: none;
    }

    .alert {
        font-size: 0.95rem;
        padding: 12px 16px;
    }

    .btn-primary {
        background-color: #0d6efd;
        border: none;
    }

    .btn-primary:hover {
        background-color: #0b5ed7;
    }
</style>

<div class="container">
    <div class="form-container">
        <h2 class="form-title"><i class="fas fa-lock me-2"></i>Change Password</h2>

        <!-- Flash message -->
        <c:if test="${not empty msg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="../ChangePasswordServlet" method="post">
            <input type="hidden" name="clientId" value="${clientObj.id}" />

            <div class="mb-3">
                <label class="form-label">Old Password</label>
                <div class="input-group">
                    <input type="password" name="oldPassword" id="oldPassword" class="form-control" required />
                    <span class="input-group-text" onclick="toggleVisibility('oldPassword', this)">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">New Password</label>
                <div class="input-group">
                    <input type="password" name="newPassword" id="newPassword" class="form-control" required minlength="6" />
                    <span class="input-group-text" onclick="toggleVisibility('newPassword', this)">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Confirm New Password</label>
                <div class="input-group">
                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required minlength="6" />
                    <span class="input-group-text" onclick="toggleVisibility('confirmPassword', this)">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-sync-alt me-1"></i>Update Password
            </button>
        </form>
    </div>
</div>

<script>
    function toggleVisibility(fieldId, iconSpan) {
        const input = document.getElementById(fieldId);
        const icon = iconSpan.querySelector("i");

        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>

<%
    session.removeAttribute("msg");
    session.removeAttribute("error");
%>
