<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
    uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8" />
            <title>Category Management</title>
            <link
                rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                />
            <link
                rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"
                />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <style>
                body {
                    background-color: #f9ece6;
                    font-family: "Inter", sans-serif;
                }
                .container {
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    margin-top: 20px;
                    margin-bottom: 20px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                }
            </style>
        </head>
        <body style="margin-top: 80px">
            <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>
            <c:if test="${not empty sessionScope.notification}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                    ${sessionScope.notification}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                    session.removeAttribute("notification");
                %>
            </c:if>
            <c:if test="${not empty sessionScope.notificationErr}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                    ${sessionScope.notificationErr}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                    session.removeAttribute("notificationErr");
                %>
            </c:if>
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Category Management</h2>
                    <button
                        class="btn btn-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#addCategoryModal"
                        >
                        <i class="bi bi-plus-circle"></i> Add New Category
                    </button>
                </div>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categories}" var="category">
                            <tr>
                                <td>${category.id}</td>
                                <td>${category.name}</td>

                                <td>
                                    <button
                                        class="btn btn-sm btn-warning"
                                        onclick="editCategory(${category.id}, '${category.name}')"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editCategoryModal"
                                        >
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button
                                        class="btn btn-sm bg-danger text-light"
                                        onclick="toggleStatus(${category.id})"
                                        >
                                        🗑
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Add Category Modal -->
                <div class="modal fade" id="addCategoryModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/manager/category-management" method="POST">
                                <input type="hidden" name="action" value="add" />
                                <div class="modal-header">
                                    <h5 class="modal-title">Add New Category</h5>
                                    <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        ></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Category Name</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            name="name"
                                            required
                                            />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                        >
                                        Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        Add Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit Category Modal -->
                <div class="modal fade" id="editCategoryModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="${pageContext.request.contextPath}/manager/category-management" method="POST">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="id" id="editCategoryId" />
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Category</h5>
                                    <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        ></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Category Name</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            name="name"
                                            id="editCategoryName"
                                            required
                                            />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                        >
                                        Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <form id="form-delete" action="${pageContext.request.contextPath}/manager/category-management" method="POST">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="id" id="deleteCategoryId" />

            </form>
            <script>
                function editCategory(id, name) {
                    document.getElementById("editCategoryId").value = id;
                    document.getElementById("editCategoryName").value = name;
                }

                function toggleStatus(id) {
                    if (confirm("Are you sure you want to delete this category?")) {
                        const form = document.getElementById("form-delete");
                        document.getElementById("deleteCategoryId").value = id;

                        form.submit();
                    }
                }
            </script>

            <jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>
        </body>
    </html>
