<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Fredoka+One&display=swap');
    
    .custom-header {
        background: linear-gradient(135deg, #ffd9f2 0%, #ffc2eb 100%) !important;
        border-radius: 0 0 25px 25px;
        box-shadow: 0 6px 15px rgba(255, 105, 180, 0.2);
        padding: 0.6rem 1.5rem;
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
        max-width: 1400px;
        margin: 0 auto;
        gap: 20px;
    }

    .logo-title {
        font-family: 'Fredoka One', cursive;
        font-size: 28px;
        color: #ff1493;
        text-decoration: none;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .logo-title:hover {
        color: #ff0066;
        transform: scale(1.05);
    }

    .nav-custom {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-grow: 1;
        gap: 8px;
        flex-wrap: nowrap;
        min-width: 0;
    }

    .nav-custom a {
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        color: #ff4da6;
        text-decoration: none;
        transition: all 0.3s ease;
        padding: 6px 12px;
        border-radius: 16px;
        font-size: 14px;
        position: relative;
        white-space: nowrap;
        flex-shrink: 0;
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

    .nav-custom a.active {
        color: #ff0066;
        background: rgba(255, 255, 255, 0.4);
    }

    .search-form {
        display: flex;
        align-items: center;
        flex-shrink: 0;
        min-width: 0;
    }

    .search-form .form-control {
        border-radius: 20px;
        border: 2px solid #ff85c0;
        padding: 6px 16px;
        font-size: 13px;
        width: 200px;
        background: rgba(255, 255, 255, 0.8);
        transition: all 0.3s ease;
        font-family: 'Poppins', sans-serif;
    }

    .search-form .form-control:focus {
        border-color: #ff4da6;
        box-shadow: 0 0 0 0.2rem rgba(255, 105, 180, 0.25);
        background: white;
        width: 220px;
    }

    /* ======= NÚT CART ======= */
    .cart-btn {
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        color: #ff4da6;
        text-decoration: none;
        transition: all 0.3s ease;
        padding: 6px 12px;
        border-radius: 16px;
        font-size: 14px;
        position: relative;
        background: none;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .cart-btn:hover {
        color: #ff0066;
        background: rgba(255, 255, 255, 0.4);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(255, 105, 180, 0.2);
    }

    .btn-kid-search {
        background: linear-gradient(135deg, #ff85c0 0%, #ff6eb4 100%) !important;
        border: none;
        border-radius: 20px;
        color: white;
        font-weight: 500;
        transition: all 0.3s ease;
        margin-left: 5px;
        padding: 6px 12px;
        font-size: 13px;
    }

    .btn-kid-search:hover {
        background: linear-gradient(135deg, #ff6eb4 0%, #ff57a8 100%) !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(255, 105, 180, 0.3);
        color: white;
    }

    .btn-kid-cart {
        background: linear-gradient(135deg, #79e2ff 0%, #5ad4ff 100%) !important;
        border: none;
        border-radius: 16px;
        font-weight: 500;
        transition: all 0.3s ease;
        color: white;
        text-decoration: none;
        padding: 6px 12px;
        display: inline-flex;
        align-items: center;
        font-size: 14px;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .btn-kid-cart:hover {
        background: linear-gradient(135deg, #5ad4ff 0%, #3bc6ff 100%) !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(57, 204, 255, 0.3);
        color: white;
    }

    /* ======= NÚT CONTACT ======= */
    .btn-kid-contact {
        background: linear-gradient(135deg, #ffcc5c 0%, #ffb142 100%) !important;
        border: none;
        border-radius: 16px;
        font-weight: 500;
        transition: all 0.3s ease;
        color: white;
        text-decoration: none;
        padding: 6px 12px;
        display: inline-flex;
        align-items: center;
        font-size: 14px;
        white-space: nowrap;
        flex-shrink: 0;
    }

    .btn-kid-contact:hover {
        background: linear-gradient(135deg, #ffb142 0%, #ff9f1a 100%) !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(255, 159, 26, 0.3);
        color: white;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-shrink: 0;
        min-width: 0;
    }

    /* ======= DROPDOWN USER ======= */
    .user-dropdown {
        position: relative;
        display: inline-block;
        flex-shrink: 0;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        background: white;
        min-width: 180px;
        box-shadow: 0 8px 25px rgba(255, 105, 180, 0.2);
        border-radius: 12px;
        z-index: 1001;
        overflow: hidden;
        border: 1px solid #ffd1eb;
    }

    .dropdown-content a {
        color: #ff4da6;
        padding: 10px 14px;
        text-decoration: none;
        display: block;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.3s ease;
        font-family: 'Poppins', sans-serif;
    }

    .dropdown-content a:hover {
        background: #ffe4f3;
        color: #ff0066;
        transform: translateX(5px);
    }

    .user-dropdown:hover .dropdown-content {
        display: block;
    }

    /* Responsive */
    @media (max-width: 1200px) {
        .header-container {
            gap: 15px;
        }
        
        .search-form .form-control {
            width: 180px;
        }
        
        .search-form .form-control:focus {
            width: 200px;
        }
        
        .nav-custom a {
            font-size: 13px;
            padding: 5px 10px;
        }
    }

    @media (max-width: 992px) {
        .custom-header {
            padding: 0.5rem 1rem;
        }
        
        .header-container {
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .logo-title {
            font-size: 24px;
            order: 1;
        }
        
        .nav-custom {
            order: 3;
            width: 100%;
            justify-content: center;
            margin-top: 10px;
            gap: 5px;
        }
        
        .header-right {
            order: 2;
            flex-grow: 1;
            justify-content: flex-end;
            gap: 5px;
        }
        
        .search-form {
            flex-grow: 1;
            max-width: 200px;
        }
        
        .search-form .form-control {
            width: 100%;
        }
        
        body {
            padding-top: 120px;
        }
    }

    @media (max-width: 768px) {
        .nav-custom a {
            font-size: 12px;
            padding: 4px 8px;
        }
        
        .cart-btn, .btn-kid-cart, .btn-kid-contact {
            font-size: 12px;
            padding: 4px 8px;
        }
        
        .search-form .form-control {
            font-size: 12px;
            padding: 5px 12px;
        }
        
        .btn-kid-search {
            font-size: 12px;
            padding: 5px 10px;
        }
        
        body {
            padding-top: 110px;
        }
    }

    @media (max-width: 576px) {
        .header-container {
            gap: 8px;
        }
        
        .logo-title {
            font-size: 20px;
        }
        
        .nav-custom {
            flex-wrap: wrap;
        }
        
        .nav-custom a {
            font-size: 11px;
            padding: 3px 6px;
            margin: 2px;
        }
        
        .header-right {
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .search-form {
            max-width: 150px;
        }
        
        body {
            padding-top: 130px;
        }
    }

    /* ======= GLOBAL PRODUCT CARD ADJUSTMENTS =======
       Ensure all product cards across JSP pages have the same visual size,
       image cropping, and button alignment. This targets common classes used
       by product lists (e.g. in Home-page.jsp, ManagerProductContent.jsp, ...)
    */
    .products-section .product-item,
    .product-item {
        display: flex;
        align-items: stretch; /* make columns stretch to same height */
    }

    .product-item .product-card,
    .product-card {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: 100%;
        min-height: 360px; /* consistent card height - adjust if needed */
        box-sizing: border-box;
    }

    /* Keep image area fixed and cropped uniformly */
    .product-card .card-img-top,
    .product-card img {
        width: 100%;
        height: 220px;
        object-fit: cover;
        flex-shrink: 0;
        display: block;
    }

    /* Make the body stretch so price/button stick to bottom */
    .product-card .card-body,
    .card-body {
        display: flex;
        flex-direction: column;
        flex: 1 1 auto;
        padding: 1rem;
    }

    /* Clamp title and description to keep cards uniform */
    .product-name {
        font-weight: 600;
        color: #ff1493;
        font-size: 0.95rem;
        margin-bottom: 0.4rem;
        text-decoration: none;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .product-description {
        color: #666;
        font-size: 0.8rem;
        line-height: 1.3;
        margin-bottom: 0.6rem;
        flex: 1 1 auto;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .product-price {
        font-weight: 700;
        color: var(--primary-pink, #ff4da6);
        font-size: 1rem;
        margin-top: 0.25rem;
    }

    /* Push add-to-cart button to the card bottom */
    .product-card .btn-add-cart,
    .card-body .btn-add-cart {
        margin-top: 12px;
        align-self: stretch;
    }
</style>

<nav class="custom-header">
    <div class="header-container">
        <!-- Logo -->
        <a class="logo-title" href="home">
            <i class="fas fa-crown me-2"></i>KIDDY
        </a>
        
        <!-- Menu chính -->
        <div class="nav-custom">
            <a class="${param.activePage == 'homepage' ? 'active' : ''}" href="homepage">
                <i class="fas fa-home me-2"></i>Home
            </a>
            <a class="${param.activePage == 'home' ? 'active' : ''}" href="home">
                <i class="fas fa-shopping-bag me-2"></i>Shop
            </a>
            
            <!-- Menu Admin -->
            <c:if test="${sessionScope.acc != null && sessionScope.acc.isAdmin == 1}">
                <a class="${param.activePage == 'admindashboard' ? 'active' : ''}" href="admindashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                </a>
            </c:if>
            
            <!-- Menu User -->
            <c:if test="${sessionScope.acc != null}">
                <a class="${param.activePage == 'mypurchasedproducts' ? 'active' : ''}" href="mypurchasedproducts">
                    <i class="fas fa-shopping-bag me-2"></i>My Orders
                </a>
            </c:if>
        </div>
        
        <!-- Bên phải: Search, User, Cart, Contact -->
        <div class="header-right">
            <!-- Form tìm kiếm -->
            <form action="search" method="post" class="search-form">
                <div class="input-group">
                    <input value="${txtS}" name="txt" type="text" class="form-control" placeholder="Search..." aria-label="Search">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-kid-search">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>

            <!-- User Account -->
            <c:choose>
                <c:when test="${sessionScope.acc != null}">
                    <div class="user-dropdown">
                        <a href="#" class="cart-btn">
                            <i class="fas fa-user-circle me-2"></i>Hello ${sessionScope.acc.user}
                        </a>
                        <div class="dropdown-content">
                            <c:if test="${sessionScope.acc.isAdmin == 1}">
                                <a href="admindashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                <a href="manager"><i class="fas fa-box me-2"></i>Manage Products</a>
                            </c:if>
                            <c:if test="${sessionScope.acc.isAdmin == 0}">
                                <a href="profile"><i class="fas fa-user me-2"></i>Profile</a>
                                <a href="mypurchasedproducts"><i class="fas fa-receipt me-2"></i>My Orders</a>
                            </c:if>
                            <a href="logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="Login.jsp" class="cart-btn">
                        <i class="fas fa-user me-2"></i>Login
                    </a>
                </c:otherwise>
            </c:choose>

            <!-- Nút Contact -->
            <a class="btn btn-kid-contact btn-sm" href="contact">
                <i class="fas fa-envelope me-2"></i> Contact
            </a>

            <!-- Nút Cart -->
            <a class="btn btn-kid-cart btn-sm" style="max-width:fit-content" href="cart">
                <i class="fa fa-shopping-cart"></i> Cart
            </a>
        </div>
    </div>
</nav>

<div style="margin-top: 70px;"></div>