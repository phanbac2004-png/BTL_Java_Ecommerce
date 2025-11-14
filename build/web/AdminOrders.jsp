<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách đơn hàng - Admin</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="container mt-4">
            <h2 class="mb-4"><i class="fas fa-shopping-bag"></i> Danh sách đơn hàng</h2>
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
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
                                    <td>#${o.id}</td>
                                    <td>${o.accountID}</td>
                                    <td>${o.phone}</td>
                                    <td><small>${o.address}</small></td>
                                    <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><fmt:formatNumber value="${o.totalPrice}" type="number" pattern="#,###"/> đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.status == 'Delivered'}">
                                                <span class="badge badge-success" style="font-size: 14px; padding: 8px 12px; min-width: 140px; display: inline-block;">
                                                    <i class="fas fa-check-circle"></i> <strong>Đã giao hàng</strong>
                                                </span>
                                            </c:when>
                                            <c:when test="${o.status == 'Processing'}">
                                                <span class="badge badge-info" style="font-size: 14px; padding: 8px 12px; min-width: 140px; display: inline-block; background-color: #17a2b8;">
                                                    <i class="fas fa-spinner fa-spin"></i> <strong>Đang xử lí</strong>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning" style="font-size: 14px; padding: 8px 12px; min-width: 140px; display: inline-block;">
                                                    <i class="fas fa-clock"></i> <strong>Đang xử lí</strong>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="orderdetail?oid=${o.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                        <c:if test="${o.status == 'Processing'}">
                                            <a href="updateorderstatus?oid=${o.id}&status=Delivered" 
                                               class="btn btn-sm btn-success ml-1" 
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
            <a href="manager" class="btn btn-secondary mt-3">← Quay lại</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>

