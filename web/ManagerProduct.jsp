<%-- 
    Document   : ManagerProduct
    Created on : Dec 28, 2020, 5:19:02 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                background: #f8f9fa;
                padding: 20px 0;
            }
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .table-title {
                padding: 15px 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: #fff;
                margin: -20px -20px 20px -20px;
                border-radius: 8px 8px 0 0;
            }
            .table-title h2 {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
            }
            .table-title .btn {
                padding: 8px 16px;
                font-size: 13px;
                margin-left: 8px;
            }
            img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 4px;
            }
            table.table {
                margin-bottom: 0;
            }
            table.table thead th {
                background: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
                font-weight: 600;
                font-size: 13px;
                padding: 12px;
            }
            table.table tbody td {
                padding: 12px;
                vertical-align: middle;
                font-size: 14px;
            }
            table.table tbody tr:hover {
                background: #f8f9fa;
            }
            .back-btn {
                margin-bottom: 20px;
            }
            .btn-sm-custom {
                padding: 8px 12px;
                font-size: 14px;
                margin: 0 4px;
                min-width: 45px;
            }
            .custom-checkbox {
                width: 18px;
                height: 18px;
            }
            .action-buttons {
                white-space: nowrap;
            }
            .btn-edit {
                background-color: #ffd54f;
                border-color: #ffd54f;
                color: #333;
            }
            .btn-edit:hover {
                background-color: #ffca28;
                border-color: #ffca28;
                color: #333;
            }
            .btn-delete-action {
                background-color: #ef5350;
                border-color: #ef5350;
                color: #fff;
            }
            .btn-delete-action:hover {
                background-color: #e57373;
                border-color: #e57373;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <a href="home" class="btn btn-secondary back-btn">
                <i class="fa fa-arrow-left"></i> Back
            </a>
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2>Manage Product</h2>
                        <div>
                            <a href="#addEmployeeModal" class="btn btn-success btn-sm" data-toggle="modal">
                                <i class="material-icons" style="font-size: 18px; vertical-align: middle;">&#xE147;</i> Add New
                            </a>
                            <a href="#deleteEmployeeModal" class="btn btn-danger btn-sm" data-toggle="modal">
                                <i class="material-icons" style="font-size: 18px; vertical-align: middle;">&#xE15C;</i> Delete
                            </a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>
                                <span class="custom-checkbox">
                                    <input type="checkbox" id="selectAll">
                                    <label for="selectAll"></label>
                                </span>
                            </th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listP}" var="o">
                            <tr>
                                <td>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="checkbox1" name="options[]" value="1">
                                        <label for="checkbox1"></label>
                                    </span>
                                </td>
                                <td>${o.id}</td>
                                <td>${o.name}</td>
                                <td>
                                    <img src="${o.image}">
                                </td>
                                <td><fmt:formatNumber value="${o.price}" type="number" pattern="#,###"/> đ</td>
                                <td class="action-buttons">
                                    <a href="loadProduct?pid=${o.id}" class="btn btn-edit btn-sm-custom" title="Edit">
                                        <i class="material-icons" style="font-size: 18px; vertical-align: middle;">&#xE254;</i>
                                        <span style="margin-left: 4px;">Edit</span>
                                    </a>
                                    <a href="delete?pid=${o.id}" class="btn btn-delete-action btn-sm-custom" title="Delete" onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')">
                                        <i class="material-icons" style="font-size: 18px; vertical-align: middle;">&#xE872;</i>
                                        <span style="margin-left: 4px;">Delete</span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                    <div class="text-muted small">Showing <b>${listP.size()}</b> product(s)</div>
                    <nav>
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="add" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input name="image" type="file" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input name="price" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Title</label>
                                <textarea name="title" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category" class="form-select" aria-label="Default select example">
                                    <c:forEach items="${listCC}" var="o">
                                        <option value="${o.cid}">${o.cname}</option>
                                    </c:forEach>
                                </select>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Edit Employee</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" class="form-control" required>
                            </div>					
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Delete Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/manager.js" type="text/javascript"></script>
        <script>
            // Đảm bảo dropdown hoạt động
            $(document).ready(function() {
                $('.dropdown-toggle').on('click', function(e) {
                    e.preventDefault();
                    $(this).next('.dropdown-menu').toggle();
                });
                
                // Đóng dropdown khi click ra ngoài
                $(document).on('click', function(e) {
                    if (!$(e.target).closest('.dropdown').length) {
                        $('.dropdown-menu').hide();
                    }
                });
            });
        </script>
    </body>
</html>