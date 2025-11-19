<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê Chia Sẻ - PolyOE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        .page-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 3rem 0;
        }
        .stats-box {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 30px;
        }
        .stats-box i {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .stats-box h3 {
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <div class="page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="display-4">
                        <i class="bi bi-share-fill me-3"></i>
                        Thống Kê Chia Sẻ Video
                    </h1>
                    <p class="lead">Tổng hợp các video đã được chia sẻ</p>
                </div>
                <div class="text-end">
                    <c:if test="${not empty sessionScope.currentUser}">
                        <div class="text-white">
                            <i class="bi bi-person-circle fs-3"></i><br>
                            <small>${sessionScope.currentUser.fullname}</small>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-box border-start border-success border-5">
                    <i class="bi bi-share text-success"></i>
                    <h3 class="text-success">${shares.size()}</h3>
                    <p class="text-muted mb-0">Tổng lượt chia sẻ</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-box border-start border-primary border-5">
                    <i class="bi bi-people text-primary"></i>
                    <h3 class="text-primary" id="uniqueUsers">0</h3>
                    <p class="text-muted mb-0">Người chia sẻ</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-box border-start border-warning border-5">
                    <i class="bi bi-film text-warning"></i>
                    <h3 class="text-warning" id="uniqueVideos">0</h3>
                    <p class="text-muted mb-0">Video được chia sẻ</p>
                </div>
            </div>
        </div>

        <!-- Data Table -->
        <div class="card shadow">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0">
                    <i class="bi bi-table me-2"></i>
                    Chi Tiết Chia Sẻ
                    <span class="badge bg-success float-end">${shares.size()} records</span>
                </h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty shares}">
                        <div class="alert alert-info text-center py-5">
                            <i class="bi bi-info-circle" style="font-size: 3rem;"></i>
                            <h4 class="mt-3">Chưa có dữ liệu chia sẻ</h4>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table id="sharesTable" class="table table-hover table-striped align-middle">
                                <thead class="table-success">
                                    <tr>
                                        <th width="5%">#</th>
                                        <th width="30%">
                                            <i class="bi bi-film me-1"></i>Video
                                        </th>
                                        <th width="25%">
                                            <i class="bi bi-person me-1"></i>Người chia sẻ
                                        </th>
                                        <th width="25%">
                                            <i class="bi bi-envelope me-1"></i>Email nhận
                                        </th>
                                        <th width="15%">
                                            <i class="bi bi-calendar-event me-1"></i>Ngày chia sẻ
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${shares}" var="share" varStatus="status">
                                        <tr>
                                            <td class="fw-bold text-muted">${status.count}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-play-circle-fill text-success me-2" 
                                                       style="font-size: 1.5rem;"></i>
                                                    <div>
                                                        <div class="fw-bold">${share.video.title}</div>
                                                        <small class="text-muted">
                                                            ID: ${share.video.id}
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person-circle text-primary me-2" 
                                                       style="font-size: 2rem;"></i>
                                                    <div>
                                                        <div>${share.user.fullname}</div>
                                                        <small class="text-muted">${share.user.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <i class="bi bi-envelope text-success me-1"></i>
                                                <span class="badge bg-light text-dark">${share.email}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-success">
                                                    <fmt:formatDate value="${share.shareDate}" 
                                                                    pattern="dd/MM/yyyy HH:mm"/>
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

        <!-- Navigation -->
        <div class="text-center mt-4">
            <a href="<%=request.getContextPath()%>/all-favorites" class="btn btn-primary">
                <i class="bi bi-heart-fill me-2"></i>Xem Favorites
            </a>
            <a href="<%=request.getContextPath()%>/" class="btn btn-outline-secondary">
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
            // Initialize DataTable
            $('#sharesTable').DataTable({
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
                order: [[4, 'desc']]
            });
            
            // Calculate unique users and videos
            var users = new Set();
            var videos = new Set();
            
            <c:forEach items="${shares}" var="share">
                users.add('${share.user.id}');
                videos.add('${share.video.id}');
            </c:forEach>
            
            $('#uniqueUsers').text(users.size);
            $('#uniqueVideos').text(videos.size);
        });
    </script>
</body>
</html>