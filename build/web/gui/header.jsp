<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Header Demo</title>
    <link rel="stylesheet" href="${contextPath}/css/header.css" />
    <link rel="stylesheet" href="${contextPath}/css/header-bootstrap.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
  </head>
  <style>
    header {
        background-color: ${content.headerBackgroundColor} !important;
        color: ${content.headerTextColor} !important;
    }
    header a, header .brand-name, header .dropbtn {
        color: ${content.headerTextColor} !important;
    }
</style>
  <body>
    <!-- Phần Header -->
    <header class="header-container">
      <div class="header-top">
        <div class="header-logo">
          <!-- Thay ảnh logo bằng link/logo thực tế của bạn -->
          <img
            src="https://img.pikbest.com/origin/09/22/46/12TpIkbEsTG97.png!sw800"
            alt="Bemori Logo"
          />
          <c:choose>
            <c:when test="${user.getRole().getUserRole() == 'Admin'}">
              <a
                href="${contextPath}/admin/dashboard"
                style="text-decoration: none"
              >
                <span class="brand-name">TESHO</span>
              </a>
            </c:when>
            <c:when test="${user.role.userRole == 'Manager'}">
              <a
                href="${contextPath}/manager/dashboard"
                style="text-decoration: none"
              >
                <span class="brand-name">TESHO</span>
              </a>
            </c:when>
            <c:when test="${user.role.userRole == 'Seller'}">
              <a
                href="${contextPath}/jsp/systemManage.jsp"
                style="text-decoration: none"
              >
                <span class="brand-name">TESHO</span>
              </a>
            </c:when>
            <c:otherwise>
              <a
                href="${contextPath}/MenuController?service=productInformation"
                style="text-decoration: none"
              >
                <span class="brand-name">TESHO</span>
              </a>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="header-hotline">
          <div class="dropdown">
            <button onclick="toggleDropdown()" class="dropbtn">Menu</button>
            <div id="myDropdown" class="dropdown-content">
              <c:choose>
                <c:when test="${user.role.userRole == 'Admin'}">
                  <a href="${contextPath}/admin/dashboard">Dashboard</a>
                </c:when>
                <c:when test="${user.role.userRole == 'Manager'}">
                  <a href="${contextPath}/manager/dashboard">Dashboard</a>
                  <a href="${contextPath}/manager/product-management">Product management</a>
                  <a href="${contextPath}/manager/category-management">Category Management</a>
                  <a href="${contextPath}/manager/order-list">Orders Management</a>
                  <a href="${contextPath}/manager/content-management">Content Management</a>
                </c:when>
                <c:when test="${user.role.userRole == 'Seller'}">
                  <a href="${contextPath}/seller/dashboard">Dashboard</a>
                  <a href="${contextPath}/seller/order-list"
                    >Orders Management</a
                  >
                </c:when>
                <c:when test="${user.role.userRole == 'Customer'}">
                  <a href="order-list">Orders</a>
                  <a href="${contextPath}/cart-list">
                    Cart
                    <c:if test="${not empty cartCount}">
                      <span class="badge badge-danger">${cartCount}</span>
                    </c:if>
                  </a>
                </c:when>
                <c:otherwise> </c:otherwise>
              </c:choose>
              <c:if test="${user == null}">
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
    </header>
    <script src="${contextPath}/js/header.js"></script>
  </body>
</html>
