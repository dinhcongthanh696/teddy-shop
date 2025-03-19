<%-- 
    Document   : userDetail
    Created on : Feb 15, 2025, 10:29:30 PM
    Author     : OS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Profile</title>
    <!-- Font (tuỳ chọn) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link 
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" 
        rel="stylesheet"
        >
    <link rel="stylesheet" href="${contextPath}/css/editProfile.css" />
</head>
<body>
    <jsp:include page="header.jsp"/>

    <section class="edit-profile-container">
        <form class="profile-form" action="${contextPath}/UserController" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <c:if test="${user != null}">
                    <input type="text" id="name" name="name" placeholder="${user.userName}"/>
                </c:if>
                <c:if test="${not empty nameError}">
                    <p style="color: red">${nameError}</p>
                </c:if>
                <c:if test="${user.getRole().getUserRole() == 'Admin'}">
                    <input type="text" id="name" name="name" placeholder="Enter name"/>
                </c:if>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <c:if test="${user != null}">
                    <input type="email" id="email" name="email" placeholder="${user.email}"/>
                </c:if>
                <c:if test="${not empty emailError}">
                    <p style="color: red">${emailError}</p>
                </c:if>
                <c:if test="${user.getRole().getUserRole() == 'Admin'}">
                    <input type="email" id="email" name="email" placeholder="Enter email"/>
                </c:if>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <c:if test="${user != null}">
                    <input type="tel" id="phone" name="phone" placeholder="${user.phoneNumber}"/>
                </c:if>
                <c:if test="${not empty phoneError}">
                    <p style="color: red">${phoneError}</p>
                </c:if>
                <c:if test="${user.getRole().getUserRole() == 'Admin'}">
                    <input type="tel" id="phone" name="phone" placeholder="Enter phone number"/>
                </c:if>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <c:if test="${user != null}">
                    <input type="text" id="location" name="location" placeholder="${user.location}"/>
                </c:if>
                <c:if test="${user.getRole().getUserRole() == 'Admin'}">
                    <input type="text" id="location" name="location" placeholder="Enter address"/>
                </c:if>
            </div>

            <div class="form-actions">
                <button type="button" class="change-image-btn">Change Image</button>
                <a href="${contextPath}/jsp/userProfile.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
                <button type="submit" name="service" value="userInfo" class="save-btn">Save</button>
            </div>
        </form>
    </section>

    <footer>
        <jsp:include page="footer.jsp"/>
    </footer>

</body>

