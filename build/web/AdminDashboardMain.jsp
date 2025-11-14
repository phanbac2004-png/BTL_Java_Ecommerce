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
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .page-subtitle {
        font-family: 'Nunito', sans-serif;
        color: #6c757d;
        font-size: 14px;
        margin-bottom: 30px;
    }

    /* Thẻ thống kê */
    .metrics-card {
        background: white;
        border-radius: 15px; /* Bo tròn */
        padding: 25px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* Đổ bóng */
        transition: transform 0.3s, box-shadow 0.3s;
        height: 100%;
        font-family: 'Nunito', sans-serif;
    }
    
    .metrics-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(236, 64, 122, 0.15); /* Đổ bóng hồng khi hover */
    }
    
    /* Biểu tượng (Icon) */
    .metric-icon {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 26px; /* Tăng kích thước icon */
        color: white;
        margin-bottom: 15px;
    }
    
    /* [NÂNG CẤP]: Sử dụng Gradient (chuyển màu) */
    .icon-kid-1 {
        background: linear-gradient(135deg, #F8BBD0 0%, #F06292 100%);
    }
    .icon-kid-2 {
        background: linear-gradient(135deg, #F48FB1 0%, #EC407A 100%);
    }
    .icon-kid-3 {
        background: linear-gradient(135deg, #EC407A 0%, #C2185B 100%);
    }
    .icon-kid-4 {
        background: linear-gradient(135deg, #C2185B 0%, #AD1457 100%);
    }
    
    /* [NÂNG CẤP]: Số liệu (Con số) - To hơn, đậm hơn */
    .metric-value {
        font-size: 38px;
        font-weight: 800;
        color: #AD1457; /* Màu hồng đậm nhất */
        margin: 10px 0;
    }
    
    /* [NÂNG CẤP]: Tiêu đề (Label) - Mảnh hơn để làm nổi bật số */
    .metric-label {
        font-size: 14px;
        color: #6c757d; /* Màu xám nhạt */
        font-weight: 500;
    }
</style>
<div class="page-title">
    <i class="fas fa-chart-line"></i>
    <span>Dashboard</span>
</div>
<div class="page-subtitle">Tổng quan về hoạt động cửa hàng</div>

<div class="row">
    <div class="col-md-6 col-lg-3 mb-4">
        <div class="metrics-card">
            <div class="metric-icon icon-kid-1">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="metric-value">${newOrdersCount}</div>
            <div class="metric-label">Đơn hàng mới</div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3 mb-4">
        <div class="metrics-card">
            <div class="metric-icon icon-kid-2">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="metric-value">
                <fmt:formatNumber value="${monthlyRevenue}" type="number" pattern="#,###"/> đ
            </div>
            <div class="metric-label">Doanh thu tháng</div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3 mb-4">
        <div class="metrics-card">
            <div class="metric-icon icon-kid-3">
                <i class="fas fa-box"></i>
            </div>
            <div class="metric-value">${totalProducts}</div>
            <div class="metric-label">Sản phẩm</div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3 mb-4">
        <div class="metrics-card">
            <div class="metric-icon icon-kid-4">
                <i class="fas fa-users"></i>
            </div>
            <div class="metric-value">${totalCustomers}</div>
            <div class="metric-label">Khách hàng</div>
        </div>
    </div>
</div>