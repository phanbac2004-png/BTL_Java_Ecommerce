<%-- 
    Document   : contact
    Created on : Nov 1, 2025
    Author     : This PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Liên hệ - KIDDY</title>

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

        /* ======= HEADER COMPACT ======= */
        .custom-header {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%) !important;
            border-radius: 0 0 20px 20px;
            box-shadow: 0 4px 20px rgba(255, 77, 166, 0.3);
            padding: 0.5rem 1.5rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            backdrop-filter: blur(20px);
            border: none;
            height: 65px;
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            height: 100%;
        }

        .logo-title {
            font-family: 'Fredoka One', cursive;
            font-size: 26px;
            color: white;
            margin-right: 30px;
            text-decoration: none;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .logo-title:hover {
            color: #ffe6f2;
            transform: scale(1.05);
        }

        .nav-custom {
            display: flex;
            align-items: center;
            flex-grow: 1;
            justify-content: center;
            gap: 3px;
        }

        .nav-custom a {
            margin: 0 5px;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            padding: 6px 14px;
            border-radius: 18px;
            font-size: 13px;
            position: relative;
        }

        .nav-custom a:hover {
            color: white;
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        .nav-custom a.active {
            background: rgba(255, 255, 255, 0.25);
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

        /* ======= CONTACT SECTION ======= */
        .contact-section {
            padding: 100px 0 80px;
            background: linear-gradient(135deg, #fffafc 0%, #ffffff 100%);
        }

        .contact-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        /* SỬA FONT CHỮ CHO TIẾNG VIỆT */
        .section-title {
            text-align: center;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 2.5rem;
            color: var(--dark-pink);
            margin-bottom: 0.5rem;
            position: relative;
            font-weight: 700;
        }

        .section-subtitle {
            text-align: center;
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 3rem;
            font-family: Arial, sans-serif;
        }

        .contact-card {
            background: white;
            border-radius: 25px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .contact-header {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        /* SỬA FONT CHỮ CHO TIẾNG VIỆT */
        .contact-header h3 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .contact-header p {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 0;
            font-family: Arial, sans-serif;
        }

        .contact-body {
            padding: 2.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-pink);
            margin-bottom: 0.5rem;
            font-family: Arial, sans-serif;
        }

        .form-control {
            border: 2px solid #f0f0f0;
            border-radius: 15px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            font-family: Arial, sans-serif;
        }

        .form-control:focus {
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 0.2rem rgba(122, 226, 255, 0.25);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--dark-pink) 100%);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 14px 40px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
            font-family: Arial, sans-serif;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 77, 166, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        .contact-info {
            background: linear-gradient(135deg, var(--light-pink) 0%, #ffe6f2 100%);
            border-radius: 20px;
            padding: 2.5rem;
            height: 100%;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 2rem;
        }

        .info-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--dark-blue) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .info-content h4 {
            color: var(--dark-pink);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-family: Arial, sans-serif;
        }

        .info-content p {
            color: #666;
            margin-bottom: 0;
            font-family: Arial, sans-serif;
        }

        /* ======= NOTIFICATION BOX ======= */
        .notification-box {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            max-width: 400px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: slideInRight 0.5s ease, slideOutRight 0.5s ease 4.5s forwards;
        }

        .notification-success {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
        }

        .notification-error {
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
        }

        .notification-content {
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notification-icon {
            font-size: 2rem;
            flex-shrink: 0;
        }

        .notification-text h4 {
            margin: 0 0 5px 0;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .notification-text p {
            margin: 0;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .notification-progress {
            height: 4px;
            background: rgba(255,255,255,0.3);
            width: 100%;
        }

        .notification-progress-bar {
            height: 100%;
            background: white;
            width: 100%;
            animation: progressBar 5s linear forwards;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        @keyframes progressBar {
            from {
                width: 100%;
            }
            to {
                width: 0%;
            }
        }

        /* ======= FOOTER ======= */
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

        /* ======= RESPONSIVE DESIGN ======= */
        @media (max-width: 768px) {
            .custom-header {
                padding: 0.4rem 1rem;
                height: auto;
                min-height: 55px;
            }
            
            .contact-section {
                padding: 80px 0 50px;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .contact-body {
                padding: 1.5rem;
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
            
            .notification-box {
                top: 80px;
                right: 10px;
                left: 10px;
                min-width: auto;
                max-width: none;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <!-- Notification Box -->
    <div id="notificationBox" class="notification-box" style="display: none;">
        <div class="notification-content">
            <div class="notification-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="notification-text">
                <h4 id="notificationTitle">Thành công!</h4>
                <p id="notificationMessage">Tin nhắn của bạn đã được gửi thành công.</p>
            </div>
        </div>
        <div class="notification-progress">
            <div class="notification-progress-bar"></div>
        </div>
    </div>

    <!-- CONTACT SECTION -->
    <section class="contact-section">
        <div class="container">
            <div class="contact-container">
                <h2 class="section-title">Liên Hệ Với Chúng Tôi</h2>
                <p class="section-subtitle">Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn</p>

                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="contact-card">
                            <div class="contact-header">
                                <h3><i class="fas fa-envelope me-2"></i>Gửi tin nhắn</h3>
                                <p>Điền thông tin và chúng tôi sẽ liên hệ lại với bạn</p>
                            </div>
                            <div class="contact-body">
                                <form id="contactForm" action="contact" method="post">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label" for="fullName">Họ và tên *</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" required placeholder="Nhập họ và tên của bạn">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label" for="phone">Số điện thoại *</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" required placeholder="Nhập số điện thoại">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="email">Email *</label>
                                        <input type="email" class="form-control" id="email" name="email" required placeholder="Nhập địa chỉ email">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="subject">Tiêu đề *</label>
                                        <input type="text" class="form-control" id="subject" name="subject" required placeholder="Nhập tiêu đề tin nhắn">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="message">Nội dung cần giải đáp *</label>
                                        <textarea class="form-control" id="message" name="message" required placeholder="Mô tả chi tiết vấn đề bạn cần hỗ trợ..."></textarea>
                                    </div>
                                    <button type="submit" class="btn-submit">
                                        <i class="fas fa-paper-plane me-2"></i>Gửi tin nhắn
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 mb-4">
                        <div class="contact-info">
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Địa chỉ</h4>
                                    <p>218 Lĩnh Nam<br>Quận Hoàng Mai, Hà Nội</p>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Điện thoại</h4>
                                    <p>0123.456.789<br>0987.654.321</p>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Email</h4>
                                    <p>hoangthaiduypl@gmail.com<br>support@kiddy.com</p>
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Thời gian làm việc</h4>
                                    <p>Thứ 2 - Thứ 6: 8:00 - 17:00<br>Thứ 7: 8:00 - 12:00</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <jsp:include page="Footer.jsp"></jsp:include>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Update cart count
            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('kiddyCart')) || [];
                const totalItems = cart.reduce((total, item) => total + item.quantity, 0);
                const cartCountElement = document.querySelector('.cart-count');
                if (cartCountElement) {
                    cartCountElement.textContent = totalItems;
                }
            }

            // Initialize cart count
            updateCartCount();

            // Show notification function
            function showNotification(type, title, message) {
                const notificationBox = document.getElementById('notificationBox');
                const notificationTitle = document.getElementById('notificationTitle');
                const notificationMessage = document.getElementById('notificationMessage');
                const notificationIcon = notificationBox.querySelector('.notification-icon i');
                
                // Set notification type
                notificationBox.className = 'notification-box notification-' + type;
                
                // Set content
                notificationTitle.textContent = title;
                notificationMessage.textContent = message;
                
                // Set icon based on type
                if (type === 'success') {
                    notificationIcon.className = 'fas fa-check-circle';
                } else {
                    notificationIcon.className = 'fas fa-exclamation-circle';
                }
                
                // Show notification
                notificationBox.style.display = 'block';
                
                // Auto hide after 5 seconds
                setTimeout(() => {
                    notificationBox.style.display = 'none';
                }, 5000);
            }

            // Contact form submission với AJAX
            document.getElementById('contactForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Get form data
                const formData = new FormData(this);

                // Basic client-side validation
                const fullName = document.getElementById('fullName').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const email = document.getElementById('email').value.trim();
                const subject = document.getElementById('subject').value.trim();
                const message = document.getElementById('message').value.trim();

                if (!fullName || !phone || !email || !subject || !message) {
                    showNotification('error', 'Lỗi', 'Vui lòng điền đầy đủ thông tin');
                    return;
                }

                // Validate email format
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    showNotification('error', 'Lỗi', 'Email không hợp lệ');
                    return;
                }

                // Show loading state
                const submitBtn = document.querySelector('.btn-submit');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
                submitBtn.disabled = true;

                // Send data to servlet using AJAX
                fetch('contact', {
                    method: 'POST',
                    body: new URLSearchParams(formData),
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        // Show success notification
                        showNotification('success', 'Thành công', data.message || 'Gửi yêu cầu thành công! Chúng tôi sẽ liên hệ lại với bạn sớm nhất.');
                        
                        // Reset form
                        document.getElementById('contactForm').reset();
                    } else {
                        showNotification('error', 'Lỗi', data.message || 'Không thể gửi tin nhắn');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showNotification('error', 'Lỗi', 'Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại.');
                })
                .finally(() => {
                    // Reset button state
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                });
            });
        });
    </script>
</body>
</html>