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
    
    /* Hình ảnh sản phẩm */
    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 10px; /* Bo tròn */
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

    /* Huy hiệu "Số lượng đã bán" */
    .badge-kid {
        background-color: #EC407A;
        color: white;
        font-size: 0.9em;
        padding: 5px 10px;
        border-radius: 10px;
    }

    /* Chữ "Doanh thu" */
    .text-pink-dark {
        color: #C2185B; /* Màu hồng đậm */
        font-weight: 700;
    }
    
    /* Hộp thông báo */
    .alert-kid {
        color: #AD1457;
        background-color: #FCE4EC;
        border-color: #F06292;
        border-radius: 10px;
        font-family: 'Nunito', sans-serif;
    }
</style>
<div class="page-title">
    <i class="fas fa-warehouse"></i>
    <span>Danh sách sản phẩm đã bán</span>
</div>

<c:if test="${empty list}">
    <div class="alert alert-kid">
        <i class="fas fa-info-circle"></i> Chưa có sản phẩm nào được mua.
    </div>
</c:if>

<c:if test="${not empty list}">
    <div class="content-card">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="thead-kid">
                    <tr>
                        <th>STT</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Size</th>
                        <th>Màu sắc</th>
                        <th>Giá</th>
                        <th>Số lượng đã bán</th>
                        <th>Doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="item" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                                <img src="${item.product.image}" alt="${item.product.name}" 
                                     class="product-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/placeholder-80.svg';">
                            </td>
                            <td>
                                <strong>${item.product.name}</strong>
                                <br>
                                <small class="text-muted">ID: ${item.product.id}</small>
                            </td>
                            <td>-</td>
                            <td>-</td>
                            <td>
                                <fmt:formatNumber value="${item.product.price}" 
                                                  type="number" 
                                                  pattern="#,###"/> đ
                            </td>
                            <td>
                                <span class="badge badge-kid">
                                    <i class="fas fa-shopping-cart"></i> ${item.totalSold}
                                </span>
                            </td>
                            <td>
                                <strong class="text-pink-dark">
                                    <fmt:formatNumber value="${item.totalRevenue}" 
                                                      type="number" 
                                                      pattern="#,###"/> đ
                                </strong>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="table-kid-footer">
                        <td colspan="6" class="text-right"><strong>TỔNG CỘNG:</strong></td>
                        <td>
                            <strong>
                                <c:set var="totalQuantity" value="0"/>
                                <c:forEach items="${list}" var="item">
                                    <c:set var="totalQuantity" value="${totalQuantity + item.totalSold}"/>
                                </c:forEach>
                                ${totalQuantity}
                            </strong>
                        </td>
                        <td>
                            <strong class="text-pink-dark">
                                <c:set var="totalRevenue" value="0"/>
                                <c:forEach items="${list}" var="item">
                                    <c:set var="totalRevenue" value="${totalRevenue + item.totalRevenue}"/>
                                </c:forEach>
                                <fmt:formatNumber value="${totalRevenue}" 
                                                  type="number" 
                                                  pattern="#,###"/> đ
                            </strong>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</c:if>