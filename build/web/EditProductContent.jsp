<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .content-card {
        background: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    .edit-form {
        max-width: 800px;
        margin: 0 auto;
    }
</style>

<div class="page-title">
    <i class="fas fa-edit"></i>
    <span>Sửa sản phẩm</span>
</div>

<div class="content-card">
    <div class="edit-form">
        <form action="edit" method="post">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-pencil-alt"></i> Thông tin sản phẩm</h5>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label><strong>ID</strong></label>
                        <input value="${detail.id}" name="id" type="text" class="form-control" readonly required>
                    </div>
                    <div class="form-group">
                        <label><strong>Tên sản phẩm</strong></label>
                        <input value="${detail.name}" name="name" type="text" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label><strong>Link hình ảnh</strong></label>
                        <input value="${detail.image}" name="image" type="text" class="form-control" required>
                        <c:if test="${not empty detail.image}">
                            <img src="${detail.image}" alt="${detail.name}" style="max-width: 200px; margin-top: 10px; border-radius: 5px;" onerror="this.style.display='none'">
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label><strong>Giá</strong></label>
                        <input value="${detail.price}" name="price" type="text" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label><strong>Tiêu đề</strong></label>
                        <textarea name="title" class="form-control" rows="3" required>${detail.title}</textarea>
                    </div>
                    <div class="form-group">
                        <label><strong>Mô tả</strong></label>
                        <textarea name="description" class="form-control" rows="5" required>${detail.description}</textarea>
                    </div>
                    <div class="form-group">
                        <label><strong>Danh mục</strong></label>
                        <select name="category" class="form-control" required>
                            <c:forEach items="${listCC}" var="o">
                                <option value="${o.cid}" ${detail != null && detail.cateID == o.cid ? 'selected' : ''}>${o.cname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="admindashboard?page=products" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Hủy
                    </a>
                    <button type="submit" class="btn btn-primary ml-2">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
