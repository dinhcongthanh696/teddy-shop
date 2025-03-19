<%-- 
    Document   : index.jsp
    Created on : Jan 24, 2025, 11:10:28 AM
    Author     : OS
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
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
            <h1 style="text-align: center"> Admin Page</h1>
           Hello ${user.getUserName()}
        </div>

        <!-- Import Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Include change password validation JS -->
    </body>
</html>
