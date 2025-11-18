<%-- 
    Document   : Detail
    Created on : Dec 29, 2020, 5:43:04 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết | ${detail.name}</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
            /* Nhập font Nunito */
            @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap');
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #FEF9FA; /* Màu nền hồng rất nhạt */
            }
            
            /* --- Nút bấm "Kiddy" --- */
            .btn-kid-cart {
                background-color: #EC407A;
                color: white !important;
                border: none;
                font-weight: 700;
                border-radius: 30px; 
            }
            .btn-kid-cart:hover {
                background-color: #C2185B;
                color: white !important;
            }
            .btn-kid-outline {
                background-color: transparent;
                border: 2px solid #EC407A;
                color: #EC407A; /* Chữ hồng */
                font-weight: 700;
                border-radius: 30px;
                transition: all 0.2s;
            }
            .btn-kid-outline:hover {
                background-color: #EC407A;
                color: white;
            }
            
            /* --- CSS cho Sidebar (Left.jsp) --- */
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
            .category_block .list-group-item {
                border: none;
                color: #AD1457;
            }
            .category_block .list-group-item a {
                color: inherit;
                text-decoration: none;
            }
            .category_block .list-group-item.active {
                background-color: #F06292;
                color: white;
                border-radius: 10px;
            }
            
            /* --- CSS cho trang Detail --- */
            .detail-card {
                border-radius: 15px;
                border: none;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                background: #fff;
            }
            .product-title {
                color: #C2185B; /* Màu hồng đậm */
                font-weight: 800;
            }
            .product-price {
                color: #F06292; /* Màu hồng chính */
                font-weight: 700;
            }
            .item-property dt {
                color: #AD1457;
                font-weight: 700;
            }
            .form-control:focus {
                border-color: #F06292;
                box-shadow: 0 0 0 0.2rem rgba(236, 64, 122, 0.25);
            }

            /* CSS Gốc (Giữ nguyên) */
            .gallery-wrap .img-big-wrap img {
                height: 450px;
                width: auto;
                display: inline-block;
                cursor: zoom-in;
            }
            .gallery-wrap .img-small-wrap .item-gallery {
                width: 60px;
                height: 60px;
                border: 1px solid #ddd;
                margin: 7px 2px;
                display: inline-block;
                overflow: hidden;
            }
            .gallery-wrap .img-small-wrap {
                text-align: center;
            }
            .gallery-wrap .img-small-wrap img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
                border-radius: 4px;
                cursor: zoom-in;
            }
            .img-big-wrap img{
                width: 100% !important;
                height: auto !important;
            }

            /* --- CSS mới cho chọn màu và size --- */
            .option-section {
                margin-bottom: 20px;
            }
            .option-title {
                color: #C2185B;
                font-weight: 700;
                margin-bottom: 10px;
                font-size: 16px;
            }
            .color-options, .size-options {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 15px;
            }
            .color-option {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 3px solid transparent;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
            }
            .color-option:hover {
                transform: scale(1.1);
            }
            .color-option.selected {
                border-color: #EC407A;
                transform: scale(1.1);
            }
            .color-option::after {
                content: '✓';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;
                font-weight: bold;
                font-size: 14px;
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            .color-option.selected::after {
                opacity: 1;
            }
            .size-option {
                padding: 8px 16px;
                border: 2px solid #E0E0E0;
                border-radius: 20px;
                background: white;
                cursor: pointer;
                font-weight: 600;
                color: #666;
                transition: all 0.3s ease;
                min-width: 50px;
                text-align: center;
            }
            .size-option:hover {
                border-color: #F06292;
                color: #F06292;
            }
            .size-option.selected {
                border-color: #EC407A;
                background: #EC407A;
                color: white;
            }
            .size-option.disabled {
                opacity: 0.4;
                cursor: not-allowed;
                text-decoration: line-through;
            }
            .color-name, .size-name {
                font-size: 12px;
                color: #666;
                margin-top: 5px;
                text-align: center;
            }
            .selected-options {
                background: #FCE4EC;
                padding: 15px;
                border-radius: 10px;
                margin: 20px 0;
            }
            .selected-options p {
                margin: 5px 0;
                color: #C2185B;
                font-weight: 600;
            }
            
        </style>
        </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                <jsp:include page="Left.jsp"></jsp:include>
                <div class="col-sm-9">
                    <div class="container">
                        <div class="card detail-card">
                            <div class="row">
                                <aside class="col-sm-5 border-right">
                                    <article class="gallery-wrap"> 
                                        <div class="img-big-wrap">
                                            <div> <a href="#"><img src="${detail.image}"></a></div>
                                        </div> 
                                        <div class="img-small-wrap">
                                            <!-- Có thể thêm ảnh nhỏ ở đây nếu có -->
                                        </div> 
                                    </article> 
                                </aside>
                                <aside class="col-sm-7">
                                    <article class="card-body p-5">
                                        
                                        <h3 class="title mb-3 product-title">${detail.name}</h3>

                                        <p class="price-detail-wrap"> 
                                            <span class="price h3 product-price"> 
                                                <fmt:formatNumber value="${detail.price}" type="number" pattern="#,###"/> đ
                                            </span> 
                                        </p> 

                                        <!-- Phần chọn màu sắc (rendered dynamically from variantsList/colorsList/sizesList) -->
                                        <div class="option-section">
                                            <div class="option-title">
                                                <i class="fas fa-palette me-2"></i>Chọn màu sắc
                                            </div>
                                            <div class="color-options" id="colorOptionsContainer">
                                                <!-- populated by JS -->
                                            </div>
                                        </div>

                                        <!-- Phần chọn size -->
                                        <div class="option-section">
                                            <div class="option-title">
                                                <i class="fas fa-ruler me-2"></i>Chọn size
                                            </div>
                                            <div class="size-options" id="sizeOptionsContainer">
                                                <!-- populated by JS -->
                                            </div>
                                        </div>

                                        <!-- (Removed) Previously displayed selected options block -->

                                        <dl class="item-property">
                                            <dt>Mô tả sản phẩm</dt>
                                            <dd><p>${detail.description}</p></dd>
                                        </dl>

                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <dl class="param param-inline">
                                                    <dt>Số lượng: </dt>
                                                    <dd>
                                                        <input type="number" id="quantityInput" name="quantity" class="form-control form-control-sm" style="width:100px;" value="1" min="1" max="${detail.quantity}" />
                                                    </dd>
                                                </dl>  
                                            </div> 
                                        </div> 
                                        <hr>
                                        
                                        <a href="#" id="buyNowBtn" class="btn btn-lg btn-kid-cart text-uppercase"> 
                                            <i class="fas fa-bolt me-2"></i>Mua ngay 
                                        </a>
                                        
                                        <button onclick="addToCart('${detail.id}')" id="addToCartBtn" class="btn btn-lg btn-kid-outline text-uppercase"> 
                                            <i class="fas fa-shopping-cart"></i> Thêm vào giỏ 
                                        </button>
                                    
                                    </article> 
                                </aside> 
                            </div> 
                        </div> 
                    </div> 
                </div>
            </div>
        </div>
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
           // Prepare data structures from server-side lists
           var variants = [
               <c:forEach var="v" items="${variantsList}" varStatus="s">
                   {variantId: ${v.variantId}, productId: ${v.productId}, colorId: ${v.colorId}, sizeId: ${v.sizeId}, quantity: ${v.quantity}}<c:if test="${not s.last}">,</c:if>
               </c:forEach>
           ];

           var colorMap = {};
           <c:forEach var="c" items="${colorsList}">
               colorMap[${c.colorId}] = "${c.colorName}";
           </c:forEach>

           var sizeMap = {};
           <c:forEach var="s" items="${sizesList}">
               sizeMap[${s.sizeId}] = "${s.sizeName}";
           </c:forEach>

           // Utility: build list of unique colorIds from variants
           function uniqueColors() {
               var m = {};
               variants.forEach(function(v){ if (v.quantity > 0) m[v.colorId]=true; });
               return Object.keys(m).map(function(k){ return parseInt(k); });
           }

           function uniqueSizesForColor(colorId) {
               var m = {};
               variants.forEach(function(v){ if (v.colorId == colorId && v.quantity > 0) m[v.sizeId]=true; });
               return Object.keys(m).map(function(k){ return parseInt(k); });
           }

           function uniqueSizesAll() {
               var m = {};
               variants.forEach(function(v){ if (v.quantity > 0) m[v.sizeId]=true; });
               return Object.keys(m).map(function(k){ return parseInt(k); });
           }

           function findVariant(colorId, sizeId) {
               for (var i=0;i<variants.length;i++){
                   var v = variants[i];
                   if (v.colorId == colorId && v.sizeId == sizeId) return v;
               }
               return null;
           }

           // Render color and size options
           function renderOptions() {
               var colorContainer = document.getElementById('colorOptionsContainer');
               var sizeContainer = document.getElementById('sizeOptionsContainer');
               colorContainer.innerHTML = '';
               sizeContainer.innerHTML = '';

               var colors = uniqueColors();
               colors.forEach(function(cid, idx){
                   var name = colorMap[cid] || ('Màu ' + cid);
                   var div = document.createElement('div');
                   div.className = 'color-option';
                   div.dataset.colorId = cid;
                   div.dataset.colorName = name;
                   // simple swatch mapping by name
                   var bg = '#ccc';
                   if (name.indexOf('Đen')>=0) bg = '#333';
                   else if (name.indexOf('Đỏ')>=0) bg = '#ff6b6b';
                   else if (name.indexOf('Hồng')>=0) bg = '#ff85c0';
                   else if (name.indexOf('Trắng')>=0) bg = '#ffffff';
                   else if (name.indexOf('Xanh')>=0) bg = '#79e2ff';
                   div.style.background = bg;
                   if (bg === '#ffffff') div.style.border = '1px solid #ddd';
                   colorContainer.appendChild(div);
               });

               // render sizes by default (all available sizes)
               renderSizesForColor(null);
           }

           // selection state
           var selectedColorId = null;
           var selectedSizeId = null;
           var selectedVariant = null;

           function updateSelectedDisplay() {
               var colorEl = document.getElementById('selectedColorText');
               if (colorEl) colorEl.innerHTML = 'Màu sắc: <strong>' + (selectedColorId ? (colorMap[selectedColorId]||selectedColorId) : '—') + '</strong>';
               var sizeEl = document.getElementById('selectedSizeText');
               if (sizeEl) sizeEl.innerHTML = 'Size: <strong>' + (selectedSizeId ? (sizeMap[selectedSizeId]||selectedSizeId) : '—') + '</strong>';
               var qtyElDisplay = document.getElementById('selectedQtyText');
               if (qtyElDisplay) qtyElDisplay.innerHTML = 'Sẵn có: <strong>' + (selectedVariant ? selectedVariant.quantity : '—') + '</strong>';
               var qtyEl = document.getElementById('quantityInput');
               if (selectedVariant) {
                   if (qtyEl) {
                       qtyEl.max = selectedVariant.quantity;
                       if (parseInt(qtyEl.value) > selectedVariant.quantity) qtyEl.value = selectedVariant.quantity;
                   }
                   var addBtn = document.getElementById('addToCartBtn'); if (addBtn) addBtn.disabled = false;
                   var buyBtn = document.getElementById('buyNowBtn'); if (buyBtn) buyBtn.disabled = false;
               } else {
                   if (qtyEl) qtyEl.removeAttribute('max');
                   var addBtn2 = document.getElementById('addToCartBtn'); if (addBtn2) addBtn2.disabled = true;
                   var buyBtn2 = document.getElementById('buyNowBtn'); if (buyBtn2) buyBtn2.disabled = true;
               }
           }

           function renderSizesForColor(colorId) {
               var sizeContainer = document.getElementById('sizeOptionsContainer');
               sizeContainer.innerHTML = '';
               // If colorId provided, we will enable only sizes available for that color
               var sizes = uniqueSizesAll();
               sizes.forEach(function(sid){
                   var name = sizeMap[sid] || sid;
                   var div = document.createElement('div');
                   div.className = 'size-option';
                   div.dataset.sizeId = sid;
                   div.textContent = name;
                   // determine availability
                   var available = false;
                   for (var i=0;i<variants.length;i++){
                       var v = variants[i];
                       if (v.sizeId == sid && v.quantity > 0) {
                           if (colorId == null) { available = true; break; }
                           if (v.colorId == colorId) { available = true; break; }
                       }
                   }
                   if (!available) div.classList.add('disabled');
                   sizeContainer.appendChild(div);
               });
               // attach handlers
               sizeContainer.querySelectorAll('.size-option').forEach(function(opt){
                   opt.addEventListener('click', function(){
                       if (this.classList.contains('disabled')) return;
                       // mark selected
                       sizeContainer.querySelectorAll('.size-option').forEach(function(o){ o.classList.remove('selected'); });
                       this.classList.add('selected');
                       selectedSizeId = parseInt(this.dataset.sizeId);
                       if (selectedColorId) {
                           selectedVariant = findVariant(selectedColorId, selectedSizeId);
                       } else {
                           selectedVariant = null; // not fully selected until color chosen
                       }
                       updateSelectedDisplay();
                   });
               });

               // If a size was previously selected, ensure it stays selected if still available
               if (selectedSizeId) {
                   var prev = sizeContainer.querySelector('.size-option[data-size-id="' + selectedSizeId + '"]');
                   if (prev && !prev.classList.contains('disabled')) {
                       prev.classList.add('selected');
                   } else {
                       selectedSizeId = null;
                       selectedVariant = null;
                   }
               }
           }

           // initialize
           renderOptions();
           // color click handlers
           document.getElementById('colorOptionsContainer').addEventListener('click', function(e){
               var el = e.target.closest('.color-option');
               if (!el) return;
               selectedColorId = parseInt(el.dataset.colorId);
               selectedSizeId = null;
               selectedVariant = null;
               // highlight selected
               document.querySelectorAll('.color-option').forEach(function(o){ o.classList.remove('selected'); });
               el.classList.add('selected');
               // render sizes for this color
               renderSizesForColor(selectedColorId);
               updateSelectedDisplay();
           });

           // Helper: get query param
           function getUrlParam(name) {
               name = name.replace(/[\[\]]/g, '\\$&');
               var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
               var results = regex.exec(window.location.href);
               if (!results) return null;
               if (!results[2]) return '';
               return decodeURIComponent(results[2].replace(/\+/g, ' '));
           }

           // If a variant_id is provided in URL, preselect that variant
           (function preselectFromUrl() {
               var vid = getUrlParam('variant_id') || getUrlParam('variantId') || getUrlParam('vid');
               if (!vid) return;
               vid = parseInt(vid);
               var found = null;
               for (var i=0;i<variants.length;i++){
                   if (variants[i].variantId == vid) { found = variants[i]; break; }
               }
               if (!found) return;
               // set selected color/size and render accordingly
               selectedColorId = found.colorId;
               selectedSizeId = found.sizeId;
               selectedVariant = found;
               // mark color selected after render
               // ensure options are rendered
               renderOptions();
               // highlight color
               var colorEl = document.querySelector('.color-option[data-color-id="' + selectedColorId + '"]');
               if (colorEl) colorEl.classList.add('selected');
               // render sizes for color and select size
               renderSizesForColor(selectedColorId);
               var sizeEl = document.querySelector('.size-option[data-size-id="' + selectedSizeId + '"]');
               if (sizeEl) sizeEl.classList.add('selected');
               updateSelectedDisplay();
           })();

           function addToCart(pid, redirectToCheckout) {
               console.log('Adding product to cart:', pid);
               var qtyEl = document.getElementById('quantityInput');
               var qty = 1;
               if (qtyEl) {
                   qty = parseInt(qtyEl.value) || 1;
               }

               // Prefer to send variant_id when available
               var params = 'pid=' + encodeURIComponent(pid) + '&quantity=' + encodeURIComponent(qty);
               if (typeof selectedVariant !== 'undefined' && selectedVariant && selectedVariant.variantId) {
                   params += '&variant_id=' + encodeURIComponent(selectedVariant.variantId);
               } else if (typeof selectedColorId !== 'undefined' && selectedColorId && typeof selectedSizeId !== 'undefined' && selectedSizeId) {
                   params += '&color=' + encodeURIComponent(selectedColorId) + '&size=' + encodeURIComponent(selectedSizeId);
               }

               var url = 'addtocart?' + params;

               fetch(url)
                   .then(function(response) {
                       console.log('Response status:', response.status);
                       return response.text();
                   })
                   .then(function(text) {
                       console.log('Response text:', text);
                       try {
                           var data = JSON.parse(text);
                           console.log('Parsed data:', data);

                           if (data.success) {
                               showToast(data.message, 'success');
                               if (redirectToCheckout) {
                                   // After adding, go to checkout
                                   window.location.href = 'checkout';
                               }
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
                           console.error('JSON parse error:', e);
                           showToast('Có lỗi xảy ra', 'error');
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

           // wire buy now button to add with redirect
           document.getElementById('buyNowBtn').addEventListener('click', function(e){
               e.preventDefault();
               addToCart('${detail.id}', true);
           });
       </script>
    </body>
</html>