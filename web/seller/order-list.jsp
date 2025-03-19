<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manager Order List</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Optional select2 CSS for searchable dropdown -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" />
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
        <jsp:include page="../gui/header.jsp" />
        <div class="container" style="margin-top: 100px">
            <h1>All Orders</h1>

            <!-- Search Form -->
            <form action="${contextPath}/manager/order-list" method="get" class="form-inline mb-3">
                <input style="width: 90%"type="text" name="search" class="form-control mr-2" placeholder="Search by username or product name" value="${search}">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <table class="table table-bordered order-table">
                <thead class="thead-light">
                    <tr>
                        <th>No</th>
                        <th>User</th>
                        <th>Order Date</th>
                        <th>Total Cost</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orderList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${order.user.userName}</td>
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
                                        <!-- Pending: Cancel or Accept -->
                                        <form action="${contextPath}/manager/order-list" method="post" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.id}" />
                                            <button type="submit" name="action" value="cancel" class="btn btn-sm btn-danger" onclick="return confirm('Cancel this order?');">Cancel</button>
                                        </form>
                                        <form action="${contextPath}/manager/order-list" method="post" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.id}" />
                                            <button type="submit" name="action" value="accept" class="btn btn-sm btn-success" onclick="return confirm('Accept this order?');">Accept</button>
                                        </form>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <!-- Shipping: Mark as Delivered -->
                                        <form action="${contextPath}/manager/order-list" method="post" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.id}" />
                                            <button type="submit" name="action" value="delivered" class="btn btn-sm btn-primary" onclick="return confirm('Mark this order as Delivered?');">Delivered</button>
                                        </form>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                     
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                                <a  href="${contextPath}/order-detail?orderId=${order.id}" class="btn btn-sm btn-secondary"><i class="fa fa-eye"></i></a>

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

            <!-- Paging Navigation -->
            <nav aria-label="Page navigation" style="margin-bottom: 20px">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${contextPath}/manager/order-list?search=${search}&page=${currentPage - 1}">Previous</a>
                        </li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${contextPath}/manager/order-list?search=${search}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${contextPath}/manager/order-list?search=${search}&page=${currentPage + 1}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <jsp:include page="../gui/footer.jsp" />
        <!-- jQuery, Bootstrap JS, and select2 for searchable dropdown -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script>
                                                $(document).ready(function () {
                                                    $('#newUserId').select2({
                                                        placeholder: "Select a user",
                                                        width: '100%'
                                                    });
                                                });
        </script>
    </body>
</html>
