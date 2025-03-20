<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
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
                margin-top: 20px;
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .image-input, .size-input {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
                align-items: center;
            }
            .btn {
                margin: 2px;
            }
        </style>
    </head>
    <body style="margin-top: 80px">
        <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
    <div class="container">
        <h2>Edit Product</h2>
        <form action="${pageContext.request.contextPath}/manager/edit-product" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.id}">
            
            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
            </div>

            <hr class="my-4">

            <div class="form-group">
                <label for="categoryId">Category:</label>
                <select class="form-control" id="categoryId" name="categoryId" required>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}" ${product.category.id == category.id ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="typeId">Product Type:</label>
                <select class="form-control" id="typeId" name="typeId" required>
                    <c:forEach items="${productTypes}" var="type">
                        <option value="${type.id}" ${product.productType.id == type.id ? 'selected' : ''}>
                            ${type.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <hr class="my-4">

            <div class="form-group">
                <label>Product Image:</label>
                <div class="image-input mb-3">
                    <div class="d-flex flex-column  gap-2">
                        <div class="preview-container mb-2" style="width: 200px; height: 200px; overflow: hidden;">
                            <img src="${not empty product.images[0] ? '../'.concat(product.images[0].source) : '../images/placeholder.png'}" 
                                 alt="Product Image" class="preview-image" 
                                 style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <input type="file" class="form-control" name="image" accept="image/*" onchange="previewImage(this)">
                        <input type="hidden" name="existingImage" value="${not empty product.images[0] ? product.images[0].source : ''}">
                    </div>
                </div>
            </div>

            <hr class="my-4">

            <div class="form-group">
                <label>Sizes:</label>
                <div id="sizeContainer">
                    <c:forEach items="${product.sizes}" var="size">
                        <div class="size-input">
                            <input type="text" class="form-control" name="sizeName" value="${size.name}" placeholder="Size">
                            <input type="number" class="form-control" name="quantity" value="${size.quantity}" placeholder="Quantity">
                            <input type="text" class="form-control" name="price" value="${size.price}" placeholder="Price">
                            <button type="button" class="btn btn-danger" onclick="removeSize(this)">Remove</button>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" class="btn btn-secondary" onclick="addSizeField()">Add Size</button>
            </div>

            <hr class="my-4">

            <div class="d-flex justify-content-end gap-2">
                <a href="${pageContext.request.contextPath}/manager/product-management" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Update Product</button>
            </div>
        </form>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                const previewContainer = input.parentElement.querySelector('.preview-container');
                const previewImage = previewContainer.querySelector('.preview-image');
                
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }

        function addImageField() {
            const container = document.getElementById('imageContainer');
            const div = document.createElement('div');
            div.className = 'image-input';
            div.innerHTML = `
                <div class="d-flex align-items-center gap-2 mb-2">
                    <div class="preview-container" style="width: 100px; height: 100px; overflow: hidden;">
                        <img src="../images/placeholder.png" alt="Preview" class="preview-image" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <input type="file" class="form-control" name="images" accept="image/*" onchange="previewImage(this)">
                    <button type="button" class="btn btn-danger" onclick="removeImage(this)">Remove</button>
                </div>
            `;
            container.appendChild(div);
        }

        function removeImage(button) {
            button.closest('.image-input').remove();
        }

        function addSizeField() {
            const container = document.getElementById('sizeContainer');
            const div = document.createElement('div');
            div.className = 'size-input';
            div.innerHTML = `
                <input type="text" class="form-control" name="sizeName" placeholder="Size">
                <input type="number" class="form-control" name="quantity" placeholder="Quantity">
                <input type="text" class="form-control" name="price" placeholder="Price">
                <button type="button" class="btn btn-danger" onclick="removeSize(this)">Remove</button>
            `;
            container.appendChild(div);
        }

        function removeSize(button) {
            button.parentElement.remove();
        }
    </script>

    <style>
        .preview-container {
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f8f9fa;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .preview-image {
            transition: transform 0.2s;
        }
        
        .preview-image:hover {
            transform: scale(1.1);
        }

        .image-input {
            background: rgba(255,255,255,0.5);
            padding: 15px;
            border-radius: 8px;
        }
    </style>
</body>
</html>