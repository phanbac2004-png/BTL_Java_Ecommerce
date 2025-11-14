<%-- 
    Document   : Home-page
    Created on : Nov 1, 2025
    Author     : This PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>KIDDY - Thế giới thời trang trẻ em cao cấp</title>

    <!-- Bootstrap & icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Fredoka+One&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-pink: #ff4da6;
            --dark-pink: #ff0066;
            --light-pink: #ffd9f2;
            --accent-blue: #79e2ff;
            --dark-blue: #5ad4ff;
            --gold: #ffd700;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #fffafc 0%, #fff0f7 100%);
            overflow-x: hidden;
            min-height: 100vh;
        }

        
        /* ======= SEARCH FORM ======= */
        .search-form {
            display: flex;
            align-items: center;
            margin-left: 15px;
            margin-right: 15px;
            position: relative;
        }

        .search-container {
            position: relative;
            display: flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 18px;
            padding: 3px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .search-container:focus-within {
            border-color: var(--accent-blue);
            box-shadow: 0 3px 12px rgba(122, 226, 255, 0.4);
        }

        .search-form .form-control {
            border: none;
            border-radius: 16px;
            padding: 6px 14px;
            font-size: 12px;
            width: 220px;
            background: transparent;
            font-family: Arial, sans-serif;
        }

        .search-form .form-control:focus {
            box-shadow: none;
        }

        .search-btn {
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--dark-blue) 100%);
            border: none;
            border-radius: 50%;
            color: white;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 11px;
        }

        .search-btn:hover {
            transform: scale(1.05);
        }

        /* ======= CART BUTTON ======= */
        .cart-btn {
            margin-left: 10px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            padding: 6px 14px;
            border-radius: 18px;
            font-size: 13px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            display: inline-flex;
            align-items: center;
        }

        .cart-btn:hover {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: linear-gradient(135deg, var(--gold) 0%, #ffc107 100%);
            color: #333;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            font-size: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .header-right {
            display: flex;
            align-items: center;
        }

        /* ======= HERO BANNER ======= */
        .hero-section {
            background: linear-gradient(135deg, #ffe6f2 0%, #ffd1eb 50%, #ffbde1 100%);
            min-height: 70vh;
            display: flex;
            align-items: center;
            position: relative;
            text-rendering: optimizeLegibility;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            overflow: hidden;
            margin-top: 80px;
            border-radius: 0 0 25px 25px;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: var(--dark-pink);
        }

        .hero-title {
            font-family: 'Fredoka One', cursive;
            font-size: 6.4rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            animation: floatTitle 3s ease-in-out infinite;
        }

        .hero-subtitle {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1.5rem;
            font-weight: 400;
            font-family: Arial, sans-serif;
        }

        @keyframes floatTitle {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }

        /* ======= FLOATING ELEMENTS ======= */
        .floating-element {
            position: absolute;
            animation: float 6s ease-in-out infinite;
            z-index: 1;
        }

        .floating-1 { top: 20%; left: 10%; animation-delay: 0s; }
        .floating-2 { top: 60%; right: 15%; animation-delay: 2s; }
        .floating-3 { bottom: 20%; left: 20%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-12px) rotate(5deg); }
        }

        /* ======= PRODUCT CARDS ======= */
        .products-section {
            padding: 50px 0;
            background: linear-gradient(135deg, #fffafc 0%, #ffffff 100%);
        }

        .section-title {
            text-align: center;
    font-family: Arial, sans-serif;
    font-size: 2.2rem;
    color: var(--dark-pink);
    margin-bottom: 1.5rem;
    position: relative;
    font-weight: bold;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -6px;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 3px;
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--accent-blue) 100%);
            border-radius: 2px;
        }

        .product-card {
            border: none;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            background: white;
            position: relative;
            margin-bottom: 20px;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(255, 77, 166, 0.15);
        }

        .product-card img {
            height: 220px;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .product-card:hover img {
            transform: scale(1.05);
        }

        .card-body {
            padding: 1rem;
        }

        .product-name {
            font-weight: 600;
            color: var(--dark-pink);
            font-size: 0.95rem;
            margin-bottom: 0.4rem;
            text-decoration: none;
            transition: color 0.3s ease;
            font-family: Arial, sans-serif;
        }

        .product-name:hover {
            color: var(--primary-pink);
            text-decoration: none;
        }

        .product-description {
            color: #666;
            font-size: 0.8rem;
            margin-bottom: 0.8rem;
            line-height: 1.3;
            font-family: Arial, sans-serif;
        }

        .product-price {
            font-weight: 700;
            color: var(--primary-pink);
            font-size: 1rem;
            margin-bottom: 0.8rem;
            font-family: Arial, sans-serif;
        }

        .btn-add-cart {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 7px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            width: 100%;
            font-size: 0.85rem;
            font-family: Arial, sans-serif;
        }

        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 77, 166, 0.3);
        }

        /* ======= FEATURES SECTION ======= */
        .features-section {
            padding: 50px 0;
            background: linear-gradient(135deg, var(--light-pink) 0%, #ffe6f2 100%);
        }

        .feature-card {
            text-align: center;
            padding: 1.25rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(255, 77, 166, 0.12);
        }

        .feature-icon {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--dark-blue) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.8rem;
            color: white;
            font-size: 1.3rem;
        }

        .feature-title {
            font-weight: 600;
            color: var(--dark-pink);
            margin-bottom: 0.6rem;
            font-size: 1rem;
            font-family: Arial, sans-serif;
        }

        .feature-card p {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0;
            font-family: Arial, sans-serif;
        }

        /* ======= FOOTER ======= */
        .custom-footer {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
            color: white;
            padding: 40px 0 20px;
            border-radius: 25px 25px 0 0;
        }

        .footer-logo {
            font-family: 'Fredoka One', cursive;
            font-size: 1.8rem;
            margin-bottom: 0.8rem;
        }

        .footer-links h5 {
            font-weight: 600;
            margin-bottom: 0.8rem;
            color: white;
            font-size: 1rem;
            font-family: Arial, sans-serif;
        }

        .footer-links a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            margin-bottom: 0.4rem;
            font-size: 0.85rem;
            font-family: Arial, sans-serif;
        }

        .footer-links a:hover {
            color: white;
            transform: translateX(3px);
        }

        .social-links {
            display: flex;
            gap: 10px;
            margin-top: 0.8rem;
        }

        .social-links a {
            width: 32px;
            height: 32px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 0.8rem;
        }

        .social-links a:hover {
            background: white;
            color: var(--primary-pink);
            transform: translateY(-2px);
        }

        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.2);
            padding-top: 15px;
            margin-top: 25px;
            text-align: center;
            color: rgba(255,255,255,0.7);
            font-size: 0.8rem;
            font-family: Arial, sans-serif;
        }

        .custom-footer p {
            font-family: Arial, sans-serif;
            font-size: 0.85rem;
        }

        /* ======= RESPONSIVE DESIGN ======= */
        @media (max-width: 768px) {
            .custom-header {
                padding: 0.4rem 1rem;
                height: auto;
                min-height: 55px;
            }
            
            .hero-title {
                font-size: 1.8rem;
            }
            
            .hero-subtitle {
                font-size: 0.9rem;
            }
            
            .section-title {
                font-size: 1.6rem;
            }
            
            .header-container {
                flex-direction: column;
                gap: 8px;
                padding: 8px 0;
            }
            
            .nav-custom {
                order: 2;
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .header-right {
                order: 3;
                width: 100%;
                justify-content: center;
                margin-top: 8px;
            }
            
            .search-form {
                margin-left: 0;
                margin-right: 0;
                width: 100%;
                justify-content: center;
            }
            
            .search-container {
                width: 100%;
            }
            
            .search-form .form-control {
                width: 100%;
            }
        }

        /* ======= ANIMATIONS ======= */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .product-item {
            animation: fadeInUp 0.5s ease forwards;
            opacity: 0;
        }

        .product-item:nth-child(1) { animation-delay: 0.1s; }
        .product-item:nth-child(2) { animation-delay: 0.2s; }
        .product-item:nth-child(3) { animation-delay: 0.3s; }
        .product-item:nth-child(4) { animation-delay: 0.4s; }
        /* Pagination styling to match site theme (uses :root colors above) */
        .kid-pagination .page-link {
            color: var(--dark-pink);
            border-radius: 999px;
            padding: 6px 12px;
            margin: 0 6px;
            border: none;
            background: transparent;
            font-weight: 600;
            min-width: 42px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .kid-pagination .page-link i {
            font-size: 0.95rem;
        }

        .kid-pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
            color: white !important;
            box-shadow: 0 8px 20px rgba(255,77,166,0.15);
        }

        .kid-pagination .page-link:hover {
            background: rgba(255,77,166,0.06);
            color: var(--dark-pink);
            text-decoration: none;
        }

        .kid-pagination .page-item.disabled .page-link {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>

<body>
    <jsp:include page="Menu.jsp"></jsp:include>
            
    <!-- HERO BANNER -->
    <section class="hero-section">
        <!-- Floating Elements -->
        <div class="floating-element floating-1">
            <i class="fas fa-star fa-lg" style="color: var(--gold);"></i>
        </div>
        <div class="floating-element floating-2">
            <i class="fas fa-heart fa-lg" style="color: var(--primary-pink);"></i>
        </div>
        <div class="floating-element floating-3">
            <i class="fas fa-gem fa-lg" style="color: var(--accent-blue);"></i>
        </div>
        
        
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">KIDDY WORLD</h1>
                <p class="hero-subtitle">Thế giới thời trang trẻ em cao cấp - Nơi những thiên thần nhỏ tỏa sáng</p>
                <a href="home" class="btn-add-cart" style="width: auto; padding: 10px 30px; font-size: 1.25rem;">
                    <i class="fas fa-shopping-bag me-2"></i>Mua sắm ngay
                </a>
            </div>
        </div>
    </section>

    <!-- FEATURES SECTION -->
    <section class="features-section">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h4 class="feature-title">Miễn phí vận chuyển</h4>
                        <p>Miễn phí vận chuyển cho đơn hàng từ 500,000 đ</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4 class="feature-title">Chất lượng đảm bảo</h4>
                        <p>100% sản phẩm chính hãng, an toàn cho bé</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4 class="feature-title">Hỗ trợ 24/7</h4>
                        <p>Đội ngũ tư vấn nhiệt tình, chuyên nghiệp</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- PRODUCTS SECTION -->
    <section class="products-section">
        <div class="container">
            <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
            <div class="row">
                <c:forEach items="${listP}" var="o" varStatus="status">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4 product-item">
                        <div class="product-card">
                            <img class="card-img-top" src="${o.image}" alt="${o.name}" 
                                 onerror="this.src='https://via.placeholder.com/300x300/ffe6f2/ff4da6?text=KIDDY'">
                            <div class="card-body">
                                <a href="detail?pid=${o.id}" class="product-name">${o.name}</a>
                                <p class="product-description">${o.title}</p>
                                <div class="product-price"><fmt:formatNumber value="${o.price}" type="number" pattern="#,###"/> đ</div>
                                <button class="btn-add-cart" data-product-id="${o.id}">
                                    <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Pagination -->
            <div class="row">
                <div class="col-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center kid-pagination">
                            <c:if test="${page > 1}">
                                <c:url var="prevUrl" value="${url}">
                                    <c:param name="page" value="${page - 1}" />
                                </c:url>
                                <li class="page-item">
                                    <a class="page-link" href="${prevUrl}" aria-label="Previous">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPage}">
                                <c:url var="pageUrl" value="${url}">
                                    <c:param name="page" value="${i}" />
                                </c:url>
                                <li class="page-item ${i == page ? 'active' : ''}"><a class="page-link" href="${pageUrl}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${page < totalPage}">
                                <c:url var="nextUrl" value="${url}">
                                    <c:param name="page" value="${page + 1}" />
                                </c:url>
                                <li class="page-item">
                                    <a class="page-link" href="${nextUrl}" aria-label="Next">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
            
            <!-- View More Button -->
            <div class="text-center mt-4">
                <a href="home" class="btn-add-cart" style="width: auto; padding: 10px 35px; font-size: 0.95rem;">
                    <i class="fas fa-eye me-2"></i>Xem tất cả sản phẩm
                </a>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="custom-footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="footer-logo">
                        <i class="fas fa-crown me-2"></i>KIDDY
                    </div>
                    <p>KIDDY - Thương hiệu thời trang trẻ em cao cấp, mang đến những sản phẩm chất lượng nhất cho các thiên thần nhỏ.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-tiktok"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <div class="footer-links">
                        <h5>Liên kết</h5>
                        <a href="homepage">Trang chủ</a>
                        <a href="home">Cửa hàng</a>
                        <a href="#">Về chúng tôi</a>
                        <a href="#">Liên hệ</a>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="footer-links">
                        <h5>Danh mục</h5>
                        <a href="#">Áo thun trẻ em</a>
                        <a href="#">Váy công chúa</a>
                        <a href="#">Quần jeans</a>
                        <a href="#">Phụ kiện</a>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="footer-links">
                        <h5>Thông tin</h5>
                        <p><i class="fas fa-map-marker-alt me-2"></i> 123 Đường ABC, Hà Nội</p>
                        <p><i class="fas fa-phone me-2"></i> 0123.456.789</p>
                        <p><i class="fas fa-envelope me-2"></i> info@kiddy.com</p>
                    </div>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 KIDDY | Designed with <i class="fas fa-heart" style="color: #ff4757;"></i> by Team UNETI</p>
            </div>
        </div>
    </footer>

    <script>
        // Cart functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Add to cart buttons
            document.querySelectorAll('.btn-add-cart').forEach(btn => {
                btn.addEventListener('click', function() {
                    const productId = this.getAttribute('data-product-id');
                    addToCart(productId);
                });
            });

            function addToCart(productId) {
                // Get current cart from localStorage
                let cart = JSON.parse(localStorage.getItem('kiddyCart')) || [];
                
                // Check if product already in cart
                const existingItem = cart.find(item => item.id === productId);
                
                if (existingItem) {
                    existingItem.quantity += 1;
                } else {
                    // Add new product to cart
                    cart.push({
                        id: productId,
                        quantity: 1
                    });
                }
                
                // Save back to localStorage
                localStorage.setItem('kiddyCart', JSON.stringify(cart));
                
                // Update cart count
                updateCartCount();
                
                // Show success message
                showNotification('Đã thêm sản phẩm vào giỏ hàng!');
            }

            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('kiddyCart')) || [];
                const totalItems = cart.reduce((total, item) => total + item.quantity, 0);
                document.querySelector('.cart-count').textContent = totalItems;
            }

            function showNotification(message) {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = 'alert alert-success position-fixed';
                toast.style.cssText = `
                    top: 70px;
                    right: 15px;
                    z-index: 9999;
                    min-width: 260px;
                    border-radius: 12px;
                    box-shadow: 0 3px 10px rgba(0,0,0,0.15);
                    border: none;
                    background: linear-gradient(135deg, var(--accent-blue) 0%, var(--dark-blue) 100%);
                    color: white;
                    font-weight: 500;
                    font-size: 0.85rem;
                    padding: 10px 16px;
                    font-family: Arial, sans-serif;
                `;
                toast.innerHTML = `
                    <i class="fas fa-check-circle me-2"></i>${message}
                `;
                
                document.body.appendChild(toast);
                
                // Remove after 3 seconds
                setTimeout(() => {
                    toast.remove();
                }, 3000);
            }

            // Initialize cart count
            updateCartCount();
        });
    </script>
</body>
</html>