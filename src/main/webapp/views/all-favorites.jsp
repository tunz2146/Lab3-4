
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Video Yêu Thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }
    </style>
</head>
<body class="bg-light">
    <div class="page-header">
        <div class="container">
            <h1 class="display-4">
                <i class="bi bi-heart-fill me-3"></i>
                Danh Sách Video Yêu Thích
            </h1>
            <p class="lead">Tất cả các video đã được yêu thích</p>
        </div>
    </div>

    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0">
                    <i class="bi bi-table me-2"></i>
                    Bảng Thông Tin Chi Tiết
                    <span class="badge bg-primary float-end">${favorites.size()} records</span>
                </h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty favorites}">
                        <div class="alert alert-info text-center py-5">
                            <i class="bi bi-info-circle" style="font-size: 3rem;"></i>
                            <h4 class="mt-3">Chưa có dữ liệu</h4>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table id="favoritesTable" class="table table-hover table-striped align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th width="5%">#</th>
                                        <th width="40%">
                                            <i class="bi bi-film me-1"></i>Video Title
                                        </th>
                                        <th width="35%">
                                            <i class="bi bi-person me-1"></i>Người thích
                                        </th>
                                        <th width="20%">
                                            <i class="bi bi-calendar-event me-1"></i>Ngày thích
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${favorites}" var="favorite" varStatus="status">
                                        <tr>
                                            <td class="fw-bold text-muted">${status.count}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-play-circle-fill text-primary me-2" 
                                                       style="font-size: 1.5rem;"></i>
                                                    <div>
                                                        <div class="fw-bold">${favorite.video.title}</div>
                                                        <small class="text-muted">
                                                            <i class="bi bi-eye me-1"></i>
                                                            ${favorite.video.views} views
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person-circle text-primary me-2" 
                                                       style="font-size: 2rem;"></i>
                                                    <div>
                                                        <div>${favorite.user.fullname}</div>
                                                        <small class="text-muted">${favorite.user.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">
                                                    <fmt:formatDate value="${favorite.likeDate}" 
                                                                    pattern="dd/MM/yyyy"/>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/" class="btn btn-outline-primary">
                <i class="bi bi-house me-2"></i>Trang chủ
            </a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#favoritesTable').DataTable({
                language: {
                    search: "Tìm kiếm:",
                    lengthMenu: "Hiển thị _MENU_ dòng",
                    info: "Hiển thị _START_ đến _END_ của _TOTAL_ dòng",
                    paginate: {
                        first: "Đầu",
                        last: "Cuối",
                        next: "Sau",
                        previous: "Trước"
                    }
                },
                pageLength: 10,
                order: [[3, 'desc']]
            });
        });
    </script>
</body>
</html>