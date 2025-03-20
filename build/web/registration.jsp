<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Teddy Bear Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/registration.css">
    <script src="${pageContext.request.contextPath}/js/form-validation.js"></script>
  </head>
  <body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
      <div class="row w-75">
        <div class="col-md-6 d-flex align-items-center justify-content-center">
          <img src="${pageContext.request.contextPath}/images/loginimg.jpg" alt="Teddy Bear" class="img-fluid teddy-img">
        </div>
        <div class="col-md-6 login-box p-5 rounded shadow">
          <h2 class="text-center mb-4">Join Us Cutie !</h2>
          <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
              ${sessionScope.notification}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notification"); %>
          </c:if>
          <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
              ${sessionScope.notificationErr}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notificationErr"); %>
          </c:if>
          <form id="registrationForm" action="register" method="post">
            <div class="mb-3">
              <input type="email" class="form-control" name="email" placeholder="Enter your email..." 
                value="${sessionScope.regEmail != null ? sessionScope.regEmail : ''}">
            </div>
            <div class="mb-3">
              <input type="text" class="form-control" name="username" placeholder="Enter a username..." 
                value="${sessionScope.regUsername != null ? sessionScope.regUsername : ''}">
            </div>
            <div class="mb-3">
              <input type="text" class="form-control" name="phone" placeholder="Enter your phone number..." 
                value="${sessionScope.regPhone != null ? sessionScope.regPhone : ''}">
            </div>
            <div class="mb-3">
              <input type="text" class="form-control" name="location" placeholder="Enter your location..." 
                value="${sessionScope.regLocation != null ? sessionScope.regLocation : ''}">
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="password" placeholder="Create a password">
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="confirm_password" placeholder="Confirm your password">
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
            <button class="btn btn-danger w-100 mt-2">
              <i class="fab fa-google"></i> Sign up with Google
            </button>
          </form>
          <div class="text-center mt-3">
            <a href="login" class="text-decoration-none">Already have an account? Login</a>
          </div>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/form-validation.js"></script>
  </body>
</html>
