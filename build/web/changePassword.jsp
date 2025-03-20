<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password - Teddy Bear</title>
        <!-- Import Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Import Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/changePassword.css">
    </head>
    <body>
        <!-- Navigation Bar (if any) -->
   
        <jsp:include page="/gui/header.jsp"></jsp:include>
        <!-- Change Password Form -->
        <div class="container d-flex flex-column align-items-center justify-content-center min-vh-100">
            <h2 class="text-center mt-4">Change Password</h2>
            <c:if test="${not empty sessionScope.notification}">
                <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                    ${sessionScope.notification}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("notification"); %>
            </c:if>
            <c:if test="${not empty sessionScope.notificationErr}">
                <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                    ${sessionScope.notificationErr}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("notificationErr"); %>
            </c:if>

            <!-- IMPORTANT: Note the form action is "change-password" (matching the servlet mapping) -->
            <form action="change-password" method="post" class="password-form w-50">
                <div class="mb-3">
                    <input type="password" class="form-control" name="oldPassword" placeholder="Old Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="newPassword" placeholder="New Password" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <button type="submit" class="btn btn-custom w-100">Save Change</button>
            </form>
        </div>

        <!-- Import Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Include change password validation JS -->
        <script src="${pageContext.request.contextPath}/js/changePassword-validation.js"></script>
    </body>
</html>
