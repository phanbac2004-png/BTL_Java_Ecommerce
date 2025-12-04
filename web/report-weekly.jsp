<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo doanh thu theo tuần</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #FEF9FA;
            }
            .page-header {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .page-header h2 {
                color: #C2185B;
                font-weight: 700;
                margin-bottom: 0;
            }
            .filter-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .table-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .chart-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .table thead {
                background-color: #F06292;
                color: white;
            }
            .table tbody tr:hover {
                background-color: #FFF9FA;
            }
            .btn-kid {
                background-color: #EC407A;
                color: white;
                border: none;
                font-weight: 700;
                border-radius: 5px;
            }
            .btn-kid:hover {
                background-color: #C2185B;
                color: white;
            }
            .text-pink {
                color: #C2185B;
                font-weight: 700;
            }
            #revenueChart {
                max-height: 400px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid" style="padding: 20px;">
            <!-- Header -->
            <div class="page-header">
                <h2><i class="fas fa-chart-bar"></i> Báo cáo doanh thu theo tuần</h2>
                <p class="text-muted mb-0">Xem doanh thu từng tuần trong tháng</p>
            </div>

            <!-- Form chọn tháng/năm -->
            <div class="filter-card">
                <h5 class="mb-3"><i class="fas fa-calendar-alt"></i> Chọn tháng/năm</h5>
                <form method="GET" action="admin/report-weekly" class="form-inline">
                    <div class="form-group mr-3">
                        <label for="month" class="mr-2">Tháng:</label>
                        <select class="form-control" id="month" name="month" required>
                            <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>Tháng 1</option>
                            <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>Tháng 2</option>
                            <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>Tháng 3</option>
                            <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>Tháng 4</option>
                            <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>Tháng 5</option>
                            <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>Tháng 6</option>
                            <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>Tháng 7</option>
                            <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>Tháng 8</option>
                            <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>Tháng 9</option>
                            <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>Tháng 10</option>
                            <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>Tháng 11</option>
                            <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>Tháng 12</option>
                        </select>
                    </div>
                    <div class="form-group mr-3">
                        <label for="year" class="mr-2">Năm:</label>
                        <input type="number" class="form-control" id="year" name="year" 
                               min="2020" max="2100" value="${selectedYear}" required>
                    </div>
                    <button type="submit" class="btn btn-kid">
                        <i class="fas fa-search"></i> Xem báo cáo
                    </button>
                    <a href="adminrevenue" class="btn btn-secondary ml-2">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </form>
            </div>

            <!-- Bảng doanh thu -->
            <div class="table-card">
                <h5 class="mb-3"><i class="fas fa-table"></i> Doanh thu theo tuần - Tháng ${selectedMonth}/${selectedYear}</h5>
                <c:if test="${not empty weeklyRevenues}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Tuần</th>
                                    <th class="text-right">Doanh Thu</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${weeklyRevenues}" var="wr">
                                    <tr>
                                        <td>
                                            <strong>Tuần ${wr.weekNumber}</strong>
                                            <small class="text-muted d-block">
                                                <c:choose>
                                                    <c:when test="${wr.weekNumber == 1}">Ngày 1-7</c:when>
                                                    <c:when test="${wr.weekNumber == 2}">Ngày 8-14</c:when>
                                                    <c:when test="${wr.weekNumber == 3}">Ngày 15-21</c:when>
                                                    <c:when test="${wr.weekNumber == 4}">Ngày 22-28</c:when>
                                                    <c:when test="${wr.weekNumber == 5}">Ngày 29-31</c:when>
                                                </c:choose>
                                            </small>
                                        </td>
                                        <td class="text-right">
                                            <span class="text-pink">
                                                <fmt:formatNumber value="${wr.revenue}" type="number" pattern="#,###"/> đ
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr style="background-color: #FCE4EC;">
                                    <td><strong>Tổng cộng:</strong></td>
                                    <td class="text-right">
                                        <strong class="text-pink">
                                            <c:set var="total" value="0"/>
                                            <c:forEach items="${weeklyRevenues}" var="wr">
                                                <c:set var="total" value="${total + wr.revenue}"/>
                                            </c:forEach>
                                            <fmt:formatNumber value="${total}" type="number" pattern="#,###"/> đ
                                        </strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </c:if>
                <c:if test="${empty weeklyRevenues}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> Không có dữ liệu doanh thu cho tháng này.
                    </div>
                </c:if>
            </div>

            <!-- Biểu đồ -->
            <c:if test="${not empty weeklyRevenues}">
                <div class="chart-card">
                    <h5 class="mb-3"><i class="fas fa-chart-bar"></i> Biểu đồ doanh thu theo tuần</h5>
                    <canvas id="revenueChart"></canvas>
                </div>
            </c:if>
        </div>

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
        <script>
            <c:if test="${not empty weeklyRevenues}">
            // Chuẩn bị dữ liệu cho biểu đồ
            var weekLabels = [];
            var revenueData = [];
            
            <c:forEach items="${weeklyRevenues}" var="wr">
            weekLabels.push('Tuần ${wr.weekNumber}');
            revenueData.push(${wr.revenue});
            </c:forEach>
            
            // Tạo biểu đồ
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: weekLabels,
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: revenueData,
                        backgroundColor: [
                            'rgba(236, 64, 122, 0.8)',
                            'rgba(240, 98, 146, 0.8)',
                            'rgba(194, 24, 91, 0.8)',
                            'rgba(173, 20, 87, 0.8)',
                            'rgba(244, 143, 177, 0.8)'
                        ],
                        borderColor: [
                            'rgba(236, 64, 122, 1)',
                            'rgba(240, 98, 146, 1)',
                            'rgba(194, 24, 91, 1)',
                            'rgba(173, 20, 87, 1)',
                            'rgba(244, 143, 177, 1)'
                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    label += new Intl.NumberFormat('vi-VN').format(context.parsed.y) + ' đ';
                                    return label;
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
                                }
                            }
                        }
                    }
                }
            });
            </c:if>
        </script>
    </body>
</html>

