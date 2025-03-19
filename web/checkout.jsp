<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${contextPath}/css/checkout.css">
    <style>
      .checkout-container {
        margin-top: 50px;
      }
      .checkout-title {
        margin-bottom: 30px;
      }
      .form-group label {
        font-weight: bold;
      }
      .product-table img {
        max-width: 100px;
        height: auto;
      }
    </style>
  </head>
  <body>
    <jsp:include page="gui/header.jsp"/>
    <div class="container checkout-container" style="margin-top: 30px">
      <h1 class="checkout-title text-center">Checkout</h1>
      <form action="${contextPath}/checkout" method="post">
        <div class="row">
          <!-- Left Column: User Information -->
          <div class="col-md-6">
            <h3>User Information</h3>
            <div class="form-group">
              <label for="name">Name</label>
              <input type="text" readonly class="form-control" id="name" name="name" value="${sessionScope.user.userName}">
            </div>
            <div class="form-group">
              <label for="email">Email</label>
              <input type="email" readonly class="form-control" id="email" name="email" value="${sessionScope.user.email}">
            </div>
            <div class="form-group">
              <label for="phone">Phone</label>
              <input type="text" readonly class="form-control" id="phone" name="phone" value="${sessionScope.user.phoneNumber}">
            </div>
            <div class="form-group">
              <label for="address">Address</label>
              <input type="text" required class="form-control" id="address" name="address" placeholder="Enter your address">
            </div>
          </div>
          <!-- Right Column: Product Details -->
          <div class="col-md-6">
            <h3>Product Details</h3>
            <table class="table table-bordered product-table">
              <thead>
                <tr>
                  <th>Image</th>
                  <th>Product Name</th>
                  <th>Unit Price</th>
                  <th>Quantity</th>
                  <th>Subtotal</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="totalCost" value="0" />
                <c:forEach var="item" items="${cartItems}">
                  <c:set var="subtotal" value="${item.unitPrice * item.quantity}" />
                  <c:set var="totalCost" value="${totalCost + subtotal}" scope="page" />
                  <tr>
                    <td>
                      <c:if test="${not empty item.product.images}">
                        <img src="${contextPath}/${item.product.images[0].source}" alt="${item.product.name}">
                      </c:if>
                    </td>
                    <td>${item.product.name}</td>
                    <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0" />₫</td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${subtotal}" pattern="#,##0" />₫</td>
                  </tr>
                </c:forEach>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="4" class="text-right"><strong>Total:</strong></td>
                  <td><strong><fmt:formatNumber value="${totalCost}" pattern="#,##0" />₫</strong></td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-success" style="margin-bottom: 20px">Checkout</button>
        </div>
      </form>
    </div>
    <jsp:include page="gui/footer.jsp"/>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
