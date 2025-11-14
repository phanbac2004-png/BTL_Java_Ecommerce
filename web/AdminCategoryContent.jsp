<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    /* Tiêu đề bảng */
    .thead-kid {
        background-color: #F06292; /* Màu hồng chính */
        color: white;
    }
    
    /* Nút chính (Thêm, Lưu) */
    .btn-kid-cart {
        background-color: #EC407A;
        color: white;
        border: none;
        font-weight: 700;
        border-radius: 30px; 
    }
    .btn-kid-cart:hover {
        background-color: #C2185B;
        color: white;
    }
    
    /* Nút Sửa (Viền) */
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
    <i class="fas fa-tags"></i>
    <span>Quản lý danh mục</span>
</div>

<div class="content-card">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4>Danh sách danh mục</h4>
        <button type="button" class="btn btn-kid-cart" data-toggle="modal" data-target="#addCategoryModal">
            <i class="fas fa-plus"></i> Thêm danh mục
        </button>
    </div>
    
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-kid-danger alert-dismissible fade show">
            ${errorMsg}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    </c:if>
    
    <c:if test="${not empty successMsg}">
        <div class="alert alert-kid-success alert-dismissible fade show">
            ${successMsg}
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    </c:if>
    
    <c:remove var="errorMsg" scope="session"/>
    <c:remove var="successMsg" scope="session"/>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="thead-kid">
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="c">
                    <tr>
                        <td><strong>${c.cid}</strong></td>
                        <td>${c.cname}</td>
                        <td>
                            <button type="button" class="btn btn-kid-outline btn-sm" 
                                    data-toggle="modal" 
                                    data-target="#editCategoryModal${c.cid}"
                                    data-cid="${c.cid}"
                                    data-cname="${c.cname}">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <a href="deletecategory?cid=${c.cid}" 
                               class="btn btn-kid-danger btn-sm ml-1" 
                               onclick="return confirm('Bạn chắc chắn muốn xóa danh mục \"${c.cname}\"?\n\nLưu ý: Không thể xóa nếu còn sản phẩm đang sử dụng danh mục này.')">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="mt-3 text-muted small">
         Tổng số danh mục: <strong>${list.size()}</strong>
    </div>
</div>

<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm danh mục mới</h5>
                <button type="button" class="close" data-dismiss="modal">
                     <span>&times;</span>
                </button>
            </div>
            <form action="addcategory" method="post">
                <div class="modal-body">
                    <div class="form-group">
                         <label>Tên danh mục *</label>
                        <input type="text" class="form-control" name="cname" required 
                               placeholder="Ví dụ: Áo len & Áo nỉ" maxlength="50">
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

<c:forEach items="${list}" var="c">
<div class="modal fade" id="editCategoryModal${c.cid}" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa danh mục</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <form action="updatecategory" method="post">
                <div class="modal-body">
                    <input type="hidden" name="cid" value="${c.cid}">
                    <div class="form-group">
                        <label>Tên danh mục *</label>
                        <input type="text" class="form-control" name="cname" 
                               value="${c.cname}" required maxlength="50">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-kid-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-kid-cart">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:forEach>