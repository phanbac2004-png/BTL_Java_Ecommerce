<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3">
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                        <ul class="list-group category_block">
                            <c:forEach items="${listCC}" var="o">
                                <li class="list-group-item ${tag == o.cid ? "active" : ""}"><a href="category?cid=${o.cid}">${o.cname}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    
                    
                    <div class="card sidebar-card mb-3">
                        <div class="card-header header-pink-light text-uppercase" style="background-color: #F06292; color: #fff">Last product</div>
                        <div class="card-body">
                            <img class="img-fluid" src="${p.image}" />
                            <h5 class="card-title">${p.name}</h5>
                            <p class="card-text">${p.title}</p>
                            <p class="bloc_left_price"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ</p>
                        </div>
                    </div>
                </div>