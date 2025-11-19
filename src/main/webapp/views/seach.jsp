<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm Video - PolyOE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
        .search-container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin: 30px auto;
            max-width: 1200px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        .search-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .search-header h1 {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .search-box {
            position: relative;
            margin-bottom: 30px;
        }
        .search-input {
            width: 100%;
            padding: 20px 60px 20px 25px;
            font-size: 1.1rem;
            border: 3px solid #e0e0e0;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        .search-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .search-btn:hover {
            transform: translateY(-50%) scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
        }
        .filter-btn {
            margin: 5px;
            border-radius: 20px;
            padding: 8px 20px;
            border: 2px solid #667eea;
            background: white;
            color: #667eea;
            transition: all 0.3s ease;
        }
        .filter-btn:hover, .filter-btn.active {
            background: #667eea;
            color: white;
        }
        .video-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            cursor: pointer;
        }
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .video-thumbnail {
            position: relative;
            padding-top: 56.25%; /* 16:9 Aspect Ratio */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
        }
        .video-thumbnail img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .video-duration {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .video-info {
            padding: 20px;
        }
        .video-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .video-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #666;
            font-size: 0.9rem;
        }
        .video-stats {
            display: flex;
            gap: 15px;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .no-results i {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        .badge-custom {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .results-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        .sort-dropdown {
            border-radius: 20px;
            padding: 8px 20px;
            border: 2px solid #667eea;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/">
                <i class="bi bi-film text-primary"></i> PolyOE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/">
                            <i class="bi bi-house-door me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/search">
                            <i class="bi bi-search me-1"></i>Tìm kiếm
                        </a>
                    </li>
                    <c:if test="${not empty sessionScope.currentUser}">
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/user-favorites">
                                <i class="bi bi-heart me-1"></i>Yêu thích
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>${sessionScope.currentUser.fullname}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">
                                    <i class="bi bi-person me-2"></i>Tài khoản
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="<%=request.getContextPath()%>/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${empty sessionScope.currentUser}">
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Container -->
    <div class="search-container">
        <!-- Search Header -->
        <div class="search-header">
            <h1><i class="bi bi-search"></i> Tìm kiếm Video</h1>
            <p class="text-muted">Khám phá hàng ngàn video chất lượng cao</p>
        </div>

        <!-- Search Box -->
        <div class="search-box">
            <form action="<%=request.getContextPath()%>/search" method="get">
                <input type="text" 
                       class="search-input" 
                       name="keyword" 
                       placeholder="Nhập từ khóa tìm kiếm..." 
                       value="${param.keyword}"
                       autofocus>
                <button type="submit" class="search-btn">
                    <i class="bi bi-search me-2"></i>Tìm kiếm
                </button>
            </form>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="d-flex flex-wrap align-items-center">
                <strong class="me-3">Lọc theo:</strong>
                <button class="filter-btn active" data-filter="all">
                    <i class="bi bi-grid-3x3-gap me-1"></i>Tất cả
                </button>
                <button class="filter-btn" data-filter="popular">
                    <i class="bi bi-fire me-1"></i>Phổ biến
                </button>
                <button class="filter-btn" data-filter="latest">
                    <i class="bi bi-clock-history me-1"></i>Mới nhất
                </button>
                <button class="filter-btn" data-filter="favorites">
                    <i class="bi bi-heart-fill me-1"></i>Yêu thích nhiều
                </button>
            </div>
        </div>

        <!-- Results Info -->
        <c:if test="${not empty videos}">
            <div class="results-info">
                <div>
                    <strong>Tìm thấy ${videos.size()} kết quả</strong>
                    <c:if test="${not empty param.keyword}">
                        cho "<span class="text-primary">${param.keyword}</span>"
                    </c:if>
                </div>
                <select class="sort-dropdown form-select w-auto">
                    <option value="relevance">Liên quan nhất</option>
                    <option value="date">Ngày tải lên</option>
                    <option value="views">Lượt xem</option>
                    <option value="rating">Đánh giá</option>
                </select>
            </div>
        </c:if>

        <!-- Video Results Grid -->
        <div class="row">
            <c:choose>
                <c:when test="${not empty videos}">
                    <c:forEach items="${videos}" var="video">
                        <div class="col-md-4 col-lg-3">
                            <div class="video-card" onclick="window.location.href='<%=request.getContextPath()%>/video?id=${video.id}'">
                                <div class="video-thumbnail">
                                    <c:choose>
                                        <c:when test="${not empty video.poster}">
                                            <img src="${video.poster}" alt="${video.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/320x180/667eea/ffffff?text=${video.title}" alt="${video.title}">
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="video-duration">
                                        <c:choose>
                                            <c:when test="${not empty video.duration}">
                                                ${video.duration}
                                            </c:when>
                                            <c:otherwise>
                                                10:30
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="video-info">
                                    <h5 class="video-title">${video.title}</h5>
                                    <p class="text-muted small mb-2">${video.description}</p>
                                    <div class="video-meta">
                                        <div class="video-stats">
                                            <span class="stat-item">
                                                <i class="bi bi-eye-fill text-primary"></i>
                                                <c:choose>
                                                    <c:when test="${not empty video.views}">
                                                        ${video.views}
                                                    </c:when>
                                                    <c:otherwise>
                                                        1.2K
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="stat-item">
                                                <i class="bi bi-heart-fill text-danger"></i>
                                                <c:choose>
                                                    <c:when test="${not empty video.favorites}">
                                                        ${video.favorites.size()}
                                                    </c:when>
                                                    <c:otherwise>
                                                        45
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <c:if test="${video.active}">
                                            <span class="badge badge-custom bg-success">Active</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="no-results">
                            <i class="bi bi-search text-muted"></i>
                            <h3>Không tìm thấy kết quả</h3>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty param.keyword}">
                                        Không tìm thấy video nào phù hợp với "<strong>${param.keyword}</strong>"
                                    </c:when>
                                    <c:otherwise>
                                        Nhập từ khóa để bắt đầu tìm kiếm video
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="<%=request.getContextPath()%>/search" class="btn btn-primary rounded-pill mt-3">
                                <i class="bi bi-arrow-clockwise me-2"></i>Tìm kiếm mới
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty videos and videos.size() > 12}">
            <nav aria-label="Video pagination" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="text-white text-center py-3">
        <div class="container">
            <p class="mb-0">
                <i class="bi bi-code-slash me-2"></i>
                Lab 3 - Lập trình Java #4 | 
                <i class="bi bi-calendar-event me-1"></i>
                <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter buttons functionality
        document.querySelectorAll('.filter-btn').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
                
                const filter = this.getAttribute('data-filter');
                // Add your filter logic here
                console.log('Filter:', filter);
            });
        });

        // Sort dropdown functionality
        document.querySelector('.sort-dropdown')?.addEventListener('change', function() {
            const sortBy = this.value;
            // Add your sort logic here
            console.log('Sort by:', sortBy);
        });
    </script>
</body>
</html>