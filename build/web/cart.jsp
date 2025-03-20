<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Your Cart</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Custom styles -->
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProductBootstrap.css">
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProduct.css">
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/allProductResponsive.css">
        <style>
            .cart-table img {
                max-width: 100px;
                height: auto;
            }
            .quantity-display {
                width: 50px;
                text-align: center;
                display: inline-block;
            }
            .update-form button {
                margin-left: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="gui/header.jsp" />
        <div class="container mt-5">
            <h1 class="mb-4">Your Shopping Cart</h1>
            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="alert alert-info" role="alert">
                        Your cart is empty!
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered cart-table">
                        <thead class="thead-light">
                            <tr>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>Unit Price</th>
                                <th style="width: 250px;">Quantity</th>
                                <th>Subtotal</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Initialize total price -->
                            <c:set var="totalPrice" value="0" />
                            <c:forEach var="cartItem" items="${cartItems}">
                                <c:set var="unitPrice" value="${cartItem.unitPrice}" />
                                <c:set var="qty" value="${cartItem.quantity}" />
                                <c:set var="subtotal" value="${unitPrice * qty}" />
                                <c:set var="totalPrice" value="${totalPrice + subtotal}" scope="page" />
                                <tr>
                                    <td>
                                        <c:forEach var="image" items="${cartItem.product.images}">
                                            <img src="${contextPath}/${image.source}" alt="${cartItem.product.name}" class="img-fluid">
                                        </c:forEach>
                                    </td>
                                    <td>${cartItem.product.name}</td>
                                    <td>
                                        <fmt:formatNumber value="${unitPrice}" pattern="#,##0" />₫
                                    </td>
                                    <td>
                                        <form action="${contextPath}/update-cart" method="post" style="display: inline;">
                                            <input type="hidden" name="productId" value="${cartItem.product.id}">
                                            <button type="submit" name="action" value="decrease" class="btn btn-sm btn-secondary">-</button>
                                        </form>
                                        <span class="quantity-display">${qty}</span>
                                        <form action="${contextPath}/update-cart" method="post" style="display: inline;">
                                            <input type="hidden" name="productId" value="${cartItem.product.id}">
                                            <button type="submit" name="action" value="increase" class="btn btn-sm btn-secondary">+</button>
                                        </form>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${subtotal}" pattern="#,##0" />₫
                                    </td>
                                    <td>
                                        <!-- Optional duplicate remove button -->
                                        <form action="${contextPath}/update-cart" method="post">
                                            <input type="hidden" name="productId" value="${cartItem.product.id}">
                                            <button type="submit" name="action" value="remove" class="btn btn-sm btn-danger">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="text-right"><strong>Total:</strong></td>
                                <td colspan="2"><strong><fmt:formatNumber value="${totalPrice}" pattern="#,##0" />₫</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                    <div class="text-right mb-3">
                        <a href="${contextPath}/checkout" class="btn btn-success">Proceed to Checkout</a>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="mt-3" style="margin-bottom: 20px">
                <a href="${contextPath}/MenuController?service=productInformation" class="btn btn-primary">Continue Shopping</a>
            </div>
        </div>
        <jsp:include page="gui/footer.jsp" />
        <!-- Bootstrap and jQuery JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
