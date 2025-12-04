<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn hàng #${orderID}</title>
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
            }
            /* Print-friendly adjustments */
            @media print {
                body { background: white !important; }
                .kid-card { box-shadow: none !important; border-radius: 0 !important; }
                .admin-title i { display: none; }
                a.btn { display: none !important; } /* hide buttons when printing the page */
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
            
        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container mt-4">
            
            <h2 class="mb-4 admin-title"><i class="fas fa-list"></i> Chi tiết đơn hàng #${orderID}</h2>
            
            <c:if test="${order != null}">
                <div class="kid-card mb-3">
                    <div class="card-body">
                        <h5>Thông tin đơn hàng</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Mã đơn:</strong> #${order.id}</p>
                                <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                <p><strong>Số điện thoại:</strong> ${order.phone}</p>
                                <p><strong>Địa chỉ:</strong> ${order.address}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Tổng tiền:</strong> <span class="text-pink-dark font-weight-bold"><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> đ</span></p>
                                <p><strong>Trạng thái:</strong> 
                                    <c:choose>
                                        <c:when test="${order.status == 'Delivered'}">
                                            <span class="badge badge-kid-success">Đã giao hàng</span>
                                        </c:when>
                                        <c:when test="${order.status == 'Processing'}">
                                            <span class="badge badge-kid-processing">Đang xử lí</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-kid-processing">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p><strong>Phương thức thanh toán:</strong>
                                    <c:choose>
                                        <c:when test="${order.paymentMethod == 'vnpay'}">
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
            </c:if>
            
            <div class="kid-card">
                <div class="card-header bg-transparent px-0">
                    <h5>Danh sách sản phẩm</h5>
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
                            <c:if test="${not empty listOD && not empty listProducts}">
                                <c:forEach items="${listOD}" var="od" varStatus="loop">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty listProducts[loop.index].image and (fn:startsWith(listProducts[loop.index].image,'/') or fn:startsWith(listProducts[loop.index].image,'http'))}">
                                                    <c:set var="imgUrl" value="${listProducts[loop.index].image}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="imgUrl" value="${pageContext.request.contextPath}/${listProducts[loop.index].image}" />
                                                </c:otherwise>
                                            </c:choose>
                                            <img src="${imgUrl}" width="80" height="80" class="img-thumbnail" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/placeholder-80.svg';">
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
                                                    <c:otherwise>ID: ${listProducts[loop.index].id}</c:otherwise>
                                                </c:choose>
                                            </small>
                                        </td>
                                        <td>${od.amount}</td>
                                        <td><fmt:formatNumber value="${od.price}" type="number" pattern="#,###"/> đ</td>
                                        <td><fmt:formatNumber value="${od.price * od.amount}" type="number" pattern="#,###"/> đ</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty listOD || empty listProducts}">
                                <!-- Hiển thị dữ liệu mẫu khi không có dữ liệu thật -->
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/images/placeholder-80.svg" width="80" height="80" class="img-thumbnail" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/placeholder-80.svg';"></td>
                                    <td>
                                        <strong>Áo thun Kiddy mẫu</strong><br>
                                        <small class="text-muted">
                                            <span class="variant-badge">Màu mẫu</span>
                                            <span class="variant-badge variant-badge--muted">Size mẫu</span>
                                        </small>
                                    </td>
                                    <td>2</td>
                                    <td>120,000 đ</td>
                                    <td>240,000 đ</td>
                                </tr>
                            </c:if>
                        </tbody>
                        <c:if test="${order != null}">
                            <tfoot>
                                <tr class="table-kid-footer">
                                    <td colspan="4" class="text-right"><strong>Tổng cộng:</strong></td>
                                    <td><strong><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> đ</strong></td>
                                </tr>
                            </tfoot>
                        </c:if>
                    </table>
                </div>
            </div>
            
            <a href="adminorders" class="btn btn-kid-outline mt-3">← Quay lại</a>
            <!-- Print invoice (HTML) -->
            <a href="invoiceprint?oid=${orderID}" target="_blank" class="btn btn-success mt-3 ml-2">In hoá đơn (HTML)</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>