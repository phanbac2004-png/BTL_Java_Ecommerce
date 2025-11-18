<%-- 
    Document   : Footer
    Created on : Nov 1, 2025
    Author     : This PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    :root {
        --primary-pink: #ff4da6;
        --dark-pink: #ff0066;
        --light-pink: #ffd9f2;
        --accent-blue: #79e2ff;
        --dark-blue: #5ad4ff;
        --gold: #ffd700;
    }
    
    /* ======= FOOTER STYLES ======= */
    .custom-footer {
        background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
        color: white;
        padding: 40px 0 20px;
        border-radius: 25px 25px 0 0;
        margin-top: 50px;
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

    /* Style cho phần thông tin thành viên */
    .member-info {
        color: rgba(255,255,255,0.8);
        font-family: Arial, sans-serif;
        font-size: 0.85rem;
        line-height: 1.5;
    }

    .member-info li {
        margin-bottom: 0.4rem;
        list-style: none;
        padding-left: 0;
    }

    .member-info hr {
        border-color: rgba(255,255,255,0.3);
        margin: 0.5rem 0 1rem 0;
        width: 50px;
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
        line-height: 1.5;
    }

    /* Responsive Footer */
    @media (max-width: 768px) {
        .custom-footer {
            padding: 30px 0 15px;
            border-radius: 20px 20px 0 0;
        }
        
        .footer-logo {
            font-size: 1.5rem;
            text-align: center;
        }
        
        .footer-links {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .social-links {
            justify-content: center;
        }
        
        .member-info {
            text-align: center;
        }
        
        .member-info hr {
            margin-left: auto;
            margin-right: auto;
        }
    }
</style>

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
                    <a href="Contact.jsp">Liên hệ</a>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="footer-links">
                    <h5>Danh mục</h5>
                    <a href="category?cid=1">Áo thun</a>
                    <a href="category?cid=2">Đồ bộ</a>
                    <a href="category?cid=3">Quần</a>
                    <a href="category?cid=5">Phụ kiện</a>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="footer-links">
                    <h5>Thành viên</h5>
                    <div class="member-info">
                        <hr>
                        <li>Nguyễn Hoàng Dương - 23/01/2004</li>
                        <li>Phan Xuân Bắc - 26/10/2004</li>
                        <li>Hoàng Đăng Thái Duy - 25/10/2004</li>
                        <li>Nguyễn Thị Lan Anh - 17/06/2004</li>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2025 KIDDY | Designed with <i class="fas fa-heart" style="color: #ff4757;"></i> by Team UNETI</p>
        </div>
    </div>
</footer>