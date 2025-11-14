<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop | Thời Trang Trẻ Em</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        
        <link href="css/style.css" rel="stylesheet" type="text/css"/>

        <style>
            /* Nhập font Nunito */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FEF9FA; /* Màu nền hồng rất nhạt */
            }

            /* --- Navbar (từ Menu.jsp) --- */
            
            .navbar-kid {
                background-color: #FCE4EC !important; 
                font-family: 'Nunito', sans-serif;
                font-weight: 700; 
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); 
            }
            .navbar-kid .navbar-brand {
                font-weight: 800; 
                font-size: 1.4rem; 
                color: #C2185B !important; 
            }
            .navbar-kid .navbar-nav .nav-link {
                color: #AD1457 !important; 
                margin: 0 5px;
            }
            .navbar-kid .navbar-nav .nav-link:hover {
                color: #EC407A !important; 
            }
            .navbar-kid .navbar-nav .nav-link.active {
                color: #EC407A !important; 
                border-bottom: 3px solid #EC407A;
            }
            .btn-kid-search {
                background-color: #EC407A;
                border-color: #EC407A;
                color: white;
            }
            .btn-kid-search:hover {
                background-color: #C2185B;
                border-color: #C2185B;
                color: white;
            }
            .btn-kid-cart {
                background-color: #EC407A;
                color: white !important;
                border: none;
                font-weight: 700;
                border-radius: 30px; 
                padding-left: 1rem;
                padding-right: 1rem;
            }
            .btn-kid-cart:hover {
                background-color: #C2185B;
                color: white;
            }
            
            /* --- CSS cho trang Shop (Home.jsp) --- */

            /* Breadcrumb */
            .breadcrumb {
                background-color: #FFF;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            }
            .breadcrumb-item a {
                color: #EC407A;
                text-decoration: none;
            }
            .breadcrumb-item.active {
                color: #555;
            }

            /* Sidebar Cards (Categories, Last Product) */
            .sidebar-card {
                border-radius: 15px;
                border: none;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            }
            .sidebar-card .card-header {
                font-weight: 700;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }
            .header-pink {
                background-color: #F06292; /* Main pink */
                color: white;
            }
            .header-pink-light {
                background-color: #FCE4EC; /* Light pink */
                color: #C2185B; /* Dark pink text */
            }

            /* Category List */
            .category_block .list-group-item {
                border: none;
                color: #AD1457;
            }
            .category_block .list-group-item a {
                color: inherit;
                text-decoration: none;
                display: block;
                transition: transform 0.2s;
            }
            .category_block .list-group-item a:hover {
                transform: translateX(5px);
            }
            .category_block .list-group-item.active {
                background-color: #F06292;
                color: white;
                border-radius: 10px;
            }
            
            /* Product Card (Right side) */
            .product-card {
                border-radius: 15px;
                border: none;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                transition: transform 0.2s ease-in-out;
                margin-bottom: 20px;
                height: 100%;
            }
            .product-card:hover {
                transform: translateY(-5px);
            }
            .product-card .card-img-top {
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                height: 200px;
                object-fit: cover;
                width: 100%;
            }
            
            /* Product Title with Line Clamp */
            .product-card .card-title {
                margin-bottom: 0.5rem;
            }
            .product-card .card-title a {
                color: #C2185B;
                text-decoration: none;
                font-weight: 700;
                font-size: 1rem;
                line-height: 1.3;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                min-height: 2.6em;
                max-height: 2.6em;
            }
            
            /* Product Description with Line Clamp */
            .product-card .card-text {
                color: #666;
                font-size: 0.9rem;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                min-height: 4.2em;
                max-height: 4.2em;
                margin-bottom: 1rem;
            }

            /* Price Button */
            .btn-price {
                background-color: #FCE4EC;
                color: #C2185B;
                border: none;
                font-weight: 700;
                border-radius: 30px;
                font-size: 0.9rem;
                padding: 8px 12px;
            }
            
            /* Card Body Layout */
            .product-card .card-body {
                display: flex;
                flex-direction: column;
                height: calc(100% - 200px);
                padding: 1rem;
            }
            
            .product-card .card-body .row {
                margin-top: auto;
            }
            
            /* Ensure consistent button height */
            .btn-price, .btn-kid-cart {
                height: 38px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.85rem;
                white-space: nowrap;
            }

            /* Pagination styling to match site theme */
            .kid-pagination .page-link {
                color: #C2185B;
                border-radius: 999px;
                padding: 6px 12px;
                margin: 0 4px;
                border: none;
                background: transparent;
                font-weight: 600;
                min-width: 42px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }

            .kid-pagination .page-link i {
                font-size: 0.85rem;
            }

            .kid-pagination .page-item.active .page-link {
                background: linear-gradient(135deg, #F06292 0%, #EC407A 100%);
                color: white !important;
                box-shadow: 0 6px 18px rgba(236,64,122,0.18);
            }

            .kid-pagination .page-link:hover {
                background: rgba(236,64,122,0.08);
                color: #C2185B;
                text-decoration: none;
            }

            .kid-pagination .page-item.disabled .page-link {
                opacity: 0.5;
                pointer-events: none;
            }

            /* Swatch styles for color filter */
            .swatch-circle {
                display: inline-block;
                width: 14px;
                height: 14px;
                border-radius: 50%;
                margin-right: 8px;
                vertical-align: middle;
                border: 1px solid #eee;
            }
            .swatch-red { background-color: red; }
            .swatch-pink { background-color: pink; }
            .swatch-blue { background-color: blue; }
            .swatch-white { background-color: white; }
            .swatch-black { background-color: black; }

        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container">
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="#">Shop</li>
                        </ol>
                    </nav>
                </div>
            </div> 
        </div>
        
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                        <ul class="list-group category_block">
                            <c:forEach items="${listCC}" var="o">
                                <li class="list-group-item ${tag == o.cid ? "active" : ""}"><a href="category?cid=${o.cid}">${o.cname}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    
                    <!-- Color Filter -->
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink-light text-uppercase">Màu sắc</div>
                        <ul class="list-group category_block">
                            <c:url var="allColorUrl" value="${url}">
                                <c:param name="page" value="1" />
                                <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                            </c:url>
                            <li class="list-group-item ${empty param.color ? 'active' : ''}">
                                <a href="${allColorUrl}">Tất cả</a>
                            </li>
                            <c:set var="colors">red,pink,blue,white,black</c:set>
                            <c:forTokens var="cName" items="${colors}" delims=",">
                                <c:url var="colorUrl" value="${url}">
                                    <c:param name="color" value="${cName}" />
                                    <c:param name="page" value="1" />
                                    <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                    <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                    <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                    <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                                <!-- Reset price filter when changing color -->
                                </c:url>
                                <li class="list-group-item ${param.color == cName ? 'active' : ''}">
                                    <a href="${colorUrl}">
                                        <span class="swatch-circle swatch-${cName}"></span>
                                        <span style="text-transform:capitalize">${cName}</span>
                                    </a>
                                </li>
                            </c:forTokens>
                        </ul>
                    </div>

                    <!-- Size Filter -->
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink-light text-uppercase">Kích cỡ</div>
                        <div class="card-body">
                            <div class="btn-group btn-group-sm d-flex flex-wrap" role="group" aria-label="Size filter" style="gap:6px;">
                                <c:set var="sizes">S,M,L,XL</c:set>
                                <c:url var="allSizeUrl" value="${url}">
                                    <c:param name="page" value="1" />
                                    <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                    <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                    <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                    <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                                    <!-- Reset price filter when changing size -->
                                </c:url>
                                <a href="${allSizeUrl}" class="btn ${empty param.size ? 'btn-primary' : 'btn-outline-primary'}">All</a>
                                <c:forTokens var="sName" items="${sizes}" delims=",">
                                    <c:url var="sizeUrl" value="${url}">
                                        <c:param name="size" value="${sName}" />
                                        <c:param name="page" value="1" />
                                        <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                        <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                        <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                        <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                                        <!-- Reset price filter when changing size -->
                                    </c:url>
                                    <a href="${sizeUrl}" class="btn ${param.size == sName ? 'btn-primary' : 'btn-outline-primary'}">${sName}</a>
                                </c:forTokens>
                            </div>
                        </div>
                    </div>

                    <!-- Price Filter -->
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink-light text-uppercase">Giá</div>
                        <div class="card-body">
                            <c:set var="minDefault" value="0" />
                            <c:set var="maxDefault" value="1000000" />
                            <c:set var="minInit" value="${empty param.min ? minDefault : param.min}" />
                            <c:set var="maxInit" value="${empty param.max ? maxDefault : param.max}" />
                            <form method="get" action="${url}" id="priceFilterForm">
                                <input type="hidden" name="page" value="1"/>
                                <c:if test="${not empty tag}"><input type="hidden" name="cid" value="${tag}"/></c:if>
                                <c:if test="${not empty txtS}"><input type="hidden" name="txt" value="${txtS}"/></c:if>
                                <c:if test="${not empty sort}"><input type="hidden" name="sort" value="${sort}"/></c:if>
                                <c:if test="${not empty param.color}"><input type="hidden" name="color" value="${param.color}"/></c:if>
                                <c:if test="${not empty param.size}"><input type="hidden" name="size" value="${param.size}"/></c:if>

                                <input type="hidden" id="priceMinInput" name="min" value="${minInit}"/>
                                <input type="hidden" id="priceMaxInput" name="max" value="${maxInit}"/>

                                <div class="d-flex justify-content-between mb-2">
                                    <div class="small text-muted">Tối thiểu</div>
                                    <div class="small text-muted">Tối đa</div>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <div id="priceMinLabel" style="font-weight:700;color:#C2185B;">
                                        <fmt:formatNumber value="${minInit}" type="number" pattern="#,###"/> đ
                                    </div>
                                    <div id="priceMaxLabel" style="font-weight:700;color:#C2185B;">
                                        <fmt:formatNumber value="${maxInit}" type="number" pattern="#,###"/> đ
                                    </div>
                                </div>
                                <div class="position-relative" style="height:36px;">
                                    <input id="priceMinRange" type="range" min="${minDefault}" max="${maxDefault}" step="10000" value="${minInit}" style="position:absolute;left:0;right:0;top:8px;width:100%;pointer-events:auto;">
                                    <input id="priceMaxRange" type="range" min="${minDefault}" max="${maxDefault}" step="10000" value="${maxInit}" style="position:absolute;left:0;right:0;top:8px;width:100%;pointer-events:auto;">
                                </div>
                                <button type="submit" class="btn btn-sm btn-kid-cart btn-block mt-3">Lọc giá</button>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink-light text-uppercase">Last product</div>
                        <div class="card-body">
                            <img class="img-fluid" src="${p.image}" />
                            <h5 class="card-title">${p.name}</h5>
                            <p class="card-text">${p.title}</p>
                            <p class="bloc_left_price"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ</p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-9">
                    <!-- Filter bar -->
                    <div class="d-flex align-items-center mb-3" style="gap:10px;">
                        <div class="small text-muted">Sắp xếp theo</div>
                        <a href="home" class="btn btn-outline-light" style="border:1px solid #eee;">Tùy chọn</a>
                        <c:url var="popularUrl" value="${url}">
                            <c:param name="sort" value="popular" />
                            <c:param name="page" value="1" />
                            <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                            <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                            <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                            <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                            <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                            <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                        </c:url>
                        <a href="${popularUrl}" class="btn" style="background:#EC407A;color:white;font-weight:700;">Phổ Biến</a>

                        <c:url var="priceAscUrl" value="${url}">
                            <c:param name="sort" value="price_asc" />
                            <c:param name="page" value="1" />
                            <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                            <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                            <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                            <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                            <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                            <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                        </c:url>
                        <a href="${priceAscUrl}" class="btn" style="background:#fff;border:1px solid #FCE4EC;color:#C2185B;font-weight:700;">Giá ↑</a>

                        <c:url var="priceDescUrl" value="${url}">
                            <c:param name="sort" value="price_desc" />
                            <c:param name="page" value="1" />
                            <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                            <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                            <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                            <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                            <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                            <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                        </c:url>
                        <a href="${priceDescUrl}" class="btn" style="background:#fff;border:1px solid #FCE4EC;color:#C2185B;font-weight:700;">Giá ↓</a>
                    </div>

                    <div class="row">
                        <c:forEach items="${listP}" var="o">
                            <div class="col-12 col-md-6 col-lg-4 mb-4">
                                <div class="card product-card">
                                    <img class="card-img-top" src="${o.image}" alt="${o.name}">
                                    <div class="card-body">
                                        <h4 class="card-title">
                                            <a href="detail?pid=${o.id}" title="${o.name}">${o.name}</a>
                                        </h4>
                                        <p class="card-text">${o.title}</p>
                                        <div class="row">
                                            <div class="col">
                                                <p class="btn btn-price btn-block"><fmt:formatNumber value="${o.price}" type="number" pattern="#,###"/> đ</p>
                                            </div>
                                            <div class="col">
                                                <c:choose>
                                                    <c:when test="${o.quantity == 0}">
                                                        <button class="btn btn-secondary btn-block" disabled>Out of stock</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button onclick="addToCart('${o.id}')" class="btn btn-kid-cart btn-block">Add to cart</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                        <!-- Pagination placed at end of product list -->
                        <div class="row mt-3">
                            <div class="col-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center kid-pagination">
                                        <c:if test="${page > 1}">
                                            <c:url var="prevUrl" value="${url}">
                                                <c:param name="page" value="${page - 1}" />
                                                <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                                <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                                <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                                <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                                                <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                                                <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                                                <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                                            </c:url>
                                            <li class="page-item">
                                                <a class="page-link" href="${prevUrl}" aria-label="Previous">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPage}">
                                            <c:url var="pageUrl" value="${url}">
                                                <c:param name="page" value="${i}" />
                                                <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                                <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                                <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                                <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                                                <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                                                <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                                                <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                                            </c:url>
                                            <li class="page-item ${i == page ? 'active' : ''}"><a class="page-link" href="${pageUrl}">${i}</a></li>
                                        </c:forEach>

                                        <c:if test="${page < totalPage}">
                                            <c:url var="nextUrl" value="${url}">
                                                <c:param name="page" value="${page + 1}" />
                                                <c:if test="${not empty tag}"><c:param name="cid" value="${tag}" /></c:if>
                                                <c:if test="${not empty txtS}"><c:param name="txt" value="${txtS}" /></c:if>
                                                <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                                <c:if test="${not empty param.color}"><c:param name="color" value="${param.color}" /></c:if>
                                                <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
                                                <c:if test="${not empty param.min}"><c:param name="min" value="${param.min}" /></c:if>
                                                <c:if test="${not empty param.max}"><c:param name="max" value="${param.max}" /></c:if>
                                            </c:url>
                                            <li class="page-item">
                                                <a class="page-link" href="${nextUrl}" aria-label="Next">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                </div>

            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="Footer.jsp"></jsp:include>
        
        <div id="toast" class="toast" style="position: fixed; top: 80px; right: 20px; z-index: 9999; min-width: 250px; display: none;">
            <div class="toast-header bg-success text-white">
                <strong class="mr-auto"><i class="fa fa-check-circle"></i> Thông báo</strong>
                <button type="button" class="ml-2 mb-1 close text-white" data-dismiss="toast">
                    <span>&times;</span>
                </button>
            </div>
            <div class="toast-body" id="toastMessage">
                Đã thêm vào giỏ hàng thành công!
            </div>
        </div>
        
        <script>
            // Dual range slider for Price filter (no external libs)
            (function(){
                var minDefault = 0;
                var maxDefault = 1000000;
                var step = 10000;
                var minRange = document.getElementById('priceMinRange');
                var maxRange = document.getElementById('priceMaxRange');
                var minInput = document.getElementById('priceMinInput');
                var maxInput = document.getElementById('priceMaxInput');
                var minLabel = document.getElementById('priceMinLabel');
                var maxLabel = document.getElementById('priceMaxLabel');
                if (minRange && maxRange && minInput && maxInput && minLabel && maxLabel) {
                    var format = function(n){ try { return Number(n).toLocaleString('vi-VN'); } catch(e){ return n; } };
                    var clampStep = function(n){ return Math.round(n / step) * step; };
                    var sync = function(fromMin){
                        var minVal = parseInt(minRange.value, 10);
                        var maxVal = parseInt(maxRange.value, 10);
                        if (fromMin && minVal > maxVal) maxVal = minVal;
                        if (!fromMin && maxVal < minVal) minVal = maxVal;
                        minVal = clampStep(minVal);
                        maxVal = clampStep(maxVal);
                        minRange.value = String(minVal);
                        maxRange.value = String(maxVal);
                        minInput.value = String(minVal);
                        maxInput.value = String(maxVal);
                        minLabel.textContent = format(minVal) + ' đ';
                        maxLabel.textContent = format(maxVal) + ' đ';
                    };
                    minRange.addEventListener('input', function(){ sync(true); });
                    maxRange.addEventListener('input', function(){ sync(false); });
                    // Initial sync to normalize values
                    sync(true);
                }
            })();
            function addToCart(pid) {
                console.log('Adding product to cart:', pid);
                // default quantity = 1 for list pages
                fetch('addtocart?pid=' + pid + '&quantity=1')
                    .then(function(response) {
                        console.log('Response status:', response.status);
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(function(text) {
                        console.log('Response text:', text);
                        try {
                            var data = JSON.parse(text);
                            console.log('Parsed data:', data);
                            
                            if (data.success) {
                                showToast(data.message, 'success');
                            } else {
                                if (data.message && data.message.includes('đăng nhập')) {
                                    if (confirm(data.message + '\nBạn có muốn đăng nhập không?')) {
                                        window.location.href = 'Login.jsp';
                                    }
                                } else {
                                    showToast(data.message || 'Có lỗi xảy ra', 'error');
                                }
                            }
                        } catch (e) {
                            console.error('JSON parse error:', e, 'Text:', text);
                            showToast('Có lỗi xảy ra khi xử lý phản hồi', 'error');
                        }
                    })
                    .catch(function(error) {
                        console.error('Fetch error:', error);
                        showToast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    });
            }
            
            function showToast(message, type) {
                console.log('Showing toast:', message, type);
                var toast = document.getElementById('toast');
                var toastMessage = document.getElementById('toastMessage');
                
                if (!toast || !toastMessage) {
                    console.error('Toast element not found!');
                    alert(message);
                    return;
                }
                
                toastMessage.textContent = message;
                var toastHeader = toast.querySelector('.toast-header');
                if (toastHeader) {
                    if (type === 'success') {
                        toastHeader.className = 'toast-header bg-success text-white';
                    } else {
                        toastHeader.className = 'toast-header bg-danger text-white';
                    }
                }
                
                if (typeof $ !== 'undefined' && $.fn.toast) {
                    $(toast).toast({
                        autohide: true,
                        delay: 3000
                    });
                    $(toast).toast('show');
                } else {
                    toast.style.display = 'block';
                    toast.classList.add('show');
                    setTimeout(function() {
                        toast.classList.remove('show');
                        setTimeout(function() {
                            toast.style.display = 'none';
                         }, 300);
                    }, 3000);
                }
            }
        </script>
        <script>
            // Script dropdown (Giữ nguyên)
            $(document).ready(function() {
                if (typeof $ !== 'undefined' && $.fn.dropdown) {
                    $('.dropdown-toggle').on('click', function(e) {
                        e.preventDefault();
                        $(this).next('.dropdown-menu').toggle();
                    });
                    
                    $(document).on('click', function(e) {
                        if (!$(e.target).closest('.dropdown').length) {
                            $('.dropdown-menu').hide();
                        }
                    });
                }
            });
        </script>
    </body>
</html>