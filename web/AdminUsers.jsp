<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý người dùng - Admin</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-users"></i> Quản lý người dùng</h2>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal">
                    <i class="fas fa-user-plus"></i> Thêm người dùng
                </button>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
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
                                            <span class="badge badge-success">Có</span>
                                        </c:if>
                                        <c:if test="${a.isSell == 0}">
                                            <span class="badge badge-secondary">Không</span>
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
                                        <a href="deleteuser?uid=${a.id}" class="btn btn-sm btn-danger" 
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
            <a href="manager" class="btn btn-secondary mt-3">← Quay lại</a>
        </div>
        
        <!-- Modal Thêm người dùng -->
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
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
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
    </body>
</html>

