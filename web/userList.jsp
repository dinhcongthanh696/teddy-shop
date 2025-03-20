<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Quản lý Người Dùng</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            #userTable_wrapper{
                margin-top: 100px;
                margin-bottom: 50px;
            }
            .btn {
                border-radius: 6px;
                color: white;
                transition: all 0.2s ease-in-out;
            }

            .btn:hover {
                transform: scale(1.05);
            }

            /* Button sửa */
            .btn-primary {
                background-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            /* Button xóa */
            .btn-danger {
                background-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #b21f2d;
            }

            .modal{
                margin-top: 100px;
            }
        </style>
    </head>
    <body>
        <h2>Danh sách Người Dùng</h2>

        <!-- Lưu JSON vào input hidden -->
        <input type="hidden" id="usersData" value='${usersJson}' />
        <input type="hidden" id="roles" value='${rolesJSON}' />
        <jsp:include page="/gui/header.jsp"></jsp:include>
            <table id="userTable" class="display">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <button class="btn btn-success">Add new user</button>
            <!-- Modal Add User -->
            <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addUserForm">
                                <div class="form-group">
                                    <label for="addUserName">User Name</label>
                                    <input type="text" class="form-control" id="addUserName" required>
                                </div>
                                <div class="form-group">
                                    <label for="addEmail">Email</label>
                                    <input type="email" class="form-control" id="addEmail" required>
                                </div>
                                <div class="form-group">
                                    <label for="addPhoneNumber">Phone Number</label>
                                    <input type="text" class="form-control" id="addPhoneNumber" required>
                                </div>
                                <div class="form-group">
                                    <label for="addRole">Role</label>
                                    <select class="form-control" id="addRole">
                                    <c:forEach var="role" items="${roles}">
                                        <option value="${role.id}">${role.roleName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="saveNewUser">Save</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Edit User -->
        <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editUserModalLabel">Chỉnh sửa thông tin người dùng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editUserForm">
                            <input type="hidden" id="editUserId">
                            <div class="mb-3">
                                <label for="editUserName" class="form-label">Username</label>
                                <input type="text" class="form-control" id="editUserName">
                            </div>
                            <div class="mb-3">
                                <label for="editEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="editEmail">
                            </div>
                            <div class="mb-3">
                                <label for="editPhoneNumber" class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="editPhoneNumber">
                            </div>
                            <div class="mb-3">
                                <label for="editRole" class="form-label">Role</label>
                                <select class="form-select" id="editRole"></select>
                            </div>
                            <button type="button" class="btn btn-primary" id="saveUserChanges">Lưu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="gui/footer.jsp" />
        <script>
            $(document).ready(function () {
                $(".btn-success").click(function () {
                    $("#addUserModal").modal("show");
                });
                $('#saveNewUser').click(function () {
                    let newUser = {
                        action: "add",
                        userName: $('#addUserName').val(),
                        email: $('#addEmail').val(),
                        phoneNumber: $('#addPhoneNumber').val(),
                        roleId: $('#addRole').val()
                    };

                    $.ajax({
                        type: "POST",
                        url: "users",
                        data: JSON.stringify(newUser),
                        contentType: "application/json",
                        success: function (response) {
                            alert("User added successfully!");
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            alert("User addition fail!");
                            location.reload();
                        }
                    });
                });
                let rolesJson = $("#roles").val();
                let usersJson = $("#usersData").val(); // Lấy JSON từ input hidden
                let users = JSON.parse(usersJson); // Parse thành object
                let roles = JSON.parse(rolesJson);
                $('#userTable').DataTable({
                    data: users,
                    columns: [
                        {"data": "id"},
                        {"data": "userName"},
                        {"data": "email"},
                        {"data": "phoneNumber"},
                        {"data": "roleName"},
                        {
                            "data": null, // Chuyển "data": "id" thành null
                            "render": function (data, type, row) {
                                return '<button class="btn btn-sm btn-primary editUserBtn" ' + 'data-id=' + data.id + '>Sửa</button> ' +
                                        '<button class="btn btn-sm btn-danger" onclick="deleteUser(' + data.id + ')">Xóa</button>';
                            }
                        }
                    ]
                });
                // Khi bấm nút sửa
                $(document).on('click', '.editUserBtn', function () {
                    let userId = $(this).data('id');
                    let user = users.find(u => u.id == userId);

                    $('#editUserId').val(user.id);
                    $('#editUserName').val(user.userName);
                    $('#editEmail').val(user.email);
                    $('#editPhoneNumber').val(user.phoneNumber);
                    let roleSelect = $('#editRole');
                    roleSelect.empty();
                    console.log(roles);
                    roles.forEach(role => {
                        let selected = role.id === user.roleId ? 'selected' : '';
                        console.log(role.id + ' and ' + user.roleId + ' and ' + selected);
                        roleSelect.append('<option value="' + role.id + '" ' + selected + '>' + role.roleName + '</option>');
                    });
                    console.log($('#editUserModal').length);
                    $('#editUserModal').modal('show');
                });

                // Khi bấm lưu thay đổi
                $('#saveUserChanges').click(function () {
                    let updatedUser = {
                        action: "edit",
                        id: $('#editUserId').val(),
                        userName: $('#editUserName').val(),
                        email: $('#editEmail').val(),
                        phoneNumber: $('#editPhoneNumber').val(),
                        roleId: $('#editRole').val()
                    };

                    $.ajax({
                        type: "POST",
                        url: "users",
                        data: JSON.stringify(updatedUser),
                        contentType: "application/json",
                        success: function (response) {
                            alert("Cập nhật thành công!");
                            location.reload();
                        }
                    });
                });
            });

            function deleteUser(id) {
                if (confirm("Bạn có chắc muốn xóa người dùng này?")) {
                    $.post("users", {action: "delete", id: id}, function () {
                        location.reload(); // Reload lại trang sau khi xóa
                    });
                }
            }

        </script>
    </body>
</html>
