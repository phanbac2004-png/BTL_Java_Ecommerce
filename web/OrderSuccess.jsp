<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt hàng thành công</title>
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
                padding: 30px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
                margin-top: 20px;
                font-family: 'Nunito', sans-serif;
                border: 2px solid #F06292; /* Viền hồng */
            }

            .success-icon-kid {
                font-size: 80px;
                color: #F06292; /* Màu hồng chính */
                margin-bottom: 20px;
            }
            
            .text-pink-dark {
                color: #C2185B; /* Màu hồng đậm */
                font-weight: 700;
            }

            .product-image-kid {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 10px;
                border: 1px solid #FCE4EC;
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

            /* Badge "Đã giao hàng" */
            .badge-kid-success {
                font-size: 14px;
                padding: 8px 12px;
                background-color: #A5D6A7; /* Xanh lá nhạt */
                color: #2E7D32; /* Xanh lá đậm */
                border-radius: 10px;
            }
            
            /* Badge "Đang xử lí" */
            .badge-kid-processing {
                font-size: 14px;
                padding: 8px 12px;
                background-color: #FCE4EC; /* Hồng nhạt */
                color: #AD1457; /* Hồng đậm */
                border-radius: 10px;
            }
            
            /* Badge "Số lượng" */
            .badge-kid {
                background-color: #EC407A;
                color: white;
                font-size: 0.9em;
                padding: 5px 10px;
                border-radius: 10px;
            }
            
            /* Nút chính (Tiếp tục) */
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
            
            /* Nút "Quản lý" (Viền) */
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
        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="text-center kid-card">
                        
                        <i class="fas fa-check-circle success-icon-kid"></i>
                        
                        <h1 class="text-pink-dark mb-3">${not empty successMessage ? successMessage : 'Đặt hàng thành công!'}</h1>
                        
                        <c:choose>
                            <c:when test="${paymentMethod == 'cod'}">
                                <p class="lead">Đơn hàng của bạn đã được xác nhận. Bạn sẽ thanh toán khi nhận hàng.</p>
                            </c:when>
                            <c:when test="${paymentMethod == 'vnpay'}">
                                <p class="lead">Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được ghi nhận.</p>
                            </c:when>
                            <c:otherwise>
                                <p class="lead">Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được ghi nhận.</p>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="mt-4">
                            <h4>Thông tin đơn hàng</h4>
                            <p><strong>Mã đơn hàng:</strong> #${order.id}</p>
                            <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                            <p><strong>Số điện thoại:</strong> ${order.phone}</p>
                            <p><strong>Địa chỉ giao hàng:</strong> ${order.address}</p>
                            <p><strong>Tổng tiền:</strong> <span class="text-pink-dark font-weight-bold"><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> đ</span></p>
                            <p><strong>Trạng thái:</strong> 
                                
                                <c:choose>
                                    <c:when test="${order.status == 'Delivered'}">
                                        <span class="badge badge-kid-success">Đã giao hàng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-kid-processing">Đang xử lí</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        
                        <hr class="my-4">
                        
                        <h5 class="mb-3"><i class="fas fa-list"></i> Chi tiết đơn hàng:</h5>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="thead-kid">
                                    <tr>
                                        <th>STT</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listOD}" var="od" varStatus="loop">
                                        <tr>
                                            <td><strong>${loop.index + 1}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty listProducts[loop.index].image and (fn:startsWith(listProducts[loop.index].image,'/') or fn:startsWith(listProducts[loop.index].image,'http'))}">
                                                        <c:set var="imgUrl" value="${listProducts[loop.index].image}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="imgUrl" value="${pageContext.request.contextPath}/${listProducts[loop.index].image}" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <img src="${imgUrl}"
                                                     alt="${listProducts[loop.index].name}"
                                                     class="product-image-kid"
                                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/placeholder-80.svg';">
                                            </td>
                                            <td>
                                                <strong>${listProducts[loop.index].name}</strong>
                                                <br>
                                                <small class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${not empty listVariants and not empty listVariants[loop.index]}">
                                                            <c:if test="${not empty listVariants[loop.index].colorName}">
                                                                <span class="variant-badge" title="Màu: ${listVariants[loop.index].colorName}">${listVariants[loop.index].colorName}</span>
                                                            </c:if>
                                                            <c:if test="${not empty listVariants[loop.index].sizeName}">
                                                                <span class="variant-badge variant-badge--muted" title="Size: ${listVariants[loop.index].sizeName}">${listVariants[loop.index].sizeName}</span>
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ID: ${listProducts[loop.index].id}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${od.price}" type="number" pattern="#,###"/> đ
                                            </td>
                                            <td>
                                                <span class="badge badge-kid">
                                                    <i class="fas fa-shopping-cart"></i> ${od.amount}
                                                </span>
                                            </td>
                                            <td>
                                                <strong class="text-pink-dark">
                                                    <fmt:formatNumber value="${od.price * od.amount}" type="number" pattern="#,###"/> đ
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
                                                <c:forEach items="${listOD}" var="od">
                                                    <c:set var="totalQuantity" value="${totalQuantity + od.amount}"/>
                                                </c:forEach>
                                                ${totalQuantity}
                                            </strong>
                                        </td>
                                        <td>
                                            <strong class="text-pink-dark">
                                                <fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> đ
                                            </strong>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <div class="mt-4">
                            <a href="home" class="btn btn-kid-cart btn-lg">
                                <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                            </a>
                            <c:if test="${sessionScope.acc.isAdmin == 1}">
                                <a href="adminorders" class="btn btn-kid-outline btn-lg ml-2">
                                    <i class="fas fa-list"></i> Xem quản lý đơn hàng
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>