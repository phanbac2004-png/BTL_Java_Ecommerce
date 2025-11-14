<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
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
    
    /* Tiêu đề bảng tùy chỉnh */
    .table-title-kid {
        padding: 15px 20px;
        background: #F06292; /* Màu hồng chính */
        color: #fff;
        margin: -25px -25px 20px -25px;
        border-radius: 15px 15px 0 0; /* Bo góc trên */
    }
    .table-title-kid h4 {
        font-weight: 700;
    }
    
    /* Tiêu đề bảng */
    .thead-kid {
        background-color: #F06292; /* Màu hồng chính */
        color: white;
    }
    
    /* Hình ảnh sản phẩm */
    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 10px; /* Bo tròn */
    }

    /* Nút chính (Thêm, Lưu) */
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
    
    /* Nút Sửa/Reset/Sắp xếp (Viền) */
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
    
    /* Nút Hủy (Xám) */
    .btn-kid-secondary {
        background-color: #e0e0e0;
        border-color: #e0e0e0;
        color: #555;
        font-weight: 700;
        border-radius: 30px;
    }
    
    /* Thông báo lỗi/thành công */
    .alert-kid-success {
        color: #AD1457;
        background-color: #FCE4EC;
        border-color: #F06292;
        border-radius: 10px;
    }
    .alert-kid-danger {
        color: #880E4F;
        background-color: #F8BBD0;
        border-color: #e91e63;
        border-radius: 10px;
    }
    
    /* Modal */
    .modal-content {
        border-radius: 15px;
        font-family: 'Nunito', sans-serif;
        border: none;
    }
    .modal-header {
        background-color: #FCE4EC;
        color: #C2185B;
        font-weight: 700;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
    }
    .form-control:focus {
        border-color: #F06292;
        box-shadow: 0 0 0 0.2rem rgba(236, 64, 122, 0.25);
    }

</style>
<div class="page-title">
    <i class="fas fa-box"></i>
    <span>Quản lý sản phẩm</span>
</div>

<div class="content-card">
    <div class="table-title-kid">
        <div class="d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Danh sách sản phẩm</h4>
            <div>
                <a href="reorganizeproductid" class="btn btn-light btn-sm mr-2" 
                   onclick="return confirm('Bạn có muốn sắp xếp lại tất cả ID sản phẩm về liên tục (1, 2, 3, ...) không?\n\n⚠️ Cảnh báo: Điều này sẽ thay đổi tất cả ID hiện tại!')"
                   title="Sắp xếp lại ID thành liên tục">
                    <i class="fas fa-sort-numeric-down"></i> Sắp xếp ID
                </a>
                <a href="resetproductid" class="btn btn-light btn-sm mr-2" 
                   onclick="return confirm('Bạn có muốn reset AUTO_INCREMENT về đúng giá trị không?\n\nĐiều này sẽ đảm bảo ID tiếp theo không bị nhảy số.')"
                   title="Reset AUTO_INCREMENT để ID liên tục">
                    <i class="fas fa-sync-alt"></i> Reset ID
                </a>
                <button type="button" class="btn btn-light btn-sm" data-toggle="modal" data-target="#addEmployeeModal">
                    <i class="fas fa-plus"></i> Thêm sản phẩm
                </button>
            </div>
        </div>
    </div>
    
    <c:if test="${not empty successMsg}">
        <div class="alert alert-kid-success alert-dismissible fade show mt-3">
            ${successMsg}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    </c:if>
    
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-kid-danger alert-dismissible fade show mt-3">
            ${errorMsg}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    </c:if>
    
    <c:remove var="successMsg" scope="session"/>
    <c:remove var="errorMsg" scope="session"/>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="thead-kid">
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Giá</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listP}" var="o">
                    <tr>
                        <td><strong>${o.id}</strong></td>
                        <td>${o.name}</td>
                        <td>
                            <img src="${o.image}" alt="${o.name}" class="product-image" onerror="this.src='https://via.placeholder.com/80'">
                        </td>
                        <td><strong><fmt:formatNumber value="${o.price}" type="number" pattern="#,###"/> đ</strong></td>
                        <td>
                            <a href="loadProduct?pid=${o.id}" class="btn btn-kid-outline btn-sm" title="Edit">
                                <i class="fas fa-edit"></i> Sửa
                            </a>
                            <a href="delete?pid=${o.id}" class="btn btn-kid-danger btn-sm ml-1" 
                               title="Delete" 
                               onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
        <div class="text-muted small">Hiển thị <b>${listP.size()}</b> sản phẩm</div>
    </div>
</div>

<div id="addEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="add" method="post">
                <div class="modal-header">						
                    <h4 class="modal-title">Thêm sản phẩm mới</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <div class="form-group">
                        <label>Tên sản phẩm *</label>
                        <input name="name" type="text" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>URL hình ảnh *</label>
                        <input name="image" type="text" class="form-control" placeholder="https://example.com/image.jpg" required>
                    </div>
                    <div class="form-group">
                        <label>Giá *</label>
                        <input name="price" type="number" step="0.01" class="form-control" placeholder="100.0" required>
                    </div>
                    <div class="form-group">
                        <label>Tiêu đề *</label>
                        <textarea name="title" class="form-control" rows="2" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Mô tả *</label>
                        <textarea name="description" class="form-control" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Danh mục *</label>
                        <select name="category" class="form-control" required>
                            <c:forEach items="${listCC}" var="c">
                                <option value="${c.cid}">${c.cname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-kid-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-kid-cart">Thêm</button>
                </div>
            </form>
        </div>
    </div>
</div>