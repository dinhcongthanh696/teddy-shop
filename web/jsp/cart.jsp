<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cart - Teddy Bear Shop</title>
    
    <!-- Link Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Link file CSS riêng -->
    <link rel="stylesheet" href="../css/cart.css">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>

    <!-- Header (Navbar) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-custom px-3">
        <div class="container-fluid">
            <!-- Logo & Brand -->
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="logo.png" alt="Logo" class="logo me-2"> 
                <span class="fw-bold text-white">Teddy Bear</span>
            </a>

            <!-- Search Box -->
            <div class="search-box">
                <input type="text" class="form-control" placeholder="Search">
                <button class="btn btn-light"><i class="bi bi-search"></i></button>
            </div>

            <!-- Navbar toggler (for mobile) -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Items -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link text-white" href="#">Home</a></li>

                    <!-- Dropdown Products -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            Products
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Stuffed Bears</a></li>
                            <li><a class="dropdown-item" href="#">Accessories</a></li>
                        </ul>
                    </li>

                    <!-- Dropdown Services -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            Services
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Gift Wrapping</a></li>
                            <li><a class="dropdown-item" href="#">Customization</a></li>
                        </ul>
                    </li>

                    <!-- About Us & Blog -->
                    <li class="nav-item"><a class="nav-link text-white" href="#">About Us</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="#">Blog</a></li>

                    <!-- User Info -->
                    <li class="nav-item d-flex align-items-center">
                        <span class="text-white me-2">ID Customer</span>
                        <img src="user-avatar.png" alt="User" class="user-avatar me-3">
                    </li>

                    <!-- Cart Icon -->
                    <li class="nav-item">
                        <a class="nav-link text-white fs-4" href="#"><i class="bi bi-cart"></i></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2 class="fw-bold">View Cart</h2>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered text-center">
                <thead class="table-light">
                    <tr>
                        <th>No.</th>
                        <th>Photo</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Dữ liệu giỏ hàng --%>
                    <% for (int i = 1; i <= 6; i++) { %>
                        <tr>
                            <td><%= i %></td>
                            <td><img src="placeholder.png" alt="Product Image" class="product-img"></td>
                            <td>Product <%= i %></td>
                            <td>$XX.XX</td>
                            <td><input type="number" class="form-control w-50 mx-auto" value="1"></td>
                            <td><i class="bi bi-trash text-danger fs-5"></i></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Estimated Total & Purchase Button -->
        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4 class="fw-bold">Estimated: $$$</h4>
            <button class="btn btn-success px-4">Purchase</button>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
