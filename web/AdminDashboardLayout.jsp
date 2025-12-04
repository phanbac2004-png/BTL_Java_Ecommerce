<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard | Kiddy</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
        
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Nunito', -apple-system, BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial, sans-serif;
                background-color: #FEF9FA; /* Nền hồng nhạt */
                overflow-x: hidden;
                color: #555;
                font-size: 14px;
                line-height: 1.5;
            }
            
            * {
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }
            
            /* Header */
            .admin-header {
                background: #FCE4EC; /* Nền hồng nhạt */
                color: #C2185B; /* Chữ hồng đậm */
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                height: 70px;
            }
            
            .logo-section {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .logo-section .crown-icon {
                font-size: 24px;
            }
            
            .logo-section .logo-text {
                font-size: 20px;
                font-weight: 800; /* Đậm hơn */
                letter-spacing: 0.5px;
            }
            
            .nav-buttons {
                display: flex;
                gap: 5px;
            }
            
            .nav-btn {
                background: transparent;
                border: none;
                color: #AD1457; /* Chữ hồng */
                padding: 8px 20px;
                border-radius: 30px; /* Bo tròn */
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s;
                font-size: 14px;
                font-weight: 700;
            }
            
            .nav-btn:hover {
                background: rgba(236, 64, 122, 0.1); /* Nền hồng mờ */
                color: #AD1457;
                text-decoration: none;
            }
            
            .nav-btn.active {
                background: #EC407A; /* Nền hồng đậm */
                color: white; /* Chữ trắng */
                font-weight: 700;
            }
            
            .user-section {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            
            .user-name {
                font-size: 14px;
                font-weight: 700;
            }
            
            .logout-btn {
                background: rgba(236, 64, 122, 0.1); /* Nền hồng mờ */
                border: none;
                color: #AD1457;
                padding: 8px 15px;
                border-radius: 30px;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s;
                font-size: 14px;
                font-weight: 700;
            }
            
            .logout-btn:hover {
                background: #EC407A; /* Nền hồng đậm */
                color: white;
                text-decoration: none;
            }
            
            /* Container */
            .admin-container {
                display: flex;
                margin-top: 70px;
                min-height: calc(100vh - 70px);
            }
            
            /* Sidebar */
            .admin-sidebar {
                width: 260px;
                background: #ffffff;
                min-height: calc(100vh - 70px);
                padding: 20px 0;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
                position: fixed;
                height: calc(100vh - 70px);
                overflow-y: auto;
                border-right: 1px solid #FCE4EC; /* Viền hồng nhạt */
            }
            
            .sidebar-title {
                padding: 0 20px 15px 20px;
                border-bottom: 2px solid #FCE4EC; /* Viền hồng nhạt */
                margin-bottom: 15px;
            }
            
            .sidebar-title h5 {
                color: #C2185B; /* Chữ hồng đậm */
                font-weight: 800; /* Đậm hơn */
                font-size: 16px;
                margin: 0;
            }
            
            .sidebar-menu {
                list-style: none;
                padding: 0 10px; /* Thêm padding 2 bên */
            }
            
            .sidebar-menu li {
                margin: 5px 0;
            }
            
            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px 20px;
                color: #AD1457; /* Chữ hồng */
                text-decoration: none;
                transition: all 0.3s;
                font-size: 14px;
                font-weight: 700;
                border-radius: 10px; /* Bo góc */
            }
            
            .sidebar-menu a:hover {
                background: #FEF9FA; /* Nền hồng siêu nhạt */
                color: #EC407A;
                text-decoration: none;
            }
            
            .sidebar-menu a.active {
                background: #F06292; /* Nền hồng */
                color: white;
                font-weight: 700;
            }
            
            .sidebar-menu a i {
                width: 20px;
                text-align: center;
            }
            
            /* Main Content */
            .admin-content {
                margin-left: 260px;
                padding: 30px;
                width: calc(100% - 260px);
                flex: 1;
            }
            
            /* Responsive (Giữ nguyên) */
            @media (max-width: 768px) {
                .admin-sidebar {
                    width: 100%;
                    position: relative;
                    height: auto;
                }
                .admin-content {
                    margin-left: 0;
                    width: 100%;
                }
                .nav-buttons {
                    display: none;
                }
            }
        </style>
        </head>
    <body>
        <div class="admin-header">
            <div class="logo-section">
                <i class="fas fa-crown crown-icon"></i>
                <div>
                     <a href="home" style="color: #C2185B; text-decoration: none;">
                        <div class="logo-text">KIDDY</div>
                        <div style="font-size: 10px; opacity: 0.9;">ADMIN</div>
                    </a>
                 </div>
            </div>
            
            <div class="nav-buttons">
                <a href="admindashboard?page=dashboard" class="nav-btn ${param.page == 'dashboard' || (requestScope['javax.servlet.forward.request_uri'] != null && requestScope['javax.servlet.forward.request_uri'].contains('admindashboard') && param.page == null) ? 'active' : ''}">
                     <i class="fas fa-chart-line"></i> Dashboard
                </a>
                <a href="admindashboard?page=products" class="nav-btn ${param.page == 'products' ? 'active' : ''}">
                    <i class="fas fa-box"></i> Sản Phẩm
                </a>
                <a href="adminorders" class="nav-btn ${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminorders') ? 'active' : ''}">
                    <i class="fas fa-shopping-bag"></i> Đơn Hàng
                </a>
                <a href="adminusers" class="nav-btn ${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminusers') ? 'active' : ''}">
                    <i class="fas fa-users"></i> Khách Hàng
                </a>
                <a href="adminrevenue" class="nav-btn ${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminrevenue') ? 'active' : ''}">
                    <i class="fas fa-chart-bar"></i> Báo Cáo
                </a>
            </div>
            
            <div class="user-section">
                <a href="home" class="nav-btn" style="margin-right: 10px;" title="Về trang Shop">
                    <i class="fas fa-home"></i> Shop
                </a>
                <span class="user-name">${sessionScope.acc.user}</span>
                <a href="logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
        
        <div class="admin-container">
            <div class="admin-sidebar">
                <div class="sidebar-title">
                    <h5><i class="fas fa-cog"></i> Kiddy Admin</h5>
                </div>
                
                <ul class="sidebar-menu">
                    <li>
                         <a href="admindashboard" class="${param.page == null || param.page == 'dashboard' ? 'active' : ''}">
                            <i class="fas fa-chart-line"></i>
                            <span>Dashboard</span>
                        </a>
                     </li>
                    <li>
                        <a href="admindashboard?page=products" class="${param.page == 'products' ? 'active' : ''}">
                            <i class="fas fa-box"></i>
                             <span>Quản lý sản phẩm</span>
                        </a>
                    </li>
                    <li>
                         <a href="admincategories" class="${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('admincategories') ? 'active' : ''}">
                            <i class="fas fa-tags"></i>
                            <span>Danh mục</span>
                        </a>
                     </li>
                    <li>
                        <a href="adminorders" class="${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminorders') ? 'active' : ''}">
                            <i class="fas fa-shopping-cart"></i>
                             <span>Đơn hàng</span>
                        </a>
                    </li>
                    <li>
                        <a href="adminusers" class="${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminusers') ? 'active' : ''}">
                             <i class="fas fa-users"></i>
                            <span>Khách hàng</span>
                        </a>
                     </li>
                    <li>
                        <a href="adminsoldproducts" class="${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminsoldproducts') ? 'active' : ''}">
                            <i class="fas fa-warehouse"></i>
                             <span>Danh sách sản phẩm đã bán</span>
                        </a>
                    </li>
                    <li>
                        <a href="adminrevenue" class="${requestScope['javax.servlet.forward.servlet_path'] != null && requestScope['javax.servlet.forward.servlet_path'].contains('adminrevenue') ? 'active' : ''}">
                             <i class="fas fa-file-alt"></i>
                            <span>Báo cáo</span>
                        </a>
                    </li>
                 </ul>
            </div>
            
            <div class="admin-content">
                <jsp:include page="${contentPage}"></jsp:include>
            </div>
         </div>
        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // JavaScript để xử lý active state cho sidebar
            $(document).ready(function() {
                // Lấy URL hiện tại
                const currentUrl = window.location.href;
                
                // Xác định trang hiện tại và thêm class active
                $('.sidebar-menu a').each(function() {
                    const linkUrl = $(this).attr('href');
                    
                    // Kiểm tra nếu URL hiện tại chứa linkUrl
                    if (currentUrl.includes(linkUrl)) {
                        // Xóa active class từ tất cả các mục
                        $('.sidebar-menu a').removeClass('active');
                        // Thêm active class cho mục hiện tại
                        $(this).addClass('active');
                    }
                });
                
                // Xử lý đặc biệt cho trang dashboard mặc định
                if (currentUrl.includes('admindashboard') && !currentUrl.includes('page=')) {
                    $('.sidebar-menu a').removeClass('active');
                    $('.sidebar-menu a[href="admindashboard"]').addClass('active');
                }
            });
        </script>
    </body>
</html>