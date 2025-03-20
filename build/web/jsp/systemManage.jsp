<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>System Manage</title>
        <link rel="stylesheet" href="../css/systemManage.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <c:if test="${user.role.userRole == 'Seller'}">
            <div class="wrap text-center">
                <a href="" style="text-decoration: none;color:black" >
                    <div class="big-button">
                        <span class="fas fa-user-shield">Product List</span>  
                    </div>
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Order List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Customer List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Attendance</span>  
                    </div> 
                </a>
            </div>
        </c:if>

        <c:if test="${user.role.userRole == 'Manager'}">
            <div class="wrap text-center">
                <a href="" style="text-decoration: none;color:black" >
                    <div class="big-button">
                        <span class="fas fa-user-shield">Dashboard</span>  
                    </div>
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Staff List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Customer List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Attendance</span>  
                    </div> 
                </a>
            </div>
        </c:if>
        
        <c:if test="${user.role.userRole == 'Marketing'}">
            <div class="wrap text-center">
                <a href="" style="text-decoration: none;color:black" >
                    <div class="big-button">
                        <span class="fas fa-user-shield">Blog List</span>  
                    </div>
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Campaign List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Voucher List</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Attendance</span>  
                    </div> 
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Dashboard</span>  
                    </div> 
                </a>
            </div>
        </c:if>
        
        <c:if test="${user.role.userRole == 'Admin'}">
            <div class="wrap text-center">
                <a href="" style="text-decoration: none;color:black" >
                    <div class="big-button">
                        <span class="fas fa-user-shield">Setting List</span>  
                    </div>
                </a>
                <a href="" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">User List</span>  
                    </div> 
                </a>
            </div>
        </c:if>

        <jsp:include page="footer.jsp"/>
    </body>
</html>