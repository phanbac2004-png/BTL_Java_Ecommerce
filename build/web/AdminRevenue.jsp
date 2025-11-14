<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê doanh thu - Admin</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="container mt-4">
            <h2 class="mb-4"><i class="fas fa-chart-line"></i> Revenue Statistics</h2>
            
            <!-- Form chọn ngày/tháng/năm cụ thể -->
            <div class="card mb-4">
                <div class="card-header bg-secondary text-white">
                    <h5><i class="fas fa-calendar-check"></i> Select Date</h5>
                </div>
                <div class="card-body">
                    <form method="GET" action="adminrevenue" class="form-inline">
                        <div class="form-group mr-3">
                            <label for="day" class="mr-2">Day:</label>
                            <input type="number" class="form-control" id="day" name="day" 
                                   min="1" max="31" value="${selectedDay}" placeholder="DD">
                        </div>
                        <div class="form-group mr-3">
                            <label for="month" class="mr-2">Month:</label>
                            <input type="number" class="form-control" id="month" name="month" 
                                   min="1" max="12" value="${selectedMonth}" placeholder="MM">
                        </div>
                        <div class="form-group mr-3">
                            <label for="year" class="mr-2">Year:</label>
                            <input type="number" class="form-control" id="year" name="year" 
                                   min="2020" max="2100" value="${selectedYear}" placeholder="YYYY">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> View Revenue
                        </button>
                        <c:if test="${not empty selectedDay && not empty selectedMonth && not empty selectedYear}">
                            <a href="adminrevenue" class="btn btn-secondary ml-2">
                                <i class="fas fa-times"></i> Clear
                            </a>
                        </c:if>
                    </form>
                    <c:if test="${customRevenue > 0}">
                        <div class="alert alert-info mt-3 mb-0">
                            <strong>Revenue for ${selectedDay}/${selectedMonth}/${selectedYear}:</strong> 
                            <fmt:formatNumber value="${customRevenue}" type="number" pattern="#,###"/> đ
                        </div>
                    </c:if>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="adminrevenue?period=today" class="text-decoration-none">
                        <div class="card bg-info text-white ${selectedPeriod == 'today' ? 'border border-dark' : ''}" style="cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                            <div class="card-body text-center">
                                <h5><i class="fas fa-calendar-day"></i> Today</h5>
                                <h3><fmt:formatNumber value="${revenueToday}" type="number" pattern="#,###"/> đ</h3>
                                <small>Click to view details</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="adminrevenue?period=week" class="text-decoration-none">
                        <div class="card bg-success text-white ${selectedPeriod == 'week' ? 'border border-dark' : ''}" style="cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                            <div class="card-body text-center">
                                <h5><i class="fas fa-calendar-week"></i> This Week</h5>
                                <h3><fmt:formatNumber value="${revenueThisWeek}" type="number" pattern="#,###"/> đ</h3>
                                <small>Click to view details</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="adminrevenue?period=month" class="text-decoration-none">
                        <div class="card bg-warning text-white ${selectedPeriod == 'month' ? 'border border-dark' : ''}" style="cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                            <div class="card-body text-center">
                                <h5><i class="fas fa-calendar-alt"></i> This Month</h5>
                                <h3><fmt:formatNumber value="${revenueThisMonth}" type="number" pattern="#,###"/> đ</h3>
                                <small>Click to view details</small>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="adminrevenue?period=year" class="text-decoration-none">
                        <div class="card bg-primary text-white ${selectedPeriod == 'year' ? 'border border-dark' : ''}" style="cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                            <div class="card-body text-center">
                                <h5><i class="fas fa-calendar"></i> This Year</h5>
                                <h3><fmt:formatNumber value="${revenueThisYear}" type="number" pattern="#,###"/> đ</h3>
                                <small>Click to view details</small>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="card bg-dark text-white">
                        <div class="card-body text-center">
                            <h4><i class="fas fa-dollar-sign"></i> Total Revenue (All Time)</h4>
                            <h2><fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,###"/> đ</h2>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card">
            <div class="card-header">
                <h5>
                    <c:choose>
                        <c:when test="${not empty selectedDay && not empty selectedMonth && not empty selectedYear}">
                            Order List - ${selectedDay}/${selectedMonth}/${selectedYear}
                        </c:when>
                        <c:when test="${selectedPeriod == 'today'}">Order List - Today</c:when>
                        <c:when test="${selectedPeriod == 'week'}">Order List - This Week</c:when>
                        <c:when test="${selectedPeriod == 'month'}">Order List - This Month</c:when>
                        <c:when test="${selectedPeriod == 'year'}">Order List - This Year</c:when>
                        <c:otherwise>Order List - All Orders</c:otherwise>
                    </c:choose>
                    <c:if test="${not empty selectedPeriod || (not empty selectedDay && not empty selectedMonth && not empty selectedYear)}">
                        <a href="adminrevenue" class="btn btn-sm btn-secondary ml-2">
                            <i class="fas fa-times"></i> Clear Filter
                        </a>
                    </c:if>
                </h5>
            </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>User ID</th>
                                <th>Order Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
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
                                        <span class="badge badge-${o.status == 'Pending' ? 'warning' : (o.status == 'Completed' ? 'success' : 'danger')}">
                                            ${o.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <a href="manager" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Back</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>

