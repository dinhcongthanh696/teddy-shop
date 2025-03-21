<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.name}</title>
        <link rel="stylesheet" href="${contextPath}/css/productView.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
        <!-- Link file CSS riêng -->
        <link rel="stylesheet" href="../css/cart.css">
        
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div style="margin-top: 150px;">
            <h1 class="product-title " style=" width: 100%; text-align: center;">Thông tin sản phẩm</h1>
            <div class="product-container">
                <div class="product-image">
                    <img src="${contextPath}/${product.images[0].source}" alt="${product.name}" id="mainImage">
                </div>

                <div class="product-details">
                    <h2 class="product-title">${product.name}</h2>

                    <table class="size-status-table">
                        <thead>
                            <tr>
                                <th>Kích cỡ</th>
                                <th>Giá</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${product.sizes}" var="size">
                                <tr>
                                    <td>${size.name}</td>
                                    <td>${size.price}₫</td>
                                    <td>${size.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="product-price">${product.sizes[0].price}₫</div>

                    <div class="product-actions">
                        <button id="buyButton" class="btn btn-primary">Thêm vào giỏ hàng</button>
                        <button id="buyButton2" class="btn btn-secondary">Mua ngay</button>
                    </div>

                    <p class="note">
                        HÀ NỘI: 8:30 - 23:00 <br>
                        275 Bạch Mai, Hai Bà Trưng, Hà Nội - 0979896616
                    </p>
                </div>

                <!-- Add to Cart Popup -->
                <div id="sizePopup" class="popup">
                    <div class="popup-content">
                        <span class="close" id="closePopup">&times;</span>
                        <h2>Chọn kích cỡ</h2>
                        <form action="${contextPath}/add-to-cart" method="POST">
                            <input type="hidden" name="productId" value="${product.id}">
                            <select class="form-select form-control" id="productSize" name="sizeId" required>
                                <c:forEach items="${product.sizes}" var="size">
                                    <option value="${size.id}" data-price="${size.price}">
                                        ${size.name} - ${size.price}₫
                                    </option>
                                </c:forEach>
                            </select>
                            <br/>
                            <button type="submit" class="btn btn-primary w-100">Thêm vào giỏ hàng</button>
                        </form>
                    </div>
                </div>

                <!-- Buy Now Popup -->
                <div id="sizePopup2" class="popup">
                    <div class="popup-content">
                        <span class="close" id="closePopup2">&times;</span>
                        <h2>Select Size</h2>
                        <form action="${contextPath}/buy-now" method="POST">
                            <input type="hidden" name="productId" value="${product.id}">
                            <select id="productSize2" name="sizeId" required>
                                <c:forEach items="${product.sizes}" var="size">
                                    <option value="${size.id}" data-price="${size.price}">
                                        ${size.name} - ${size.price}₫
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn btn-primary">Mua ngay</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Product Images Gallery -->
            <div class="small-images">
                <ul>
                    <c:forEach items="${product.images}" var="image">
                        <li>
                            <img src="${contextPath}/${image.source}" 
                                 alt="${product.name}" 
                                 onclick="updateMainImage('${contextPath}/${image.source}')">
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <footer style="margin-top: 151px;">
            <jsp:include page="footer.jsp" />
        </footer>

        <script>
            // Image Gallery
            function updateMainImage(src) {
                document.getElementById('mainImage').src = src;
            }

            // Popup Handling
            const buyButton = document.getElementById("buyButton");
            const buyButton2 = document.getElementById("buyButton2");
            const sizePopup = document.getElementById("sizePopup");
            const sizePopup2 = document.getElementById("sizePopup2");
            const closePopup = document.getElementById("closePopup");
            const closePopup2 = document.getElementById("closePopup2");

            buyButton.onclick = () => sizePopup.style.display = "block";
            buyButton2.onclick = () => sizePopup2.style.display = "block";
            closePopup.onclick = () => sizePopup.style.display = "none";
            closePopup2.onclick = () => sizePopup2.style.display = "none";

            window.onclick = (event) => {
                if (event.target === sizePopup) {
                    sizePopup.style.display = "none";
                }
                if (event.target === sizePopup2) {
                    sizePopup2.style.display = "none";
                }
            };

            // Update price when size changes
            document.getElementById('productSize').onchange = function() {
                const selectedOption = this.options[this.selectedIndex];
                const price = selectedOption.getAttribute('data-price');
                document.querySelector('.product-price').textContent = price + '₫';
            };

            document.getElementById('productSize2').onchange = function() {
                const selectedOption = this.options[this.selectedIndex];
                const price = selectedOption.getAttribute('data-price');
                document.querySelector('.product-price').textContent = price + '₫';
            };
        </script>
    </body>
</html>
