<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    /* FIXED CSS cho Sidebar Left */
    .col-sm-3 {
        width: 280px !important;
        min-width: 280px !important;
        flex: 0 0 280px !important;
    }
    
    .sidebar-card {
        border-radius: 15px;
        border: none;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        margin-bottom: 20px;
        width: 100% !important;
    }
    
    .sidebar-card .card-header {
        font-weight: 700;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        border-bottom: none;
        padding: 15px 20px;
        font-size: 16px !important;
    }
    
    .header-pink {
        background-color: #F06292;
        color: white;
    }
    
    .header-pink-light {
        background-color: #F8BBD0;
        color: #C2185B;
    }
    
    .category_block .list-group-item {
        border: none;
        color: #AD1457;
        padding: 12px 20px;
        transition: all 0.3s ease;
        font-size: 14px !important;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .category_block .list-group-item a {
        color: inherit;
        text-decoration: none;
        display: flex;
        align-items: center;
        width: 100%;
    }
    
    .category_block .list-group-item:hover {
        background-color: #FCE4EC;
        padding-left: 25px;
    }
    
    .category_block .list-group-item.active {
        background-color: #F06292;
        color: white;
        border-radius: 8px;
        margin: 2px 10px;
    }
    
    /* Swatch colors */
    .swatch-circle {
        display: inline-block;
        width: 16px;
        height: 16px;
        border-radius: 50%;
        margin-right: 8px;
        border: 2px solid #fff;
        box-shadow: 0 0 0 1px #ddd;
        flex-shrink: 0;
    }
    
    .swatch-red { background-color: #ff6b6b; }
    .swatch-pink { background-color: #ff85c0; }
    .swatch-blue { background-color: #79e2ff; }
    .swatch-white { background-color: #ffffff; }
    .swatch-black { background-color: #333333; }
    
    /* Size buttons */
    .btn-group-sm .btn {
        border-radius: 20px;
        padding: 6px 12px;
        font-size: 12px;
        font-weight: 600;
        flex-shrink: 0;
    }
    
    .btn-outline-primary {
        border-color: #EC407A;
        color: #EC407A;
    }
    
    .btn-outline-primary:hover {
        background-color: #EC407A;
        border-color: #EC407A;
        color: white;
    }
    
    /* Price range slider */
    .price-slider-container {
        position: relative;
        height: 36px;
        margin: 15px 0;
        width: 100% !important;
    }
    
    .price-slider-container input[type="range"] {
        position: absolute;
        pointer-events: none;
        -webkit-appearance: none;
        width: 100%;
        height: 4px;
        background: transparent;
        outline: none;
    }
    
    .price-slider-container input[type="range"]::-webkit-slider-thumb {
        pointer-events: all;
        -webkit-appearance: none;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        background: #EC407A;
        cursor: pointer;
        border: 2px solid white;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    
    .price-slider-container input[type="range"]::-moz-range-thumb {
        pointer-events: all;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        background: #EC407A;
        cursor: pointer;
        border: 2px solid white;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    
    .price-slider-track {
        position: absolute;
        top: 16px;
        left: 0;
        right: 0;
        height: 4px;
        background: #E0E0E0;
        border-radius: 2px;
    }
    
    .price-slider-progress {
        position: absolute;
        top: 16px;
        height: 4px;
        background: #EC407A;
        border-radius: 2px;
    }
    
    /* Filter section */
    .filter-section {
        margin-bottom: 15px;
        width: 100% !important;
    }
    
    .filter-title {
        color: #C2185B;
        font-weight: 700;
        margin-bottom: 12px;
        font-size: 14px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .filter-content {
        padding: 15px;
        background: #FEF9FA;
        border-radius: 10px;
        width: 100% !important;
    }
    
    .btn-kid-cart {
        background-color: #EC407A;
        color: white !important;
        border: none;
        font-weight: 700;
        border-radius: 25px;
        padding: 10px 20px;
        transition: all 0.3s ease;
        width: 100%;
        font-size: 14px !important;
    }
    
    .btn-kid-cart:hover {
        background-color: #C2185B;
        color: white !important;
        transform: translateY(-1px);
    }
    
    /* Last product card */
    .last-product-img {
        border-radius: 10px;
        margin-bottom: 10px;
        max-width: 100% !important;
        height: auto;
    }
    
    .bloc_left_price {
        color: #EC407A;
        font-weight: 700;
        font-size: 16px;
    }
    
    /* Ensure proper spacing and prevent shrinking */
    .card-body {
        width: 100% !important;
        padding: 15px !important;
    }
    
    .d-flex.flex-wrap.gap-2 {
        width: 100% !important;
        flex-wrap: wrap !important;
    }
</style>

<div class="col-sm-3" style="width: 280px; min-width: 280px; flex: 0 0 280px;">
    <!-- Categories -->
    <div class="card sidebar-card mb-4">
        <div class="card-header header-pink text-white text-uppercase">
            <i class="fa fa-list me-2"></i> Danh mục
        </div>
        <ul class="list-group category_block">
            <c:forEach items="${listCC}" var="o">
                <li class="list-group-item ${tag == o.cid ? 'active' : ''}">
                    <a href="category?cid=${o.cid}">${o.cname}</a>
                </li>
            </c:forEach>
        </ul>
    </div>
    
    <!-- Filter Section (combined form for color, size, price) -->
    <div class="card sidebar-card mb-4">
        <div class="card-header header-pink text-white text-uppercase">
            <i class="fas fa-filter me-2"></i> Bộ lọc
        </div>
        <div class="card-body" style="width: 100%;">
            <c:set var="minDefault" value="0" />
            <c:set var="maxDefault" value="1000000" />
            <!-- Prefer explicit request params (from GET). If absent, fall back to controller-set attributes. -->
            <c:set var="minInit" value="${not empty param.min ? param.min : (not empty filterMin ? filterMin : minDefault)}" />
            <c:set var="maxInit" value="${not empty param.max ? param.max : (not empty filterMax ? filterMax : maxDefault)}" />

            <form id="filtersForm" method="get" action="${url}" style="width:100%;">
                <input type="hidden" name="page" value="1"/>
                <c:if test="${not empty tag}"><input type="hidden" name="cid" value="${tag}"/></c:if>
                <c:if test="${not empty txtS}"><input type="hidden" name="txt" value="${txtS}"/></c:if>
                <c:if test="${not empty sort}"><input type="hidden" name="sort" value="${sort}"/></c:if>

                <!-- Color Filter -->
                <div class="filter-section">
                    <div class="filter-title">
                        <span><i class="fas fa-palette me-2"></i>Màu sắc</span>
                    </div>
                    <div class="filter-content">
                        <ul class="list-group category_block" id="colorList" style="margin:0;">
                            <li class="list-group-item ${empty param.color ? 'active' : ''}" data-color="">
                                <label style="width:100%;cursor:pointer;margin:0;">
                                    <input type="radio" name="color" value="" style="display:none;" ${empty param.color ? 'checked' : ''} />
                                    Tất cả màu sắc
                                </label>
                            </li>
                            <c:forEach items="${colorsList}" var="c">
                                <li class="list-group-item ${param.color == c.colorId ? 'active' : ''}" data-color="${c.colorId}">
                                    <label style="width:100%;cursor:pointer;margin:0;display:flex;align-items:center;">
                                        <input type="radio" name="color" value="${c.colorId}" style="display:none;" ${param.color == c.colorId ? 'checked' : ''} />
                                        <span class="swatch-circle">
                                            <c:choose>
                                                <c:when test="${c.colorName == 'Đen'}"><i style="display:block;width:100%;height:100%;background:#333;border-radius:50%;"></i></c:when>
                                                <c:when test="${c.colorName == 'Đỏ'}"><i style="display:block;width:100%;height:100%;background:#ff6b6b;border-radius:50%;"></i></c:when>
                                                <c:when test="${c.colorName == 'Hồng'}"><i style="display:block;width:100%;height:100%;background:#ff85c0;border-radius:50%;"></i></c:when>
                                                <c:when test="${c.colorName == 'Trắng'}"><i style="display:block;width:100%;height:100%;background:#ffffff;border-radius:50%;border:1px solid #ddd;"></i></c:when>
                                                <c:when test="${c.colorName == 'Xanh'}"><i style="display:block;width:100%;height:100%;background:#79e2ff;border-radius:50%;"></i></c:when>
                                                <c:otherwise><i style="display:block;width:100%;height:100%;background:#ccc;border-radius:50%;"></i></c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span style="margin-left:8px;">${c.colorName}</span>
                                    </label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <!-- Size Filter -->
                <div class="filter-section">
                    <div class="filter-title">
                        <span><i class="fas fa-ruler me-2"></i>Kích cỡ</span>
                    </div>
                    <div class="filter-content">
                        <div class="d-flex flex-wrap gap-2" id="sizeList" style="width:100%;">
                            <label class="btn ${empty param.size ? 'btn-primary' : 'btn-outline-primary'} btn-sm" style="cursor:pointer;">
                                <input type="radio" name="size" value="" style="display:none;" ${empty param.size ? 'checked' : ''}/> Tất cả
                            </label>
                            <c:forEach items="${sizesList}" var="s">
                                <label class="btn ${param.size == s.sizeId ? 'btn-primary' : 'btn-outline-primary'} btn-sm" style="cursor:pointer;">
                                    <input type="radio" name="size" value="${s.sizeId}" style="display:none;" ${param.size == s.sizeId ? 'checked' : ''}/> ${s.sizeName}
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Price Filter -->
                <div class="filter-section">
                    <div class="filter-title">
                        <span><i class="fas fa-tag me-2"></i>Khoảng giá</span>
                    </div>
                    <div class="filter-content">
                        <input type="hidden" id="priceMinInput" name="min" value="${minInit}"/>
                        <input type="hidden" id="priceMaxInput" name="max" value="${maxInit}"/>

                        <div class="d-flex justify-content-between mb-2">
                            <div class="small text-muted">Từ</div>
                            <div class="small text-muted">Đến</div>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <div id="priceMinLabel" style="font-weight:700;color:#C2185B;font-size:14px;">
                                <fmt:formatNumber value="${minInit}" type="number" pattern="#,###"/> đ
                            </div>
                            <div id="priceMaxLabel" style="font-weight:700;color:#C2185B;font-size:14px;">
                                <fmt:formatNumber value="${maxInit}" type="number" pattern="#,###"/> đ
                            </div>
                        </div>

                        <div class="price-slider-container">
                            <div class="price-slider-track"></div>
                            <div class="price-slider-progress" id="priceProgress"></div>
                            <input id="priceMinRange" type="range" min="${minDefault}" max="${maxDefault}" step="10000" value="${minInit}">
                            <input id="priceMaxRange" type="range" min="${minDefault}" max="${maxDefault}" step="10000" value="${maxInit}">
                        </div>

                    </div>
                </div>

                <button type="submit" class="btn btn-kid-cart mt-3">
                    <i class="fas fa-check me-2"></i>Áp dụng
                </button>
            </form>

            <script>
                (function(){
                    // dual-range slider logic
                    const minRange = document.getElementById('priceMinRange');
                    const maxRange = document.getElementById('priceMaxRange');
                    const minInput = document.getElementById('priceMinInput');
                    const maxInput = document.getElementById('priceMaxInput');
                    const minLabel = document.getElementById('priceMinLabel');
                    const maxLabel = document.getElementById('priceMaxLabel');
                    const progress = document.getElementById('priceProgress');
                    const min = Number(minRange.min);
                    const max = Number(maxRange.max);
                    const step = Number(minRange.step) || 1;
                    const gap = Math.max(step, 10000);

                    function formatV(v){
                        try{ return Number(v).toLocaleString(); }catch(e){ return v; }
                    }

                    function updateProgress(){
                        const minV = Number(minRange.value);
                        const maxV = Number(maxRange.value);
                        const left = ( (minV - min) / (max - min) ) * 100;
                        const width = ( (maxV - minV) / (max - min) ) * 100;
                        progress.style.left = left + '%';
                        progress.style.width = Math.max(0, width) + '%';
                    }

                    function syncLabels(){
                        const minV = Number(minRange.value);
                        const maxV = Number(maxRange.value);
                        minLabel.textContent = formatV(minV) + ' đ';
                        maxLabel.textContent = formatV(maxV) + ' đ';
                        minInput.value = minV;
                        maxInput.value = maxV;
                        updateProgress();
                    }

                    minRange.addEventListener('input', function(){
                        let v = Number(minRange.value);
                        if(v > Number(maxRange.value) - gap) v = Number(maxRange.value) - gap;
                        minRange.value = v;
                        syncLabels();
                    });

                    maxRange.addEventListener('input', function(){
                        let v = Number(maxRange.value);
                        if(v < Number(minRange.value) + gap) v = Number(minRange.value) + gap;
                        maxRange.value = v;
                        syncLabels();
                    });

                    // initial draw
                    syncLabels();

                    // clickable list items for color & size to toggle active class and check radio
                    function makeClickableList(containerSelector, itemSelector){
                        const container = document.querySelector(containerSelector);
                        if(!container) return;
                        container.addEventListener('click', function(e){
                            // find closest list-group-item or label
                            let li = e.target.closest(itemSelector);
                            if(!li) return;
                            // For color list items
                            if(li.dataset && li.dataset.color !== undefined){
                                // remove active on siblings
                                container.querySelectorAll('.list-group-item').forEach(function(i){ i.classList.remove('active'); });
                                li.classList.add('active');
                                const radio = li.querySelector('input[type="radio"]');
                                if(radio){ radio.checked = true; }
                            }
                        });
                    }

                    makeClickableList('#colorList', '.list-group-item');

                    // Size buttons: toggle active class when clicked
                    const sizeList = document.getElementById('sizeList');
                    if(sizeList){
                        sizeList.addEventListener('click', function(e){
                            const lbl = e.target.closest('label');
                            if(!lbl) return;
                            // remove primary class from siblings, set outline accordingly
                            sizeList.querySelectorAll('label').forEach(function(l){
                                l.classList.remove('btn-primary');
                                l.classList.add('btn-outline-primary');
                            });
                            lbl.classList.remove('btn-outline-primary');
                            lbl.classList.add('btn-primary');
                            const r = lbl.querySelector('input[type="radio"]');
                            if(r){ r.checked = true; }
                        });
                    }

                })();
            </script>
            <script>
                // AJAX apply for filters and pagination
                (function(){
                    var $form = $('#filtersForm');

                    function updateProductAreaFromUrl(url) {
                        // fetch the target page and replace #productArea
                        $.get(url).done(function(html){
                            try {
                                var newArea = $(html).find('#productArea').html();
                                if(newArea) {
                                    $('#productArea').html(newArea);
                                } else {
                                    console.warn('productArea not found in response');
                                }
                            } catch (e) {
                                console.error('Failed to update product area', e);
                            }
                        }).fail(function(){
                            console.error('AJAX request failed for', url);
                            // fallback: navigate
                            window.location.href = url;
                        });
                    }

                    // intercept apply button / form submit
                    $(document).on('submit', '#filtersForm', function(e){
                        e.preventDefault();
                        var action = $form.attr('action') || window.location.pathname;
                        var params = $form.serialize();
                        var url = action + (action.indexOf('?') === -1 ? '?' : '&') + params;

                        // Update browser URL and history
                        try { window.history.pushState({}, '', url); } catch(e) {}

                        updateProductAreaFromUrl(url);
                    });

                    // intercept pagination links inside productArea
                    $(document).on('click', '#productArea .kid-pagination a', function(e){
                        e.preventDefault();
                        var url = $(this).attr('href');
                        if(!url) return;

                        // Keep filters form inputs in sync with URL (optional)
                        // Update history
                        try { window.history.pushState({}, '', url); } catch(e) {}

                        updateProductAreaFromUrl(url);
                    });

                    // handle browser back/forward
                    window.addEventListener('popstate', function(e){
                        // reload content for current location
                        updateProductAreaFromUrl(window.location.pathname + window.location.search);
                    });
                })();
            </script>
        </div>
    </div>
    
    <!-- Last Product -->
    <div class="card sidebar-card">
        <div class="card-header header-pink-light text-uppercase">
            <i class="fas fa-star me-2"></i> Sản phẩm mới
        </div>
        <div class="card-body text-center" style="width: 100%;">
            <c:if test="${not empty p}">
                <img class="img-fluid last-product-img" src="${p.image}" alt="${p.name}" style="max-width: 100%; height: auto;"/>
                <h6 class="card-title mt-2" style="color:#C2185B;font-weight:700;font-size:14px;">${p.name}</h6>
                <p class="card-text small text-muted" style="font-size:12px;">${p.title}</p>
                <p class="bloc_left_price"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ</p>
            </c:if>
            <c:if test="${empty p}">
                <p class="text-muted small">Chưa có sản phẩm mới</p>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Price range slider functionality
    document.addEventListener('DOMContentLoaded', function() {
        const minRange = document.getElementById('priceMinRange');
        const maxRange = document.getElementById('priceMaxRange');
        const minInput = document.getElementById('priceMinInput');
        const maxInput = document.getElementById('priceMaxInput');
        const minLabel = document.getElementById('priceMinLabel');
        const maxLabel = document.getElementById('priceMaxLabel');
        const progress = document.getElementById('priceProgress');
        
        function updatePriceDisplay() {
            const minVal = parseInt(minRange.value);
            const maxVal = parseInt(maxRange.value);
            
            // Update hidden inputs
            minInput.value = minVal;
            maxInput.value = maxVal;
            
            // Update labels
            minLabel.textContent = new Intl.NumberFormat('vi-VN').format(minVal) + ' đ';
            maxLabel.textContent = new Intl.NumberFormat('vi-VN').format(maxVal) + ' đ';
            
            // Update progress bar
            const minPercent = (minVal / parseInt(minRange.max)) * 100;
            const maxPercent = (maxVal / parseInt(maxRange.max)) * 100;
            progress.style.left = minPercent + '%';
            progress.style.right = (100 - maxPercent) + '%';
        }
        
        minRange.addEventListener('input', function() {
            let minVal = parseInt(this.value);
            let maxVal = parseInt(maxRange.value);
            
            if (minVal > maxVal) {
                minVal = maxVal;
                this.value = minVal;
            }
            
            updatePriceDisplay();
        });
        
        maxRange.addEventListener('input', function() {
            let minVal = parseInt(minRange.value);
            let maxVal = parseInt(this.value);
            
            if (maxVal < minVal) {
                maxVal = minVal;
                this.value = maxVal;
            }
            
            updatePriceDisplay();
        });
        
        // Initialize display
        updatePriceDisplay();
    });
</script>