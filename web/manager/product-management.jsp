<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            body {
                background-color: #f9ece6 !important;
                font-family: "Inter", sans-serif;
            }
            .container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                background-color: #f3e5f5;
                margin-bottom: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .table img {
                border-radius: 5px;
            }
            .filter-section {
                background: #e9ecef;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body style="margin-top: 80px">
        <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
            <div class="container mt-4" >
                <h2 class="text-center">Products Management</h2>

                <!-- Filter & Search Form -->
                <form method="GET" action="product-management" class="row mb-4 filter-section">
                    <div class="col-md-4">
                        <input type="text" name="search" value="${param.search}" class="form-control" placeholder="Search Product">
                </div>
                <div class="col-md-2">
                    <select name="categoryId" class="form-control">
                        <option value="">All Categories</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select name="typeId" class="form-control">
                        <option value="">All Types</option>
                        <c:forEach var="type" items="${productTypes}">
                            <option value="${type.id}" ${param.typeId == type.id ? 'selected' : ''}>${type.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select name="priceRange" class="form-control">
                        <option value="">Select Price Range</option>
                        <option value="0-10000" ${param.priceRange == '0-10000' ? 'selected' : ''}>0 - 10.000đ</option>
                        <option value="10000-50000" ${param.priceRange == '10000-50000' ? 'selected' : ''}>10.000đ - 50.000đ</option>
                        <option value="50000-100000" ${param.priceRange == '50000-100000' ? 'selected' : ''}>50.000đ - 100.000đ</option>
                        <option value="100000-500000" ${param.priceRange == '100000-500000' ? 'selected' : ''}>100.000đ - 500.000đ</option>
                        <option value="500000-1000000" ${param.priceRange == '500000-1000000' ? 'selected' : ''}>500.000đ - 1.000.000đ</option>
                        <option value="1000000+" ${param.priceRange == '1000000+' ? 'selected' : ''}>Trên 1.000.000đ</option>
                    </select>
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary">Filter</button>
                </div>
                <div class="col-md-1">
                    <button type="reset" onclick="window.location.href = 'product-management'" class="btn btn-secondary">Clear</button>
                </div>
            </form>

            <!-- Add Product Button -->
            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">Add Product</button>
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
            <!-- Product List Table -->
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>No</th>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Price (First Size)</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${product.name}</td>
                            <td>
                                <c:if test="${not empty product.images}">
                                    <img src="../${product.images[0].source}" width="50" height="50" alt="${product.name}">
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${not empty product.sizes}">
                                    <fmt:formatNumber 
                                        value="${product.sizes[0].price}" 
                                        type="currency" 
                                        currencyCode="VND" 
                                        maxFractionDigits="0" />
                                </c:if>
                            </td>
                            <td>${product.category.name}</td>
                            <td>${product.productType.name}</td>
                            <td>
                                <a href="view-product?id=${product.id}" class="btn btn-info btn-sm">👁</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <nav>
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="product-management?page=${currentPage - 1}&search=${param.search}&categoryId=${param.categoryId}&typeId=${param.typeId}&priceRange=${param.priceRange}"><</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="product-management?page=${i}&search=${param.search}&categoryId=${param.categoryId}&typeId=${param.typeId}&priceRange=${param.priceRange}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="product-management?page=${currentPage + 1}&search=${param.search}&categoryId=${param.categoryId}&typeId=${param.typeId}&priceRange=${param.priceRange}">></a>
                        </li>
                    </c:if>
                </ul>
            </nav>

            <!-- Add Product Modal -->
            <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true" style="max-height: 650px; overflow-y: auto; margin-top: 80px">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Notice the enctype attribute for file uploads -->
                            <form id="addProductForm" method="POST" action="product-management" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label class="form-label">Product Name</label>
                                    <input type="text" name="name" id="productName" class="form-control" required>
                                    <small class="text-danger" id="nameError"></small>
                                </div>
                                <!-- Multi-file upload for images -->
                                <div class="mb-3">
                                    <label class="form-label">Product Images</label>
                                    <input type="file" name="images" class="form-control" multiple>
                                </div>
                                <!-- Dynamic Sizes Section -->
                                <div class="mb-3">
                                    <label class="form-label">Sizes</label>
                                    <div id="sizesContainer">
                                        <div class="row mb-2 sizeRow">
                                            <div class="col">
                                                <input type="text" name="sizeName" class="form-control" placeholder="Size" required>
                                            </div>
                                            <div class="col">
                                                <input type="number" name="sizeQuantity" class="form-control" placeholder="Quantity" min="1" required>
                                            </div>
                                            <div class="col">
                                                <input type="number" name="sizePrice" class="form-control" placeholder="Price" min="0" required>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-secondary btn-sm" onclick="addSizeRow()">Add Size</button>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Category</label>
                                    <select name="categoryId" class="form-control">
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Product Type</label>
                                    <select name="typeId" class="form-control">
                                        <c:forEach var="type" items="${productTypes}">
                                            <option value="${type.id}">${type.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button style="float: right" type="submit" class="btn btn-primary">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // Simple client-side validation example (adjust as needed)
                document.getElementById("addProductForm").addEventListener("submit", function (event) {
                    let isValid = true;
                    const name = document.getElementById("productName").value;
                    const namePattern = /^[\p{L}0-9 ]+$/u;
                    if (!name || !namePattern.test(name)) {
                        document.getElementById("nameError").textContent = "Invalid name: No special characters allowed";
                        isValid = false;
                    } else {
                        document.getElementById("nameError").textContent = "";
                    }
                    if (!isValid) {
                        event.preventDefault();
                    }
                });

                // Function to add a new size row
                function addSizeRow() {
                    const container = document.getElementById("sizesContainer");
                    const div = document.createElement("div");
                    div.className = "row mb-2 sizeRow";
                    div.innerHTML = `
                        <div class="col">
                            <input type="text" name="sizeName" class="form-control" placeholder="Size" required>
                        </div>
                        <div class="col">
                            <input type="number" name="sizeQuantity" class="form-control" placeholder="Quantity" min="1" required>
                        </div>
                        <div class="col">
                            <input type="number" name="sizePrice" class="form-control" placeholder="Price" min="0" required>
                        </div>
                    `;
                    container.appendChild(div);
                }
            </script>
        </div>
        <jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>
    </body>
</html>
