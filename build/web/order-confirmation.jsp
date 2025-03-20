<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS (if needed) -->
    <link rel="stylesheet" href="${contextPath}/css/success.css">
    <style>
        .success-container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <jsp:include page="gui/header.jsp" />
    <div class="container success-container" style="margin-top: 100px">
        <div class="alert alert-success text-center">
            <h2>Thank You for Your Order!</h2>
            <p>Your order has been successfully placed.</p>
        </div>
        <div class="text-center mt-4">
            <a href="${contextPath}/MenuController?service=productInformation" class="btn btn-primary" style="margin-bottom: 20px">Continue Shopping</a>
        </div>
    </div>
    <jsp:include page="gui/footer.jsp" />
    <!-- Bootstrap and jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
