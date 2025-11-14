<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán | Kiddy</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
            /* Nhập font Nunito */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FEF9FA; /* Màu nền hồng rất nhạt */
            }
            
            /* Thẻ nội dung */
            .kid-card {
                background: white;
                border-radius: 15px; /* Bo tròn */
                box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
                margin-bottom: 20px;
                font-family: 'Nunito', sans-serif;
                border: none;
            }
            
            /* Tiêu đề thẻ chính */
            .kid-card-header {
                background-color: #F06292; /* Màu hồng chính */
                color: white;
                font-weight: 700;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }
            .kid-card-header h4 {
                font-weight: 700;
                margin-bottom: 0;
            }
            
            /* Tiêu đề thẻ phụ */
            .kid-card-header-light {
                background-color: #FCE4EC; /* Hồng nhạt */
                color: #C2185B; /* Hồng đậm */
                font-weight: 700;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }
            
            /* Nút chính (Đặt hàng) */
            .btn-kid-cart {
                background-color: #EC407A;
                color: white !important;
                border: none;
                font-weight: 700;
                border-radius: 30px; 
            }
            .btn-kid-cart:hover {
                background-color: #C2185B;
                color: white;
            }
            
            /* Nút "Quay lại" (Viền) */
            .btn-kid-outline {
                background-color: transparent;
                border: 2px solid #EC407A;
                color: #EC407A; /* Chữ hồng */
                font-weight: 700;
                border-radius: 30px;
                transition: all 0.2s;
            }
            .btn-kid-outline:hover {
                background-color: #EC407A;
                color: white;
            }
            
            /* Thông báo lỗi */
            .alert-kid-danger {
                color: #880E4F;
                background-color: #F8BBD0;
                border-color: #e91e63;
                border-radius: 10px;
            }
            
            /* Chữ "Tổng tiền" */
            .text-pink-dark {
                color: #C2185B; /* Màu hồng đậm */
                font-weight: 700;
            }
            
            .form-control:focus {
                border-color: #F06292;
                box-shadow: 0 0 0 0.2rem rgba(236, 64, 122, 0.25);
            }
            
            /* Thẻ phương thức thanh toán */
            .payment-card {
                border: 1px solid #FCE4EC;
                border-radius: 10px;
            }
            
            /* Viền hồng cho QR Code */
            .border-kid-pink {
                border-color: #F06292 !important;
                border-radius: 15px;
            }
            .border-kid-pink .card-title {
                color: #C2185B;
                font-weight: 700;
            }
            
            .img-thumbnail {
                border-radius: 10px;
                border-color: #FCE4EC;
            }
        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-8">
                    <div class="card kid-card">
                        <div class="card-header kid-card-header">
                            <h4><i class="fas fa-shipping-fast"></i> Thông tin giao hàng</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-kid-danger">${error}</div>
                            </c:if>
                            <form action="buy" method="POST">
                                <div class="form-group">
                                    <label for="phone"><strong>Số điện thoại *</strong></label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="Nhập số điện thoại" required 
                                           pattern="[0-9]{10,11}" title="Số điện thoại phải có 10-11 chữ số">
                                </div>
                                
                                <div class="form-group">
                                    <label for="address"><strong>Địa chỉ giao hàng *</strong></label>
                                    <textarea class="form-control" id="address" name="address" rows="3" 
                                              placeholder="Nhập địa chỉ giao hàng đầy đủ (Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)" required></textarea>
                                </div>
                                
                                <input type="hidden" name="total" value="${total}">
                                <input type="hidden" name="paymentMethod" id="paymentMethod" value="">
                                
                                <div class="form-group">
                                    <label><strong>Phương thức thanh toán *</strong></label>
                                    <div class="card mb-3 payment-card">
                                        <div class="card-body">
                                            <div class="form-check mb-3">
                                                <input class="form-check-input" type="radio" name="payment" id="cod" value="cod" checked>
                                                <label class="form-check-label" for="cod">
                                                    <i class="fas fa-hand-holding-usd"></i> <strong>Thanh toán khi nhận hàng (COD)</strong>
                                                    <br><small class="text-muted">Bạn sẽ thanh toán khi nhận được hàng</small>
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="payment" id="vnpay" value="vnpay">
                                                <label class="form-check-label" for="vnpay">
                                                    <i class="fas fa-credit-card"></i> <strong>Thanh toán bằng VNPay</strong>
                                                    <br><small class="text-muted">Thanh toán trực tuyến qua VNPay</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div id="vnpayQRCode" style="display: none; margin-top: 20px;">
                                        <div class="card border-kid-pink">
                                            <div class="card-body text-center">
                                                <h5 class="card-title mb-3">
                                                    <i class="fas fa-qrcode"></i> Quét mã QR để thanh toán
                                                </h5>
                                                <div class="d-flex justify-content-center mb-3">
                                                    <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                                                        <img id="qrImage" src="" alt="QR Code VNPay" 
                                                             style="width: 250px; height: 250px; display: block;">
                                                    </div>
                                                </div>
                                                <div class="d-flex justify-content-center align-items-center mb-2">
                                                    <img src="https://img.vietqr.io/image/TPBank/1903555129001/compact.png" 
                                                         alt="VIETQR" 
                                                         style="height: 30px; margin-right: 10px;" 
                                                         onerror="this.style.display='none';">
                                                    <img src="https://napas247.vn/wp-content/uploads/2021/09/napas-logo.png" 
                                                         alt="napas 247" 
                                                         style="height: 30px;" 
                                                         onerror="this.style.display='none';">
                                                </div>
                                                <p class="text-muted mb-0" style="font-size: 0.9em;">
                                                    <i class="fas fa-info-circle"></i> Sử dụng ứng dụng ngân hàng để quét mã và thanh toán
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <button type="submit" class="btn btn-kid-cart btn-lg btn-block" id="submitBtn">
                                        <i class="fas fa-check"></i> <span id="btnText">Xác nhận đặt hàng</span>
                                    </button>
                                </div>
                            </form>
                            <script>
                                // (JavaScript giữ nguyên)
                                function generateQRCode(amount) {
                                    var vietqrData = 'VNPAY_PAYMENT_' + amount + '_' + Date.now();
                                    qrUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=' + encodeURIComponent(vietqrData);
                                    return qrUrl;
                                }
                                
                                document.querySelectorAll('input[name="payment"]').forEach(function(radio) {
                                    radio.addEventListener('change', function() {
                                        var btnText = document.getElementById('btnText');
                                        var qrCodeDiv = document.getElementById('vnpayQRCode');
                                        var totalAmount = ${total};
                                        
                                        if (this.value === 'cod') {
                                            btnText.textContent = 'Xác nhận đặt hàng';
                                            qrCodeDiv.style.display = 'none';
                                        } else if (this.value === 'vnpay') {
                                            btnText.textContent = 'Đặt hàng thành công';
                                            qrCodeDiv.style.display = 'block';
                                            var qrUrl = generateQRCode(totalAmount);
                                            document.getElementById('qrImage').src = qrUrl;
                                        }
                                    });
                                });
                                
                                window.addEventListener('DOMContentLoaded', function() {
                                    var vnpayRadio = document.getElementById('vnpay');
                                    if (vnpayRadio && vnpayRadio.checked) {
                                        var qrCodeDiv = document.getElementById('vnpayQRCode');
                                        var totalAmount = ${total};
                                        qrCodeDiv.style.display = 'block';
                                        var qrUrl = generateQRCode(totalAmount);
                                        document.getElementById('qrImage').src = qrUrl;
                                    }
                                });
                                
                                document.querySelector('form').addEventListener('submit', function(e) {
                                    var paymentMethod = document.querySelector('input[name="payment"]:checked').value;
                                    document.getElementById('paymentMethod').value = paymentMethod;
                                    
                                    if (paymentMethod === 'cod') {
                                        if (!confirm('Xác nhận đặt hàng?')) {
                                            e.preventDefault();
                                            return false;
                                        }
                                    }
                                });
                            </script>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card kid-card">
                        <div class="card-header kid-card-header-light">
                            <h5>Tóm tắt đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-sm">
                                <tbody>
                                    <c:forEach items="${list}" var="o">
                                        <tr>
                                            <td>
                                                <img src="${o.product.image}" width="50" height="50" class="img-thumbnail">
                                            </td>
                                            <td>
                                                <small>${o.product.name}</small><br>
                                                <small class="text-muted">SL: ${o.amount}</small>
                                            </td>
                                            <td class="text-right">
                                                <small><fmt:formatNumber value="${o.product.price * o.amount}" type="number" pattern="#,###"/> đ</small>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2"><strong>Tổng cộng:</strong></td>
                                        <td class="text-right text-pink-dark"><strong><fmt:formatNumber value="${total}" type="number" pattern="#,###"/> đ</strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <a href="cart" class="btn btn-kid-outline btn-block mt-2">
                        <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
                    </a>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>