<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Your Orders</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .order-table th, .order-table td {
                vertical-align: middle;
            }
            .pagination {
                margin: 0;
            }
        </style>
    </head>
    <body>
        <jsp:include page="gui/header.jsp" />
        <div class="container" style="margin-top: 30px">
            <h1 class="checkout-title text-center">Checkout</h1>
            <h1>Your Orders</h1>

            <!-- Search Form -->
            <form action="${contextPath}/order-list" method="get" class="form-inline mb-3">
                <input type="text" name="search" class="form-control mr-2" placeholder="Search by product name" value="${search}">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <c:choose>
                <c:when test="${empty orderList}">
                    <div class="alert alert-info">You have no orders.</div>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered order-table">
                        <thead class="thead-light">
                            <tr>
                                <th>No</th>
                                <th>Order Date</th>
                                <th>Total Cost</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td><fmt:formatNumber value="${order.totalCost}" pattern="#,##0" />₫</td>
                                    <td>
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
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 0}">
                                                <!-- Cancel button: posts cancelOrderId to OrderListServlet via doPost -->
                                                <form action="${contextPath}/order-list" method="post" style="display:inline;">
                                                    <input type="hidden" name="cancelOrderId" value="${order.id}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Cancel this order?');">Cancel</button>
                                                </form>
                                            </c:when>
                                            <c:when test="${order.status == 1}">
                                                
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                               
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <a href="#" class="btn btn-sm btn-primary">Comment</a>
                                            </c:when>
                                            <c:otherwise>
                                                -
                                            </c:otherwise>
                                        </c:choose>
                                                <a  href="order-detail?orderId=${order.id}" class="btn btn-sm btn-secondary"><i class="fa fa-eye"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <table class="table table-sm nested-table">
                                            <thead>
                                                <tr>
                                                    <th>Product Image</th>
                                                    <th>Product Name</th>
                                                    <th>Quantity</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detail" items="${order.details}">
                                                    <tr>
                                                        <td>
                                                            <c:if test="${not empty detail.product.images}">
                                                                <img src="${contextPath}/${detail.product.images[0].source}" alt="${detail.product.name}" style="max-width:80px;">
                                                            </c:if>
                                                        </td>
                                                        <td>${detail.product.name}</td>
                                                        <td>${detail.quantity}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${contextPath}/order-list?search=${search}&page=${currentPage - 1}">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${contextPath}/order-list?search=${search}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${contextPath}/order-list?search=${search}&page=${currentPage + 1}">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>

                </c:otherwise>
            </c:choose>
            <div class="mt-3">
                <a href="${contextPath}/MenuController?service=productInformation" class="btn btn-primary">Continue Shopping</a>
            </div>
        </div>
        <jsp:include page="gui/footer.jsp" />
        <!-- Bootstrap and jQuery JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
