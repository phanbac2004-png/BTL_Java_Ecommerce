    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách sản phẩm đã mua - Admin</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Fredoka+One&display=swap" rel="stylesheet">
        
        <style>
            body {
                background: #fffafc;
                font-family: "Poppins", sans-serif;
                padding-top: 85px;
            }

            /* ======= HEADER GIỐNG HOMEPAGE ======= */
            .custom-header {
                background: linear-gradient(135deg, #ffd9f2 0%, #ffc2eb 100%) !important;
                border-radius: 0 0 25px 25px;
                box-shadow: 0 6px 15px rgba(255, 105, 180, 0.2);
                padding: 0.8rem 1.5rem;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                backdrop-filter: blur(10px);
            }

            .header-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
            }

            .logo-title {
                font-family: 'Fredoka One', cursive;
                font-size: 32px;
                color: #ff1493;
                margin-right: 30px;
                text-decoration: none;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }

            .logo-title:hover {
                color: #ff0066;
                transform: scale(1.05);
            }

            .nav-custom {
                display: flex;
                align-items: center;
                flex-grow: 1;
                justify-content: center;
            }

            .nav-custom a {
                margin: 0 12px;
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                color: #ff4da6;
                text-decoration: none;
                transition: all 0.3s ease;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 16px;
                position: relative;
            }

            .nav-custom a:hover {
                color: #ff0066;
                background: rgba(255, 255, 255, 0.4);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 105, 180, 0.2);
            }

            .nav-custom a::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 0;
                height: 2px;
                background: #ff0066;
                transition: all 0.3s ease;
                transform: translateX(-50%);
            }

            .nav-custom a:hover::after {
                width: 70%;
            }

            .search-form {
                display: flex;
                align-items: center;
                margin-left: 20px;
                margin-right: 20px;
            }

            .search-form .form-control {
                border-radius: 25px;
                border: 2px solid #ff85c0;
                padding: 8px 20px;
                font-size: 14px;
                min-width: 250px;
                background: rgba(255, 255, 255, 0.8);
                transition: all 0.3s ease;
            }

            .search-form .form-control:focus {
                border-color: #ff4da6;
                box-shadow: 0 0 0 0.2rem rgba(255, 105, 180, 0.25);
                background: white;
            }

            .cart-btn {
                margin-left: 10px;
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                color: #ff4da6;
                text-decoration: none;
                transition: all 0.3s ease;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 16px;
                position: relative;
                background: none;
                border: none;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
            }

            .cart-btn:hover {
                color: #ff0066;
                background: rgba(255, 255, 255, 0.4);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 105, 180, 0.2);
            }

            .header-right {
                display: flex;
                align-items: center;
            }

            .user-dropdown {
                position: relative;
                display: inline-block;
                margin-left: 10px;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background: white;
                min-width: 120px;
                box-shadow: 0 8px 25px rgba(255, 105, 180, 0.2);
                border-radius: 15px;
                z-index: 1001;
                overflow: hidden;
                border: 1px solid #ffd1eb;
            }

            .dropdown-content a {
                color: #ff4da6;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .dropdown-content a:hover {
                background: #ffe4f3;
                color: #ff0066;
                transform: translateX(5px);
            }

            .user-dropdown:hover .dropdown-content {
                display: block;
            }

            /* ======= MAIN CONTENT STYLING ======= */
            .main-content-container {
                margin-top: 25px;
            }

            .breadcrumb {
                background: linear-gradient(135deg, #ffe3f4 0%, #ffd1eb 100%);
                border-radius: 25px;
                padding: 12px 25px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                font-weight: 500;
                border: 1px solid #ffc2e0;
                margin-bottom: 30px;
            }

            .breadcrumb-item a {
                color: #ff4da6;
                text-decoration: none;
                font-weight: 600;
            }

            .breadcrumb-item.active {
                color: #ff0066;
            }

            /* ======= ADMIN DASHBOARD STYLING ======= */
            .admin-title {
                color: #ff1493;
                font-family: 'Fredoka One', cursive;
                font-weight: 400;
                margin-bottom: 30px;
                text-align: center;
            }

            .admin-card {
                border: none;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 6px 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                background: white;
                margin-bottom: 20px;
            }

            .admin-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 25px rgba(0,0,0,0.15);
            }

            .table-responsive {
                border-radius: 15px;
                overflow: hidden;
            }

            .thead-kid {
                background: linear-gradient(135deg, #ff85c0 0%, #ff6eb4 100%) !important;
                color: white;
                border: none;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(255, 228, 243, 0.3);
            }

            .table-hover tbody tr:hover {
                background-color: rgba(255, 193, 235, 0.5);
                transform: scale(1.01);
                transition: all 0.2s ease;
            }

            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 15px;
                border: 2px solid #ffd1eb;
                transition: transform 0.3s ease;
            }

            .product-image:hover {
                transform: scale(1.1);
            }

            .badge-kid {
                background: linear-gradient(135deg, #79e2ff 0%, #5ad4ff 100%);
                color: white;
                font-size: 0.9em;
                padding: 8px 15px;
                border-radius: 20px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(57, 204, 255, 0.3);
            }

            .text-pink-dark {
                color: #ff1493;
                font-weight: 700;
                font-size: 1.1em;
            }

            .btn-kid-outline {
                background: transparent;
                border: 2px solid #ff85c0;
                color: #ff4da6;
                font-weight: 600;
                border-radius: 25px;
                padding: 10px 25px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }

            .btn-kid-outline:hover {
                background: linear-gradient(135deg, #ff85c0 0%, #ff6eb4 100%);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 105, 180, 0.3);
                text-decoration: none;
            }

            .alert-kid {
                background: linear-gradient(135deg, #ffe3f4 0%, #ffd1eb 100%);
                border: 2px solid #ff85c0;
                color: #ff1493;
                border-radius: 15px;
                padding: 20px;
                font-weight: 500;
            }

            .table-kid-footer {
                background: linear-gradient(135deg, #ffd9f2 0%, #ffc2eb 100%);
                color: #ff1493;
                font-weight: 700;
                font-size: 1.1em;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header-container {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .nav-custom {
                    order: 2;
                    width: 100%;
                    justify-content: center;
                }
                
                .header-right {
                    order: 3;
                    width: 100%;
                    justify-content: center;
                    margin-top: 10px;
                    flex-wrap: wrap;
                }
                
                .search-form {
                    margin-left: 0;
                    margin-right: 0;
                    width: 100%;
                    justify-content: center;
                    margin-bottom: 10px;
                }
                
                .search-form .form-control {
                    min-width: 100%;
                }
                
                .cart-btn {
                    margin-left: 5px;
                    margin-right: 5px;
                    margin-top: 5px;
                }
                
                .user-dropdown {
                    margin-left: 5px;
                    margin-top: 5px;
                }
                
                body {
                    padding-top: 150px;
                }
                
                .main-content-container {
                    margin-top: 15px;
                }

                .table-responsive {
                    font-size: 0.9em;
                }

                .product-image {
                    width: 60px;
                    height: 60px;
                }
            }
        </style>
    </head>
    <body>
        <!-- HEADER GIỐNG HOMEPAGE -->
        <nav class="custom-header">
            <div class="header-container">
                <!-- Logo KIDDY bên trái -->
                <a class="logo-title" href="homepage">
                    <i class="fas fa-crown me-2"></i>KIDDY
                </a>
                
                <!-- Menu items ở giữa -->
                <div class="nav-custom">
                    <a href="homepage"><i class="fas fa-home me-2"></i>Home</a>
                    <a href="home"><i class="fas fa-shopping-bag me-2"></i>Shop</a>
                    <a href="admindashboard" class="active"><i class="fas fa-cog me-2"></i>Admin</a>
                </div>
                
                <!-- Search form, Cart và User Account bên phải -->
                <div class="header-right">
                    <form class="search-form">
                        <div class="input-group">
                            <input class="form-control" type="search" placeholder="Search products...">
                            <div class="input-group-append">
                                <button class="btn btn-outline-light" type="submit" style="border-radius: 0 25px 25px 0; border-color: #ff85c0; color: #ff4da6;">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                    
                    <!-- Phần User Account -->
                    <c:choose>
                        <c:when test="${sessionScope.acc != null}">
                            <!-- Đã login - hiển thị tên user và nút logout -->
                            <div class="user-dropdown">
                                <a href="#" class="cart-btn">
                                    <i class="fas fa-user-circle me-2"></i>${sessionScope.acc.user}
                                </a>
                                <div class="dropdown-content">
                                    <a href="logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Chưa login - hiển thị nút login -->
                            <a href="Login.jsp" class="cart-btn">
                                <i class="fas fa-user me-2"></i>Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>

        <!-- MAIN CONTENT -->
        <div class="container main-content-container">
            <!-- Breadcrumb -->
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="admindashboard">Admin</a></li>
                            <li class="breadcrumb-item active">Sản phẩm đã bán</li>
                        </ol>
                    </nav>
                </div>
            </div>
            
            <!-- Page Title -->
            <h2 class="admin-title"><i class="fas fa-chart-line me-2"></i> Danh sách sản phẩm đã mua</h2>
            
            <!-- Content -->
            <c:if test="${empty list}">
                <div class="alert alert-kid text-center">
                    <i class="fas fa-info-circle me-2"></i> Chưa có sản phẩm nào được mua.
                </div>
            </c:if>
            
            <c:if test="${not empty list}">
                <div class="card admin-card">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead class="thead-kid">
                                    <tr>
                                        <th>STT</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng đã bán</th>
                                        <th>Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="item" varStatus="loop">
                                        <tr>
                                            <td class="align-middle">${loop.index + 1}</td>
                                            <td class="align-middle">
                                                <img src="${item.product.image}" alt="${item.product.name}" 
                                                     class="product-image" onerror="this.src='https://via.placeholder.com/80'">
                                            </td>
                                            <td class="align-middle">
                                                <strong>${item.product.name}</strong>
                                                <br>
                                                <small class="text-muted">ID: ${item.product.id}</small>
                                            </td>
                                            <td class="align-middle">
                                                <fmt:formatNumber value="${item.product.price}" 
                                                                  type="number" 
                                                                  pattern="#,###"/> đ
                                            </td>
                                            <td class="align-middle">
                                                <span class="badge-kid">
                                                    <i class="fas fa-shopping-cart me-1"></i> ${item.totalSold}
                                                </span>
                                            </td>
                                            <td class="align-middle">
                                                <strong class="text-pink-dark">
                                                    <fmt:formatNumber value="${item.totalRevenue}" 
                                                                      type="number" 
                                                                      pattern="#,###"/> đ
                                                </strong>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="table-kid-footer">
                                        <td colspan="4" class="text-right"><strong>TỔNG CỘNG:</strong></td>
                                        <td>
                                            <strong>
                                                <c:set var="totalQuantity" value="0"/>
                                                <c:forEach items="${list}" var="item">
                                                    <c:set var="totalQuantity" value="${totalQuantity + item.totalSold}"/>
                                                </c:forEach>
                                                ${totalQuantity}
                                            </strong>
                                        </td>
                                        <td>
                                            <strong class="text-pink-dark">
                                                <c:set var="totalRevenue" value="0"/>
                                                <c:forEach items="${list}" var="item">
                                                    <c:set var="totalRevenue" value="${totalRevenue + item.totalRevenue}"/>
                                                </c:forEach>
                                                <fmt:formatNumber value="${totalRevenue}" 
                                                                  type="number" 
                                                                  pattern="#,###"/> đ
                                            </strong>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Back Button -->
            <div class="mt-4 text-center">
                <a href="manager" class="btn btn-kid-outline">
                    <i class="fas fa-arrow-left me-2"></i> Quay lại
                </a>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>