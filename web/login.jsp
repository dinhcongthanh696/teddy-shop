<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Teddy Bear Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/login.css">

    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="row w-75">
                <div class="col-md-6 d-flex align-items-center justify-content-center">
                    <img src="./images/loginimg.jpg" alt="Teddy Bear" class="img-fluid teddy-img">
                </div>
                <div class="col-md-6 login-box p-5  rounded shadow">
                    <h2 class="text-center mb-4">Welcome Back Cutie !</h2>
                    <c:if test="${not empty sessionScope.notification}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                            ${sessionScope.notification}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <%
                            session.removeAttribute("notification");
                        %>
                    </c:if>
                    <c:if test="${not empty sessionScope.notificationErr}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                            ${sessionScope.notificationErr}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <%
                            session.removeAttribute("notificationErr");
                        %>
                    </c:if>
                    <form id="loginForm" action="login" method="post">
                        <div class="mb-3">
                            <input type="text" class="form-control" name="username" placeholder="Enter your username...">
                        </div>
                        <div class="mb-3">
                            <input type="password" class="form-control" name="password" placeholder="Password">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                        <a href="google-login" class="btn btn-danger w-100 mt-2">
                            <i class="fab fa-google"></i> Login with Google
                        </a>

                    </form>
                    <div class="text-center mt-3">
                        <a href="#" class="text-decoration-none">Forgot Password?</a>
                        <br>
                        <a href="register" class="text-decoration-none">Create an Account</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/form-validation.js"></script>
    </body>
</html>
