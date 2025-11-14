<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    /* Tiêu đề trang */
    .page-title {
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
    .content-card {
        background: white;
        border-radius: 15px; /* Bo tròn */
        padding: 25px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
        margin-bottom: 20px;
        font-family: 'Nunito', sans-serif;
    }
    
    /* Tiêu đề bảng */
    .thead-kid {
        background-color: #F06292; /* Màu hồng chính */
        color: white;
    }
    
    /* Nút chính (Đã giao) */
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
    
    /* Nút Xem (Viền) */
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
        min-width: 140px;
        display: inline-block;
        background-color: #A5D6A7; /* Xanh lá nhạt */
        color: #2E7D32; /* Xanh lá đậm */
        border-radius: 10px;
    }
    
    /* Trạng thái "Đang xử lí" */
    .badge-kid-processing {
        font-size: 14px;
        padding: 8px 12px;
        min-width: 140px;
        display: inline-block;
        background-color: #FCE4EC; /* Hồng nhạt */
        color: #AD1457; /* Hồng đậm */
        border-radius: 10px;
    }

</style>
<div class="page-title">
    <i class="fas fa-shopping-bag"></i>
    <span>Danh sách đơn hàng</span>
</div>

<div class="content-card">
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="thead-kid">
                <tr>
                    <th>Mã đơn</th>
                    <th>ID người dùng</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="o">
                    <tr>
                        <td><strong>#${o.id}</strong></td>
                        <td>${o.accountID}</td>
                        <td>${o.phone}</td>
                        <td><small>${o.address}</small></td>
                        <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td><strong><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,###"/> đ</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${o.status == 'Delivered'}">
                                    <span class="badge badge-kid-success">
                                        <i class="fas fa-check-circle"></i> <strong>Đã giao hàng</strong>
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'Processing'}">
                                    <span class="badge badge-kid-processing">
                                        <i class="fas fa-spinner fa-spin"></i> <strong>Đang xử lí</strong>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-kid-processing">
                                        <i class="fas fa-clock"></i> <strong>Đang xử lí</strong>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="orderdetail?oid=${o.id}" class="btn btn-sm btn-kid-outline">
                                <i class="fas fa-eye"></i> Xem
                            </a>
                            <c:if test="${o.status == 'Processing'}">
                                <a href="updateorderstatus?oid=${o.id}&status=Delivered" 
                                   class="btn btn-sm btn-kid-cart ml-1" 
                                   onclick="return confirm('Xác nhận đơn hàng #${o.id} đã được giao hàng?')">
                                    <i class="fas fa-check"></i> Đã giao
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>