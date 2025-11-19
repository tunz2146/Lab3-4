<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Yêu Thích - ${user.fullname}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .user-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
        }
        .video-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .video-poster {
            height: 200px;
            background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 4rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="user-header">
        <div class="container">
            <div class="d-flex align-items-center">
                <div class="bg-white rounded-circle p-3 me-3">
                    <i class="bi bi-person-circle text-primary" style="font-size: 3rem;"></i>
                </div>
                <div>
                    <h1 class="mb-1">${user.fullname}</h1>
                    <p class="mb-0"><i class="bi bi-envelope me-2"></i>${user.email}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <h2 class="mb-4">
            <i class="bi bi-heart-fill text-danger me-2"></i>
            Video Yêu Thích 
            <span class="badge bg-primary">${favorites.size()}</span>
        </h2>

        <c:choose>
            <c:when test="${empty favorites}">
                <div class="alert alert-info text-center py-5">
                    <i class="bi bi-info-circle" style="font-size: 3rem;"></i>
                    <h4 class="mt-3">Chưa có video yêu thích</h4>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach items="${favorites}" var="favorite">
                        <div class="col-md-4">
                            <div class="card video-card h-100">
                                <div class="video-poster">
                                    <i class="bi bi-play-circle-fill"></i>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${favorite.video.title}</h5>
                                    <p class="text-muted small mb-2">
                                        <i class="bi bi-eye me-1"></i>${favorite.video.views} lượt xem
                                    </p>
                                    <p class="card-text text-muted small">
                                        ${favorite.video.description}
                                    </p>
                                </div>
                                <div class="card-footer bg-transparent">
                                    <small class="text-muted">
                                        <i class="bi bi-calendar-event me-1"></i>
                                        Yêu thích: <fmt:formatDate value="${favorite.likeDate}" pattern="dd/MM/yyyy"/>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="text-center mt-5">
            <a href="<%=request.getContextPath()%>/all-favorites" class="btn btn-primary btn-lg">
                <i class="bi bi-table me-2"></i>Xem tất cả favorites
            </a>
            <a href="<%=request.getContextPath()%>/" class="btn btn-outline-secondary btn-lg">
                <i class="bi bi-house me-2"></i>Trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>