<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    /* Nhập font Nunito */
    @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
    
    body {
        font-family: 'Nunito', sans-serif;
    }
    
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
    .content-card h5 {
        color: #C2185B;
        font-weight: 700;
    }
    
    /* Thẻ doanh thu */
    .revenue-card {
        border-radius: 15px;
        color: white;
        transition: transform 0.2s, box-shadow 0.2s;
        border: none;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        cursor: pointer;
    }
    .revenue-card:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }
    .revenue-card .card-body { padding: 20px; }
    .revenue-card h5 { color: white; font-weight: 700; }
    .revenue-card h3, .revenue-card h2 { color: white; font-weight: 800; }
    
    /* Gradient màu hồng */
    .kid-bg-1 { background: linear-gradient(135deg, #F8BBD0 0%, #F06292 100%); }
    .kid-bg-2 { background: linear-gradient(135deg, #F48FB1 0%, #EC407A 100%); }
    .kid-bg-3 { background: linear-gradient(135deg, #EC407A 0%, #C2185B 100%); }
    .kid-bg-4 { background: linear-gradient(135deg, #C2185B 0%, #AD1457 100%); }
    .kid-bg-dark { background: linear-gradient(135deg, #AD1457 0%, #880E4F 100%); }

    /* Nút chính (View) */
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

    /* Nút Hủy (Xám) */
    .btn-kid-secondary {
        background-color: #e0e0e0;
        border-color: #e0e0e0;
        color: #555;
        font-weight: 700;
        border-radius: 30px;
    }
    
    /* Hộp thông báo */
    .alert-kid {
        color: #AD1457;
        background-color: #FCE4EC;
        border-color: #F06292;
        border-radius: 10px;
        font-family: 'Nunito', sans-serif;
    }

    /* Tiêu đề bảng */
    .thead-kid {
        background-color: #F06292; /* Màu hồng chính */
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
    
    .form-control:focus {
        border-color: #F06292;
        box-shadow: 0 0 0 0.2rem rgba(236, 64, 122, 0.25);
    }
</style>
<div class="page-title">
    <i class="fas fa-chart-bar"></i>
    <span>Báo cáo doanh thu</span>
</div>

<div class="content-card mb-4">
    <h5 class="mb-3"><i class="fas fa-calendar-check"></i> Chọn ngày cụ thể</h5>
    <form method="GET" action="adminrevenue" class="form-inline">
        <div class="form-group mr-3">
            <label for="day" class="mr-2">Ngày:</label>
            <input type="number" class="form-control" id="day" name="day" 
                   min="1" max="31" value="${selectedDay}" placeholder="DD">
        </div>
        <div class="form-group mr-3">
            <label for="month" class="mr-2">Tháng:</label>
            <input type="number" class="form-control" id="month" name="month" 
                   min="1" max="12" value="${selectedMonth}" placeholder="MM">
        </div>
        <div class="form-group mr-3">
            <label for="year" class="mr-2">Năm:</label>
            <input type="number" class="form-control" id="year" name="year" 
                   min="2020" max="2100" value="${selectedYear}" placeholder="YYYY">
        </div>
        
        <button type="submit" class="btn btn-kid-cart">
            <i class="fas fa-search"></i> Xem
        </button>
        <c:if test="${not empty selectedDay && not empty selectedMonth && not empty selectedYear}">
            <a href="adminrevenue" class="btn btn-kid-secondary ml-2">
                <i class="fas fa-times"></i> Xóa
            </a>
        </c:if>
    </form>
    <script>
        // Auto-populate với ngày hôm nay nếu chưa có giá trị
        window.onload = function() {
            var dayInput = document.getElementById('day');
            var monthInput = document.getElementById('month');
            var yearInput = document.getElementById('year');
            
            if (dayInput && !dayInput.value) {
                var today = new Date();
                dayInput.value = today.getDate();
                monthInput.value = today.getMonth() + 1;
                yearInput.value = today.getFullYear();
            }
        };
    </script>
    <c:if test="${customRevenue > 0}">
        <div class="alert alert-kid mt-3 mb-0">
            <strong>Doanh thu ngày ${selectedDay}/${selectedMonth}/${selectedYear}:</strong> 
            <fmt:formatNumber value="${customRevenue}" type="number" pattern="#,###"/> đ
        </div>
    </c:if>
</div>

<div class="row mb-4">
    <div class="col-md-6 col-lg-3 mb-3">
        <a href="adminrevenue?period=today" class="text-decoration-none">
            <div class="card revenue-card kid-bg-1 ${selectedPeriod == 'today' ? 'border border-dark' : ''}">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar-day"></i> Hôm nay</h5>
                    <h3><fmt:formatNumber value="${revenueToday}" type="number" pattern="#,###"/> đ</h3>
                    <small>Bấm để xem chi tiết</small>
                </div>
            </div>
        </a>
    </div>
    <div class="col-md-6 col-lg-3 mb-3">
        <a href="adminrevenue?period=week" class="text-decoration-none">
            <div class="card revenue-card kid-bg-2 ${selectedPeriod == 'week' ? 'border border-dark' : ''}">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar-week"></i> Tuần này</h5>
                    <h3><fmt:formatNumber value="${revenueThisWeek}" type="number" pattern="#,###"/> đ</h3>
                    <small>Bấm để xem chi tiết</small>
                </div>
            </div>
        </a>
    </div>
    <div class="col-md-6 col-lg-3 mb-3">
        <a href="adminrevenue?period=month" class="text-decoration-none">
            <div class="card revenue-card kid-bg-3 ${selectedPeriod == 'month' ? 'border border-dark' : ''}">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar-alt"></i> Tháng này</h5>
                    <h3><fmt:formatNumber value="${revenueThisMonth}" type="number" pattern="#,###"/> đ</h3>
                    <small>Bấm để xem chi tiết</small>
                </div>
            </div>
        </a>
    </div>
    <div class="col-md-6 col-lg-3 mb-3">
        <a href="adminrevenue?period=year" class="text-decoration-none">
            <div class="card revenue-card kid-bg-4 ${selectedPeriod == 'year' ? 'border border-dark' : ''}">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar"></i> Năm này</h5>
                    <h3><fmt:formatNumber value="${revenueThisYear}" type="number" pattern="#,###"/> đ</h3>
                    <small>Bấm để xem chi tiết</small>
                </div>
            </div>
        </a>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-12">
        <div class="card revenue-card kid-bg-dark">
            <div class="card-body text-center">
                <h4><i class="fas fa-dollar-sign"></i> Tổng doanh thu (Tất cả)</h4>
                <h2><fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,###"/> đ</h2>
            </div>
        </div>
    </div>
</div>

<div class="content-card">
    <div class="card-header bg-transparent px-0 pb-3">
        <h5 class="mb-0">
            <c:choose>
                <c:when test="${not empty selectedDay && not empty selectedMonth && not empty selectedYear}">
                    Danh sách đơn hàng - ${selectedDay}/${selectedMonth}/${selectedYear}
                </c:when>
                <c:when test="${selectedPeriod == 'today'}">Danh sách đơn hàng - Hôm nay</c:when>
                <c:when test="${selectedPeriod == 'week'}">Danh sách đơn hàng - Tuần này</c:when>
                <c:when test="${selectedPeriod == 'month'}">Danh sách đơn hàng - Tháng này</c:when>
                <c:when test="${selectedPeriod == 'year'}">Danh sách đơn hàng - Năm này</c:when>
                <c:otherwise>Danh sách đơn hàng - Tất cả</c:otherwise>
            </c:choose>
            <c:if test="${not empty selectedPeriod || (not empty selectedDay && not empty selectedMonth && not empty selectedYear)}">
                <a href="adminrevenue" class="btn btn-sm btn-kid-secondary ml-2">
                    <i class="fas fa-times"></i> Xóa bộ lọc
                </a>
            </c:if>
        </h5>
    </div>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead class="thead-kid">
                <tr>
                    <th>Mã đơn</th>
                    <th>ID người dùng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listOrders}" var="o">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.accountID}</td>
                        <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,###"/> đ</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.status == 'Delivered' || o.status == 'Completed'}">
                                    <span class="badge badge-kid-success">${o.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-kid-processing">${o.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>