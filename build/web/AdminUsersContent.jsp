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
        color: white !important;
        border: none;
        font-weight: 700;
        border-radius: 30px; 
    }
    .btn-kid-cart:hover {
        background-color: #C2185B;
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

    /* Badge "Có" */
    .badge-kid-success {
        background-color: #A5D6A7; /* Xanh lá nhạt */
        color: #2E7D32; /* Xanh lá đậm */
        border-radius: 10px;
        padding: 5px 10px;
    }
    
    /* Badge "Không" */
    .badge-kid-secondary {
        background-color: #FCE4EC; /* Hồng nhạt */
        color: #AD1457; /* Hồng đậm */
        border-radius: 10px;
        padding: 5px 10px;
    }

    /* Thông báo lỗi */
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
    <i class="fas fa-users"></i>
    <span>Quản lý người dùng</span>
</div>

<div class="content-card">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4>Danh sách người dùng</h4>
        <button type="button" class="btn btn-kid-cart" data-toggle="modal" data-target="#addUserModal">
            <i class="fas fa-user-plus"></i> Thêm người dùng
        </button>
    </div>
    
    <c:if test="${not empty error}">
        <div class="alert alert-kid-danger">${error}</div>
    </c:if>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="thead-kid">
                <tr>
                    <th>ID</th>
                    <th>Tên đăng nhập</th>
                    <th>Số điện thoại</th>
                    <th>Gmail</th>
                    <th>Người bán</th>
                    <th>Role</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="a">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.user}</td>
                        <td>${a.phone != null && !a.phone.isEmpty() ? a.phone : 'N/A'}</td>
                        <td>${a.email != null && !a.email.isEmpty() ? a.email : 'N/A'}</td>
                        <td>
                            <c:if test="${a.isSell == 1}">
                                <span class="badge badge-kid-success">Có</span>
                            </c:if>
                            <c:if test="${a.isSell == 0}">
                                <span class="badge badge-kid-secondary">Không</span>
                            </c:if>
                        </td>
                        <td>
                            <form action="updateuserrole" method="post" style="display: inline;" id="roleForm${a.id}">
                                <input type="hidden" name="uid" value="${a.id}">
                                <select name="role" class="form-control form-control-sm" 
                                        style="width: auto; display: inline-block; min-width: 100px;"
                                        onchange="updateRole(${a.id}, this.value)">
                                    <option value="user" ${a.isAdmin == 0 ? 'selected' : ''}>User</option>
                                    <option value="admin" ${a.isAdmin == 1 ? 'selected' : ''}>Admin</option>
                                </select>
                                <input type="hidden" name="isAdmin" id="isAdmin${a.id}">
                            </form>
                        </td>
                        <td>
                            <a href="deleteuser?uid=${a.id}" class="btn btn-sm btn-kid-danger" 
                               onclick="return confirm('Bạn chắc chắn muốn xóa?')">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm người dùng mới</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <form action="adduser" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Tên đăng nhập *</label>
                        <input type="text" class="form-control" name="user" required>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại *</label>
                        <input type="tel" class="form-control" name="phone" pattern="[0-9]{10,11}" required>
                    </div>
                    <div class="form-group">
                        <label>Gmail *</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu *</label>
                        <input type="password" class="form-control" name="pass" required>
                    </div>
                    <div class="form-group">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isSell" id="isSell" checked>
                            <label class="form-check-label" for="isSell">
                                Người bán (mặc định: Có)
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Role *</label>
                        <select class="form-control" name="role" required>
                            <option value="admin" selected>Admin</option>
                            <option value="user">User</option>
                        </select>
                        <input type="hidden" name="isAdmin" id="modalIsAdmin">
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

<script>
    function updateRole(userId, role) {
        var isAdmin = role === 'admin' ? 1 : 0;
        document.getElementById('isAdmin' + userId).value = isAdmin;
        document.getElementById('roleForm' + userId).submit();
    }
    
    // Xử lý role trong modal
    $(document).ready(function() {
        $('select[name="role"]').on('change', function() {
            var role = $(this).val();
            var isAdmin = role === 'admin' ? 1 : 0;
            $('#modalIsAdmin').val(isAdmin);
        });
        
        // Set giá trị mặc định khi modal mở
        $('#addUserModal').on('show.bs.modal', function() {
            $('#modalIsAdmin').val(1); // Mặc định là Admin
        });
    });
</script>