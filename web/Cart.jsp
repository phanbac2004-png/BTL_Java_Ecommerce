<%-- 
    Document   : Cart
    Created on : Oct 31, 2020, 9:42:21 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng | Kiddy</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
            /* Nhập font Nunito */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FEF9FA; /* Màu nền hồng rất nhạt */
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
            
            /* Nút +/- */
            .btnSub, .btnAdd {
                background-color: #FCE4EC;
                color: #C2185B;
                border: none;
                border-radius: 50%; /* Nút tròn */
                font-weight: 800;
                width: 30px;
                height: 30px;
                cursor: pointer;
                transition: background-color 0.2s;
            }
            .btnSub:hover, .btnAdd:hover {
                background-color: #F06292;
                color: white;
            }
            
            /* Nút Xóa (Đỏ/Hồng) */
            .btn-kid-danger {
                background-color: #e91e63; /* Màu hồng đỏ */
                border-color: #e91e63;
                color: white;
                font-weight: 700;
                border-radius: 30px;
            }
            .btn-kid-danger:hover {
                background-color: #c2185b;
                border-color: #c2185b;
                color: white;
            }
            
            /* Nút chính (Mua hàng, Sử dụng) */
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
            
            /* Tiêu đề Voucher/Thành tiền */
            .kid-header-pill {
                background-color: #FCE4EC;
                color: #C2185B;
                font-weight: 800;
                border-radius: 30px;
                padding: 0.75rem 1.5rem;
                font-size: 1.1rem;
            }
            
            /* Link tên sản phẩm */
            .product-link {
                color: #C2185B !important;
                font-weight: 700;
                text-decoration: none;
            }
            .product-link:hover {
                color: #EC407A !important;
            }
            
            /* Giá tiền */
            .product-price {
                color: #AD1457;
                font-weight: 700;
                font-size: 1.1rem;
            }
            
            /* Tổng thanh toán */
            .total-price {
                color: #C2185B;
                font-weight: 800;
            }
            
            .form-control:focus {
                border-color: #F06292;
                box-shadow: 0 0 0 0.2rem rgba(236, 64, 122, 0.25);
            }
        </style>
        </head>

    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="container mt-3">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.errorMessage}
                </div>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>
        
        <div class="shopping-cart mt-4">
            <div class="px-4 px-lg-0">

                <div class="pb-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 p-0 content-card mb-5">

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-kid">
                                            <tr>
                                                <th scope="col" class="border-0">
                                                    <div class="p-2 px-3 text-uppercase">Sản Phẩm</div>
                                                </th>
                                                <th scope="col" class="border-0">
                                                    <div class="py-2 text-uppercase">Đơn Giá</div>
                                                </th>
                                                <th scope="col" class="border-0">
                                                    <div class="py-2 text-uppercase">Số Lượng</div>
                                                </th>
                                                <th scope="col" class="border-0">
                                                    <div class="py-2 text-uppercase">Xóa</div>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${list}" var="o">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="p-2">
                                                            <img src="${o.product.image}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                            <div class="ml-3 d-inline-block align-middle">
                                                                <h5 class="mb-0"> <a href="detail?pid=${o.product.id}" class="product-link d-inline-block">${o.product.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                                                            </div>
                                                        </div>
                                                    </th>
                                                    <td class="align-middle product-price"><strong><fmt:formatNumber value="${o.product.price}" type="number" pattern="#,###"/> đ</strong></td>
                                                    <td class="align-middle">
                                                        <a href="updatecart?pid=${o.product.id}&amount=${o.amount-1}"><button class="btnSub">-</button></a> 
                                                        <strong class="mx-2">${o.amount}</strong>
                                                        <a href="updatecart?pid=${o.product.id}&amount=${o.amount+1}"><button class="btnAdd">+</button></a>
                                                    </td>
                                                    <td class="align-middle"><a href="deletecart?pid=${o.product.id}" class="text-dark">
                                                            <button type="button" class="btn btn-kid-danger btn-sm">Delete</button>
                                                        </a>
                                                    </td>
                                                </tr> 
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                </div>
                        </div>

                        <div class="row py-5 p-4 content-card">
                            <div class="col-lg-6">
                                <div class="kid-header-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                                <div class="p-4">
                                    <div class="input-group mb-4 border rounded-pill p-2">
                                        <input type="text" placeholder="Nhập Voucher" aria-describedby="button-addon3" class="form-control border-0">
                                        <div class="input-group-append border-0">
                                            <button id="button-addon3" type="button" class="btn btn-kid-cart px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Sử dụng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="kid-header-pill px-4 py-3 text-uppercase font-weight-bold">Thành tiền</div>
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4">
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng tiền hàng</strong><strong><fmt:formatNumber value="${total}" type="number" pattern="#,###"/> đ</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Phí vận chuyển</strong><strong>Free ship</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">VAT</strong><strong>0 đ</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng thanh toán</strong>
                                            <h5 class="font-weight-bold total-price"><fmt:formatNumber value="${total}" type="number" pattern="#,###"/> đ</h5>
                                        </li>
                                    </ul>
                                    <a href="checkout" class="btn btn-kid-cart rounded-pill py-2 btn-block">Mua hàng</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>

</html>