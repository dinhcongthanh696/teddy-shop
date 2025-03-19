<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>

    <head>
        <title>Home Page</title>
        <link rel="stylesheet" href="${contextPath}/css/menu.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
    </head>

    <body>
        <c:if test="${categoryList == null}">
            <c:redirect url="/MenuController?service=productInformation"/>
        </c:if>

        <jsp:include page="header.jsp"/>
        <c:forEach var="category" items="${categoryList}">
            <div>
                <h1 class="category-title">${category.name}</h1>
                <div class="container swiper">
                    <div class="card-wrapper">
                        <ul class="card-list swiper-wrapper">
                            <c:forEach var="product" items="${productList}">
                                <c:if test="${product.category.id == category.id}">
                                    <li class="card-item swiper-slide">
                                        <a href="#" class="card-link" name="productDetail">
                                            <img src="${contextPath}/${product.images[0].source}" alt="Card Image" class="card-image">
                                            <p class="badge">${product.name}</p>
                                            <h2 class="card-title">${product.sizes[0].price}₫</h2>
                                            <div class="card-buttons" style="display: flex; justify-content: space-between; margin-top: 5px;">
                                                <button class="fa-solid fa-arrow-right card-button"></button>
                                                <!-- Form for adding product to cart -->
                                                <form action="${contextPath}/add-to-cart" method="post" style="margin: 0;">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <button type="submit" class="card-button">
                                                        <i class="fa fa-cart-plus" aria-hidden="true"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                        <div class="swiper-pagination"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                    </div>
                </div>

                <div class="view-all-button-container">
                    <form action="MenuController" method="get">
                        <input type="hidden" name="service" value="allProduct"/>
                        <input type="hidden" name="name" value="${category.name}"/>
                        <button name="categoryId" type="submit" class="view-all-button" value="${category.id}">Xem Tất Cả ${category.name}</button>
                    </form>
                </div>
            </div>
        </c:forEach>

        <jsp:include page="footer.jsp"/>
        <!-- Linking SwiperJS script -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="${contextPath}/js/menu.js"></script>
    </body>

</html>