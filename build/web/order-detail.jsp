<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .user-info, .order-header {
                margin-bottom: 30px;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .user-info h3, .order-header h3, .order-details h3 {
                margin-bottom: 15px;
            }
            .order-details-table th, .order-details-table td {
                vertical-align: middle;
            }
            .order-details-table img {
                max-width: 100px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="gui/header.jsp" />
        <div class="container" style="margin-top: 100px">
            <h1 class="mb-4">Order Details</h1>

            <!-- User Information Section -->
            <div class="user-info">
                <h3>User Information</h3>
                <p><strong>Name:</strong> ${order.user.userName}</p>
                <p><strong>Email:</strong> ${order.user.email}</p>
                <p><strong>Phone:</strong> ${order.user.phoneNumber}</p>
                <p><strong>Location:</strong> ${order.user.location}</p>
            </div>

            <!-- Order Header Section -->
            <div class="order-header">
                <h3>Order Summary</h3>
                <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></p>
                <p><strong>Status:</strong>
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <span class="badge badge-warning">Pending</span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                            <span class="badge badge-info">Shipping</span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                            <span class="badge badge-danger">Cancelled</span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                            <a href="#" class="btn btn-sm btn-success">Delivered</a>
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>
                </p>
                <p><strong>Total Cost:</strong> <fmt:formatNumber value="${order.totalCost}" pattern="#,##0" />₫</p>
            </div>

            <!-- Order Details (Products) Section -->
            <div class="order-details">
                <h3>Products in this Order</h3>
                <table class="table table-bordered order-details-table">
                    <thead class="thead-light">
                        <tr>
                            <th>Product Image</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="orderTotal" value="0" />
                        <c:forEach var="detail" items="${order.details}">
                            <!-- For unit price, we assume it's available from the first Size record -->
                            <c:set var="unitPrice" value="${detail.product.sizes[0].price}" />
                            <c:set var="subtotal" value="${unitPrice * detail.quantity}" />
                            <c:set var="orderTotal" value="${orderTotal + subtotal}" scope="page" />
                            <tr>
                                <td>
                                    <c:if test="${not empty detail.product.images}">
                                        <img src="${contextPath}/${detail.product.images[0].source}" alt="${detail.product.name}">
                                    </c:if>
                                </td>
                                <td>${detail.product.name}</td>
                                <td>${detail.quantity}</td>
                                <td><fmt:formatNumber value="${subtotal}" pattern="#,##0" />₫</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Total:</strong></td>
                            <td><strong><fmt:formatNumber value="${orderTotal}" pattern="#,##0" />₫</strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="mt-4">
                <c:choose>
                    <c:when test="${user.role.userRole == 'Manager'}">
                        <a href="${contextPath}/manager/order-list" class="btn btn-primary" style="margin-bottom: 20px">Back to Orders</a>
                    </c:when>
                    <c:when test="${user.role.userRole == 'Seller'}">
                        <a href="${contextPath}/seller/order-list" class="btn btn-primary" style="margin-bottom: 20px">Back to Orders</a>
                    </c:when>
                    <c:when test="${user.role.userRole == 'Customer'}">
                        <a href="${contextPath}/order-list" class="btn btn-primary" style="margin-bottom: 20px">Back to Orders</a>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <jsp:include page="gui/footer.jsp" />
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
