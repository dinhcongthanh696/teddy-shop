<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
             background-color: #f9ece6 !important; 
            font-family: 'Arial', sans-serif;
        }
        .container {
            width: 100%;
            max-width: 1400px;
            margin: 50px auto;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .product-info h2 {
            font-weight: bold;
            font-size: 32px;
            color: #333;
        }
        .product-price {
            font-size: 28px;
            color: #28a745;
            font-weight: bold;
            margin-top: 10px;
        }
        .product-details p {
            font-size: 18px;
            color: #555;
            margin: 10px 0;
        }
        .btn-back {
            margin-top: 20px;
            padding: 12px 25px;
            font-size: 18px;
            border-radius: 5px;
        }
        .badge-category {
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-right: 10px;
        }
        .badge-type {
            background-color: #6c757d;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body style="margin-top: 80px">
  <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
  <div class="container" style="background-color: #f3e5f5 !important">
        <h2 class="text-center">${product.name}</h2>
        <br>
        <div class="row align-items-center">
            <!-- Product Image Section -->
            <div class="col-md-6">
                <img src="../${product.image}" class="product-image img-fluid" alt="${product.name}">
            </div>

            <!-- Product Details Section -->
            <div class="col-md-6">
                <h2>${product.name}</h2>
                <p class="product-price">$<fmt:formatNumber value="${product.price}" type="number"/></p>

                <div class="mb-3">
                    <span class="badge-category">${product.category.name}</span>
                    <span class="badge-type">${product.productType.name}</span>
                </div>

                <p><strong>Quantity Available:</strong> ${product.quantity}</p>
                <p><strong>Description:</strong> ${product.description}</p>

                <a href="product-management" class="btn btn-secondary btn-back">← Back to List</a>
            </div>
        </div>
    </div>
  <jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>
</body>
</html>
