<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Hoá đơn #${orderID}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
        body { font-family: 'Nunito', sans-serif; background: white; color: #222; margin: 0; padding: 20px; }
        .invoice { max-width: 800px; margin: 0 auto; }
        .header { display: flex; gap: 20px; align-items: center; }
        .logo { width: 80px; height: 80px; object-fit: contain; border-radius: 8px; border: 1px solid #FCE4EC; }
        .shop-name { color: #C2185B; font-size: 20px; font-weight: 800; }
        .shop-info { font-size: 12px; color: #555; }
        .card { background: #fff; padding: 18px; margin-top: 12px; border-radius: 8px; }
        .row { display: flex; justify-content: space-between; gap: 12px; }
        .col { flex: 1; }
        table { width: 100%; border-collapse: collapse; margin-top: 12px; }
        th, td { padding: 10px; border: 1px solid #eee; text-align: left; }
        thead th { background: #F06292; color: white; }
        tfoot td { background: #FCE4EC; color: #AD1457; font-weight: 700; }
        .text-right { text-align: right; }
        .small { font-size: 12px; color: #666; }
        @media print {
            @page { size: A4; margin: 15mm; }
            body { margin: 0; }
            .invoice { max-width: 100%; }
        }
    </style>
</head>
<body>
    <div class="invoice">
        <div class="header">
            <div>
                <c:choose>
                    <c:when test="${not empty listProducts and listProducts[0] != null and not empty listProducts[0].image}">
                        <img src="${listProducts[0].image}" class="logo" alt="logo">
                    </c:when>
                    <c:otherwise>
                        <div style="width:80px;height:80px;background:#FCE4EC;border-radius:8px;
                                    display:flex;align-items:center;justify-content:center;color:#C2185B;font-weight:700;">FS</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <div class="shop-name">FinalShop</div>
                <div class="shop-info">Địa chỉ: Số 1 Đường A, Quận B, TP. HCM<br/>Điện thoại: 0123 456 789 | Email: info@finalshop.local</div>
            </div>
        </div>

        <div class="card">
            <h3 style="color:#C2185B;margin:0 0 8px 0;">Hoá đơn</h3>
            <div class="row small">
                <div class="col">
                    <div><strong>Mã đơn:</strong> #${order.id}</div>
                    <div><strong>Ngày:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                    <div><strong>Điện thoại:</strong> ${order.phone}</div>
                </div>
                <div class="col">
                    <div><strong>Địa chỉ giao hàng:</strong> ${order.address}</div>
                    <div><strong>Phương thức:</strong> ${order.status}</div>
                    <div><strong>Trạng thái:</strong> ${order.status}</div>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th style="width:70px">Hình</th>
                        <th>Sản phẩm</th>
                        <th style="width:80px">SL</th>
                        <th style="width:120px">Đơn giá</th>
                        <th style="width:120px">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listOD}" var="od" varStatus="loop">
                        <tr>
                            <td style="text-align:center;vertical-align:middle;">
                                <c:choose>
                                    <c:when test="${not empty listProducts and listProducts[loop.index] != null and not empty listProducts[loop.index].image}">
                                        <img src="${listProducts[loop.index].image}" style="max-width:60px;max-height:60px;object-fit:cover;border-radius:6px;" alt="">
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="vertical-align:middle;">${listProducts[loop.index].name}</td>
                            <td style="vertical-align:middle;">${od.amount}</td>
                            <td style="vertical-align:middle;" class="text-right"><fmt:formatNumber value="${od.price}" type="number" pattern="#,###"/> đ</td>
                            <td style="vertical-align:middle;" class="text-right"><fmt:formatNumber value="${od.price * od.amount}" type="number" pattern="#,###"/> đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="text-right">Tổng cộng:</td>
                        <td class="text-right"><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> đ</td>
                    </tr>
                </tfoot>
            </table>

            <div style="margin-top:16px;text-align:center;color:#666;">Cảm ơn quý khách đã mua hàng tại FinalShop!</div>
        </div>
    </div>

    <script>
        // Auto open print dialog when page loads
        window.onload = function() {
            // give a short delay for images to load
            setTimeout(function(){
                window.print();
            }, 400);
        };
    </script>
</body>
</html>
