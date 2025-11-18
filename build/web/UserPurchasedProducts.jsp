<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách đơn hàng đã mua</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
            /* Nhập font Nunito */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FEF9FA; /* Màu nền hồng rất nhạt */
            }
            
            /* Tiêu đề trang */
            .admin-title {
                color: #C2185B; /* Màu hồng đậm */
                font-family: 'Nunito', sans-serif;
                font-size: 28px;
                font-weight: 800;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            /* Thẻ nội dung */
            .kid-card {
                background: white;
                border-radius: 15px; /* Bo tròn */
                padding: 25px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
                margin-bottom: 20px;
                font-family: 'Nunito', sans-serif;
            }
            .kid-card h5 {
                color: #C2185B;
                font-weight: 700;
            }
            
            /* Tiêu đề bảng */
            .thead-kid {
                background-color: #F06292; /* Màu hồng chính */
                color: white;
            }
            
            /* Chân bảng */
            .table-kid-footer {
                background-color: #FCE4EC; /* Màu hồng nhạt */
                color: #AD1457; /* Chữ hồng đậm */
                font-weight: 700;
            }
            
            /* Chữ "Tổng tiền" */
            .text-pink-dark {
                color: #C2185B; /* Màu hồng đậm */
                font-weight: 700;
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

            /* Trạng thái "Đã giao hàng" */
            .badge-kid-success {
                font-size: 14px;
                padding: 8px 12px;
                background-color: #A5D6A7; /* Xanh lá nhạt */
                color: #2E7D32; /* Xanh lá đậm */
                border-radius: 10px;
            }
            
            /* Trạng thái "Đang xử lí" / "COD" */
            .badge-kid-processing {
                font-size: 14px;
                padding: 8px 12px;
                background-color: #FCE4EC; /* Hồng nhạt */
                color: #AD1457; /* Hồng đậm */
                border-radius: 10px;
            }
            
            .img-thumbnail {
                border-radius: 10px;
                border: 1px solid #FCE4EC;
                width: 80px;
                height: 80px;
                object-fit: cover;
            }

            /* Variant badges */
            .variant-badge {
                display: inline-block;
                background: #FCE4EC;
                color: #C2185B;
                border-radius: 12px;
                padding: 4px 8px;
                font-weight: 700;
                font-size: 0.9em;
                margin-right: 6px;
            }
            .variant-badge--muted { background:#FFF0F6; color:#AD1457; font-weight:600; }
            
            /* Hộp thông báo */
            .alert-kid {
                color: #AD1457;
                background-color: #FCE4EC;
                border-color: #F06292;
                border-radius: 10px;
            }
            .alert-kid a {
                color: #C2185B;
                font-weight: 700;
                text-decoration: underline;
            }
            
            /* Khoảng cách giữa các đơn hàng */
            .order-separator {
                margin-bottom: 30px;
            }
        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container mt-4">
            
            <h2 class="mb-4 admin-title"><i class="fas fa-shopping-bag"></i> Danh sách đơn hàng đã mua</h2>
            
            <c:if test="${empty orderList}">
                <div class="alert alert-kid">
                    <i class="fas fa-info-circle"></i> Bạn chưa có đơn hàng nào.
                    <a href="home" class="alert-link">Tiếp tục mua sắm</a>
                </div>
            </c:if>
            
            <c:if test="${not empty orderList}">
                <c:forEach items="${orderList}" var="orderWithDetails" varStatus="orderLoop">
                    <div class="order-separator">
                        <!-- Thông tin đơn hàng -->
                        <div class="kid-card mb-3">
                            <div class="card-body">
                                <h5><i class="fas fa-receipt"></i> Đơn hàng #${orderWithDetails.order.id}</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Mã đơn:</strong> #${orderWithDetails.order.id}</p>
                                        <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${orderWithDetails.order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                        <p><strong>Số điện thoại:</strong> ${orderWithDetails.order.phone}</p>
                                        <p><strong>Địa chỉ:</strong> ${orderWithDetails.order.address}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Tổng tiền:</strong> <span class="text-pink-dark font-weight-bold"><fmt:formatNumber value="${orderWithDetails.order.totalPrice}" type="number" pattern="#,###"/> đ</span></p>
                                        <p><strong>Trạng thái:</strong> 
                                            <c:choose>
                                                <c:when test="${orderWithDetails.order.status == 'Delivered'}">
                                                    <span class="badge badge-kid-success">Đã giao hàng</span>
                                                </c:when>
                                                <c:when test="${orderWithDetails.order.status == 'Processing'}">
                                                    <span class="badge badge-kid-processing">Đang xử lí</span>
                                                </c:when>
                                                <c:when test="${orderWithDetails.order.status == 'Completed'}">
                                                    <span class="badge badge-kid-success">Hoàn thành</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-kid-processing">${orderWithDetails.order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p><strong>Phương thức thanh toán:</strong>
                                            <c:choose>
                                                <c:when test="${orderWithDetails.order.paymentMethod == 'vnpay'}">
                                                    <span class="badge badge-kid-success">
                                                        <i class="fas fa-credit-card"></i> Đã chuyển khoản (VNPay)
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-kid-processing">
                                                        <i class="fas fa-hand-holding-usd"></i> Thanh toán khi nhận hàng (COD)
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Danh sách sản phẩm trong đơn hàng -->
                        <div class="kid-card">
                            <div class="card-header bg-transparent px-0">
                                <h5><i class="fas fa-list"></i> Danh sách sản phẩm</h5>
                            </div>
                            <div class="card-body px-0">
                                <table class="table table-striped">
                                    <thead class="thead-kid">
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Số lượng</th>
                                            <th>Đơn giá</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orderWithDetails.details}" var="detail">
                                            <tr>
                                                <td>
                                                           <c:choose>
                                                               <c:when test="${not empty detail.product.image and (fn:startsWith(detail.product.image,'/') or fn:startsWith(detail.product.image,'http'))}">
                                                                   <c:set var="imgUrl" value="${detail.product.image}" />
                                                               </c:when>
                                                               <c:otherwise>
                                                                   <c:set var="imgUrl" value="${pageContext.request.contextPath}/${detail.product.image}" />
                                                               </c:otherwise>
                                                           </c:choose>
                                                           <img src="${imgUrl}" alt="${detail.product.name}" 
                                                                class="img-thumbnail" 
                                                                onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/placeholder-80.svg';">
                                                </td>
                                                <td>
                                                    <strong>${detail.product.name}</strong>
                                                    <br>
                                                    <small class="text-muted">
                                                        <c:choose>
                                                            <c:when test="${not empty detail.variant}">
                                                                <c:if test="${not empty detail.variant.colorName}">
                                                                    <span class="variant-badge" title="Màu: ${detail.variant.colorName}">${detail.variant.colorName}</span>
                                                                </c:if>
                                                                <c:if test="${not empty detail.variant.sizeName}">
                                                                    <span class="variant-badge variant-badge--muted" title="Size: ${detail.variant.sizeName}">${detail.variant.sizeName}</span>
                                                                </c:if>
                                                            </c:when>
                                                            <c:otherwise>ID: ${detail.product.id}</c:otherwise>
                                                        </c:choose>
                                                    </small>
                                                </td>
                                                <td>${detail.orderDetail.amount}</td>
                                                <td><fmt:formatNumber value="${detail.orderDetail.price}" type="number" pattern="#,###"/> đ</td>
                                                <td><fmt:formatNumber value="${detail.orderDetail.price * detail.orderDetail.amount}" type="number" pattern="#,###"/> đ</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr class="table-kid-footer">
                                            <td colspan="4" class="text-right"><strong>Tổng cộng:</strong></td>
                                            <td><strong class="text-pink-dark"><fmt:formatNumber value="${orderWithDetails.order.totalPrice}" type="number" pattern="#,###"/> đ</strong></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            
            <div class="mt-3">
                <a href="home" class="btn btn-kid-outline">
                    <i class="fas fa-arrow-left"></i> Quay lại Shop
                </a>
            </div>
            <!-- Include Footer -->
            <jsp:include page="Footer.jsp"></jsp:include>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>