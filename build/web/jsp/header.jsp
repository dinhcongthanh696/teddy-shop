<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Header Demo</title>
        <link rel="stylesheet" href="${contextPath}/css/header.css" />
        <link rel="stylesheet" href="${contextPath}/css/header-bootstrap.css">
        <link rel='stylesheet' href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>

        <!-- Phần Header -->
        <header class="header-container">
            <div class="header-top">
                <div class="header-logo">
                    <!-- Thay ảnh logo bằng link/logo thực tế của bạn -->
                    <img src="https://img.pikbest.com/origin/09/22/46/12TpIkbEsTG97.png!sw800" alt="Bemori Logo">
                    <c:choose>
                        <c:when test="${user.getRole().getUserRole() == 'Admin'}">
                            <a href="${contextPath}/admin/dashboard" style="text-decoration: none">
                                <span class="brand-name">TESHO</span>
                            </a>
                        </c:when>
                        <c:when test="${user.role.userRole == 'Manager'}">
                            <a href="${contextPath}/manager/dashboard" style="text-decoration: none">
                                <span class="brand-name">TESHO</span>
                            </a>
                        </c:when>
                        <c:when test="${user.role.userRole == 'Seller'}">
                            <a href="${contextPath}/jsp/systemManage.jsp" style="text-decoration: none">
                                <span class="brand-name">TESHO</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${contextPath}/MenuController?service=productInformation" style="text-decoration: none">
                                <span class="brand-name">TESHO</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="header-search">
                    <form class="header-search" action="MenuController" method="post">
                        <input type="hidden" name="service" value="searchProduct"/>
                        <input name="searchValue" type="text" placeholder="Nhập sản phẩm cần tìm"/>
                        <button type="submit">Tìm kiếm</button>
                    </form>
                </div>

                <div class="header-hotline">
                    <div class="dropdown">
                        <button onclick="toggleDropdown()" class="dropbtn">Menu</button>
                        <div id="myDropdown" class="dropdown-content">
                            <c:if test="${user != null}">
                                <a href="${contextPath}/jsp/userProfile.jsp">User Info</a>
                            </c:if>
                            <c:if test="${user.role.userRole == 'Customer'}">
                                <a href="order-list">Orders</a>
                                <a href="${contextPath}/cart-list"> Cart <c:if test="${not empty cartCount}"> <span class="badge badge-danger">${cartCount}</span> </c:if> </a>
                                <a href="${contextPath}/manager/order-list">Orders Management</a>

                            </c:if>
                            <c:if test="${user.role.userRole == 'Seller'}">
                                 <a href="${contextPath}/seller/dashboard">Dashboard</a>
                                <a href="${contextPath}/seller/order-list">Orders Management</a>
                            </c:if>
                            <c:if test="${user.role.userRole == 'Manager'}">
                                <a href="${contextPath}/manager/dashboard">Dashboard</a>
                                <a href="${contextPath}/manager/product-management">Product management</a>
                                <a href="${contextPath}/manager/order-list">Orders Management</a>

                            </c:if>
                            <c:if test="${user.role.userRole == 'Seller' ||
                                          user.role.userRole == 'Marketing' ||
                                          user.role.userRole == 'Manager' ||
                                          user.role.userRole == 'Admin'}">
                                  <a href="${contextPath}/jsp/systemManage.jsp">System Manage</a>
                            </c:if>
                            <c:if test="${user == null}">
                                <a href="#">Cart</a>
                                <a href="#">Track Orders</a>
                                <a href="${contextPath}/login">Login</a>
                                <a href="${contextPath}/register">Register</a>
                            </c:if>
                            <c:if test="${user != null}">
                                <a href="${contextPath}/change-password">Change password</a>
                                <a href="${contextPath}/logout">Log out</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <nav class="header-nav">
                <ul>
                    <li><a href="${contextPath}/MenuController?service=productInformation">Trang chủ</a></li>
                    <li><a href="${contextPath}/MenuController?service=allProduct&name=1">Gấu bông</a></li>
                    <li><a href="${contextPath}/MenuController?service=allProduct&name=2">Móc khóa</a></li>
                    <li><a href="${contextPath}/MenuController?service=allProduct&name=3">Gối Ôm</a></li>
                    <li><a href="">Góc của Gấu</a></li>
                    <li><a href="${contextPath}/MenuController?service=allProduct">Tất cả SP</a></li>
                </ul>
            </nav>
        </header>
        <script src="${contextPath}/js/header.js"></script>
    </body>
</html>

