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

        <section class="shop_section layout_padding " style="padding-top: 50px;">
            <div class="container">
                <!-- Add Filter Section -->
                <div class="heading_container heading_center">
                    <h2>
                        <c:out value="${categoryName}"></c:out>
                        </h2>
                    </div>
                <c:if test="${ categoryName == 'Tất cả sản phẩm' || categoryName == 'Kết quả tìm kiếm'}">
                    <div class="mb-4 ">
                        <div class="card">
                            <div class="card-body">
                                <form action="${contextPath}/MenuController" method="GET" id="filterForm" class="row g-3">
                                    <input type="hidden" name="service" value="allProduct">
                                    <input type="hidden" name="filterActive" value="true">

                                    <!-- Category Filter -->
                                    <div class="col-md-3 ">
                                        <label class="form-label">Danh mục</label>
                                        <select class="form-select form-control" name="categoryId" id="categoryId">
                                            <option value="">Tất cả danh mục</option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Size Filter -->
                                    <div class="col-md-2">
                                        <label class="form-label">Kích cỡ</label>
                                        <select class="form-select form-control" name="sizeId"  id="sizeId">
                                            <option value="">Tất cả kích cỡ</option>
                                            <c:forEach items="${sizes}" var="size">
                                                <option value="${size.name}" ${param.sizeId == size.name ? 'selected' : ''}>
                                                    ${size.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Price Range Filter -->
                                    <div class="col-md-4">
                                        <label class="form-label">Khoảng giá</label>
                                        <div class="d-flex gap-2">
                                            <input type="number" class="form-control" name="minPrice" id="minPrice"
                                                   placeholder="Giá thấp nhất" value="${param.minPrice}"
                                                   min="0" step="10000">
                                            <input type="number" class="form-control" name="maxPrice" id="maxPrice"
                                                   placeholder="Giá cao nhất" value="${param.maxPrice}"
                                                   min="0" step="10000">
                                        </div>
                                    </div>

                                    <!-- Filter Buttons -->
                                    <div class="col-md-3 d-flex align-items-end">
                                        <div class="d-flex gap-2 w-100">
                                            <button type="submit" class="btn btn-primary flex-grow-1">
                                                <i class="bi bi-funnel"></i> Tìm kiếm
                                            </button>
                                            <button onclick="clearFilter();" type="button" class="btn  bg-danger text-light flex-grow-1">
                                                <i class="bi bi-funnel"></i> Xóa bộ lọc
                                            </button>
                                        </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>


                <div >
                 
                        <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-sm-6 col-md-4 col-lg-3">
                                <div class="box">
                                    <a href="${contextPath}/product-details?id=${product.id}">
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

                        <c:if test="${empty productList}">
                            <div class="col-12 text-center " style="margin-top: 20px;">
                                <div class="alert alert-info" role="alert">
                                    <h4 class="alert-heading">Không tìm thấy sản phẩm!</h4>
                                    <p>Không có sản phẩm nào phù hợp với tiêu chí tìm kiếm của bạn.</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="btn-box">
                    <a href="${contextPath}/MenuController?service=productInformation">
                        Trang chủ
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

        <script>

            function clearFilter() {
                document.getElementById("categoryId").value = "";
                document.getElementById("sizeId").value = "";
                document.getElementById("minPrice").value = "";
                document.getElementById("maxPrice").value = "";

                document.getElementById("filterForm").submit();
            }

        </script>
    </body>
</html>
