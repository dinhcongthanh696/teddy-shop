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
        
          .table {
            background-color: white;
        }
        .table th {
            background-color: #f8f9fa;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .product-images {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .product-image {
            width: 100%;
            height: auto;
            object-fit: cover;
            max-height: 350px;
        }
    </style>
</head>
<body style="margin-top: 80px">
    <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
    <div class="container" style="background-color: #f3e5f5 !important">
        <h2 class="text-center " style="margin-bottom: 20px;">Product Details</h2>
        <div class="row align-items-center">
            <!-- Product Image Section -->
            <div class="col-md-6">
                <div class="product-images">
                    <c:if test="${not empty product.images}">
                        <img src="../${product.images[0].source}" alt="${product.name}" class="product-image">
                    </c:if>
                    <c:if test="${empty product.images}">
                        <img src="../images/placeholder.png" alt="No image available" class="product-image">
                    </c:if>
                </div>
            </div>

            <!-- Product Details Section -->
            <div class="col-md-6">
                <h2>${product.name}</h2>
                
                <div class="mb-3">
                    <span class="badge-category">${product.category.name}</span>
                    <span class="badge-type">${product.productType.name}</span>
                </div>

                <!-- Size and Price Information -->
                <div class="sizes-container mb-4">
                    <h4>Available Sizes:</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Size</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${product.sizes}" var="size">
                                    <tr class="${size.quantity < 5 ? 'table-warning' : ''}">
                                        <td>${size.name}</td>
                                        <td>$<fmt:formatNumber value="${size.price}" type="number"/></td>
                                        <td>${size.quantity}</td>
                                        <td>
                                            <c:if test="${size.quantity < 5}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="bi bi-exclamation-triangle-fill"></i>
                                                    Low Stock
                                                </span>
                                            </c:if>

                                              <c:if test="${size.quantity >= 5}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-exclamation-triangle-fill"></i>
                                                    Available
                                                </span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class=" mt-4">
                    <a href="product-management" class="btn btn-secondary me-2">← Back to List</a>
                    <a href="edit-product?id=${product.id}" class="btn btn-primary me-2">✏️ Edit Product</a>
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                        🗑 Delete Product
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete "${product.name}"?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="delete-product" method="POST" style="display: inline;">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>
</body>
</html>
