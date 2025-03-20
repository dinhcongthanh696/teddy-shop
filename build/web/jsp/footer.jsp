<%-- 
    Document   : footer.jsp
    Created on : Feb 10, 2025, 1:07:16 AM
    Author     : OS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${contextPath}/css/footer.css"/>
    </head>
    <body>
        <footer class="footer">
            
            <!-- Khối: Thông tin cửa hàng, tài khoản ngân hàng, Fanpage, Chính sách -->
            <div class="footer__middle">
                <!-- Thông tin cửa hàng -->
                <div class="footer__info-block">
                    <h3 class="footer__title">HỆ THỐNG CỬA HÀNG</h3>
                    <p><strong>HÀ NỘI | 8:30 - 23:00</strong></p>
                    <ul class="footer__list">
                        <li>275 Bạch Mai, Hai Bà Trưng, Hà Nội - 0979896616</li>
                        <li>368 Nguyễn Trãi, Trung Văn (Phùng Khoang) - 033.567.6616</li>
                        <li>411 Nguyễn Văn Cừ, Long Biên - 034.369.6616</li>
                        <li>161 Xuân Thủy, Cầu Giấy - 033.876.6616</li>
                        <li>104 - 106 Cầu Giấy - 03.9799.6616</li>
                        <li>1028 Đường Láng, Đống Đa - 035.369.6616</li>
                    </ul>
                </div>

                <!-- Thông tin chuyển khoản -->
                <div class="footer__info-block">
                    <h3 class="footer__title">CHUYỂN KHOẢN ONLINE</h3>
                    <p>+ <strong>TECHCOMBANK</strong><br>
                        STK: 13324861911019<br>
                        Chủ TK: Nguyễn Phương Hoa – CN Láng Hạ
                    </p>
                    <p>+ PAYPAL / MOMO / SHOPEE PAY</p>
                </div>

                <!-- Fanpage & Mạng xã hội -->
                <div class="footer__info-block">
                    <h3 class="footer__title">FANPAGE</h3>
                    <p>Follow nhà Gấu nhé!</p>
                    <p><a href="#" target="_blank">Gấu Bông Online</a></p>
                    
                </div>

                <!-- Hỗ trợ khách hàng -->
                <div class="footer__info-block">
                    <h3 class="footer__title">HỖ TRỢ KHÁCH HÀNG</h3>
                    <ul class="footer__list">
                        <li><a href="#">Chính sách bán Buôn - Sỉ</a></li>
                        <li><a href="#">Chính sách chung</a></li>
                        <li><a href="#">Hướng dẫn thanh toán</a></li>
                        <li><a href="#">Hướng dẫn đổi trả</a></li>
                    </ul>
                </div>
            </div>

            <!-- Khối: Bản quyền, thông tin bổ sung -->
            <div class="footer__bottom">
                <p>&copy; 2025 Gấu Bông Online. All rights reserved.</p>
            </div>
        </footer>

    </body>
</html>
