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
                <div class="heading_container heading_center">
                    <h2>
                        <c:out value="${categoryName}"></c:out>
                        </h2>
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
                <div class="btn-box">
                    <a href="${contextPath}/MenuController?service=productInformation">
                        Homepage
                    </a>
                </div>
            </div>
        </section>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
