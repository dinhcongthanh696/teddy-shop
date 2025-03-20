<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProductBootstrap.css" />

        <!-- Custom styles for this template -->
        <link href="${contextPath}/css/allProduct.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="${contextPath}/css/allProductResponsive.css" rel="stylesheet" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <section class="shop_section layout_padding">
            <div class="container">
                <!-- Add Filter Section -->

                <div class="mb-4">
                    <div class="card">
                        <div class="card-body">
                            <form action="${contextPath}/MenuController" method="GET" id="filterForm" class="row g-3">
                                <input type="hidden" name="service" value="allProduct">
                                <input type="hidden" name="filterActive" value="true">

                                <!-- Category Filter -->
                                <div class="col-md-3 ">
                                    <label class="form-label">Category</label>
                                    <select class="form-select form-control" name="categoryId">
                                        <option value="">All Categories</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Size Filter -->
                                <div class="col-md-3">
                                    <label class="form-label">Size</label>
                                    <select class="form-select form-control" name="sizeId">
                                        <option value="">All Sizes</option>
                                        <c:forEach items="${sizes}" var="size">
                                            <option value="${size.name}" ${param.sizeId == size.name ? 'selected' : ''}>
                                                ${size.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Price Range Filter -->
                                <div class="col-md-4">
                                    <label class="form-label">Price Range</label>
                                    <div class="d-flex gap-2">
                                        <input type="number" class="form-control" name="minPrice" 
                                               placeholder="Min Price" value="${param.minPrice}"
                                               min="0" step="10000">
                                        <input type="number" class="form-control" name="maxPrice" 
                                               placeholder="Max Price" value="${param.maxPrice}"
                                               min="0" step="10000">
                                    </div>
                                </div>

                                <!-- Filter Buttons -->
                                <div class="col-md-2 d-flex align-items-end">
                                    <div class="d-flex gap-2 w-100">
                                        <button type="submit" class="btn btn-primary flex-grow-1">
                                            <i class="bi bi-funnel"></i> Filter
                                        </button>
                                       
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div >
                    <div class="heading_container heading_center">
                        <h2><c:out value="${categoryName}"></c:out></h2>
                        </div>
                        <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-sm-6 col-md-4 col-lg-3">
                                <div class="box">
                                    <a href="">
                                        <div class="img-box">
                                            <img src="${contextPath}/${product.images[0].source}" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <h6>
                                                ${product.name}
                                            </h6>
                                            <h6>
                                                <span>
                                                    ${product.sizes[0].price}₫
                                                </span>
                                            </h6> 
                                        </div>
                                        <br>
                                        <form action="${contextPath}/add-to-cart" method="post">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-cart-plus" aria-hidden="true"></i>
                                            </button>
                                        </form>
                                        <div class="new">
                                            <span>
                                                New
                                            </span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="btn-box">
                    <a href="${contextPath}/MenuController?service=productInformation">
                        Homepage
                    </a>
                </div>
            </div>
        </section>

        <jsp:include page="footer.jsp"/>

        <!-- Add some custom styles -->
        <style>
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .form-select, .form-control {
                border-radius: 6px;
            }
            .gap-2 {
                gap: 0.5rem;
            }
        </style>
    </body>
</html>
