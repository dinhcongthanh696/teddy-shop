<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Profile Hub - Trang hồ sơ</title>
        <!-- Liên kết tới file CSS -->
        <link rel="stylesheet" href="${contextPath}/css/userProfile.css" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!-- Container chính -->
        <div class="container">
            <div class="profile-card">
                <!-- Ảnh đại diện -->
                <img 
                    src="${contextPath}/${user.profilePic}" 
                    alt="Avatar" 
                    class="avatar"
                    />
                <!-- Thông tin cơ bản -->
                <div class="profile-info">
                    <h2>${user.userName}</h2>
                    <p href="">${user.email}</p>
                </div>  

                <!-- Tóm tắt tài khoản -->
                <div class="account-summary">
                    <h3>Thông tin tài khoản</h3>
                    <p>Là thành viên từ: ${user.createdDate}</p>
                    <p>Điện thoại: ${user.phoneNumber}</p>
                    <p>Địa chỉ: ${user.location}</p>
                </div>

                <!-- Nút thao tác -->
                <div class="actions">
                    <a href="${contextPath}/jsp/userDetail.jsp"><button class="btn">Chỉnh sửa</button></a>
                    <button class="btn">Lịch sử giao dịch</button>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"/>
    </body>
</html>
