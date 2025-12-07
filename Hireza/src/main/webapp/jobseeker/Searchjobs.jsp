<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Jobs - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Your existing CSS styles remain the same */
        .navbar {
            background-color: #e9ecef;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e3a8a;
        }

        .nav-link {
            font-weight: 500;
            color: var(--text-dark) !important;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
        }

        .btn-primary {
            background: var(--secondary-color);
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .profile-btn {
            background: var(--secondary-color);
            color: white !important;
            padding: 8px 12px;
            border-radius: 50%;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
        }

        .profile-btn:hover {
            background: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
            color: white !important;
        }

        :root {
            --primary-color: #5f99f6;
            --secondary-color: #00a0dc;
            --accent-color: #f3f2ef;
            --text-dark: #000000de;
            --border-color: #e9ecef;
            --success-color: #059669;
            --warning-color: #d97706;
            --text-muted: #6b7280;
            --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .custom-btn {
            border-color: var(--primary-color) !important;
            color: var(--primary-color) !important;
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
        }

        .custom-btn:hover {
            background-color: var(--primary-color) !important;
            color: white !important;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #5f99f6 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%23ffffff" fill-opacity="0.05"><circle cx="7" cy="7" r="7"/><circle cx="53" cy="53" r="7"/></g></svg>');
            opacity: 0.3;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
        }

        .search-section {
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .search-section h3 {
            color: #1f2937;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-form .form-control {
            padding: 0.875rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #fafafa;
        }

        .search-form .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background-color: white;
        }

        .search-btn {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .jobs-section {
            margin-top: 2rem;
        }

        .section-title {
            color: #1f2937;
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title::after {
            content: '';
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), transparent);
        }

        .job-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            box-shadow: var(--shadow-sm);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(180deg, var(--primary-color), var(--secondary-color));
            transform: scaleY(0);
            transform-origin: bottom;
            transition: transform 0.3s ease;
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(59, 130, 246, 0.1);
        }

        .job-card:hover::before {
            transform: scaleY(1);
        }

        .job-header {
            display: flex;
            justify-content: between;
            align-items: flex-start;
            margin-bottom: 1rem;
            gap: 1rem;
        }

        .job-title {
            color: #1f2937;
            font-weight: 700;
            font-size: 1.375rem;
            margin-bottom: 0.5rem;
            line-height: 1.3;
            flex: 1;
        }

        .job-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .meta-item i {
            width: 16px;
            color: var(--primary-color);
        }

        .company-name {
            font-weight: 600;
            color: #374151;
        }

        .salary {
            color: var(--success-color);
            font-weight: 600;
        }

        .employment-badge {
            display: inline-block;
            background: linear-gradient(135deg, #e0f2fe 0%, #b3e5fc 100%);
            color: #01579b;
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid rgba(1, 87, 155, 0.1);
        }

        .approved-badge {
            display: inline-block;
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid rgba(5, 95, 70, 0.1);
            margin-left: 10px;
        }

        .apply-btn {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .apply-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .no-jobs-card {
            background: white;
            border-radius: 16px;
            padding: 3rem 2rem;
            text-align: center;
            border: 2px dashed #e5e7eb;
            margin-top: 2rem;
        }

        .no-jobs-card i {
            font-size: 3rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
        }

        .no-jobs-card h4 {
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .no-jobs-card p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stats-icon {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stats-content h5 {
            margin: 0 0 0.25rem 0;
            color: #1f2937;
            font-weight: 600;
        }

        .stats-content p {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .page-header {
                padding: 2rem 1.5rem;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .search-section {
                padding: 1.5rem;
            }

            .job-card {
                padding: 1.5rem;
            }

            .job-meta {
                grid-template-columns: 1fr;
            }

            .job-header {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/jobseeker/home.jsp">
            <img src="${pageContext.request.contextPath}/jobseeker/logo.jpg" alt="HireZa Logo" width="40" height="40" class="me-2" />
            HireZa
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/Myapplication">My Applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/search-jobs">Search Jobs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/profile.jsp">My Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/Aboutus.jsp">About Us</a>
                </li>
            </ul>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-primary me-2 custom-btn" href="${pageContext.request.contextPath}/jobseeker/logout">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="main-container">
    <!-- Page Header -->
    <div class="page-header">
        <h1><i class="fas fa-search me-3"></i>Discover Your Next Career Opportunity</h1>
        <p>Find the perfect job that matches your skills and aspirations from top companies</p>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <h3><i class="fas fa-filter me-2"></i>Search & Filter Jobs</h3>
        <form action="${pageContext.request.contextPath}/search-jobs" method="POST" class="search-form">
            <div class="row g-3">
                <div class="col-lg-5 col-md-6">
                    <div class="position-relative">
                        <i class="fas fa-briefcase position-absolute" style="left: 12px; top: 50%; transform: translateY(-50%); color: #6b7280;"></i>
                        <input type="text" class="form-control ps-5" name="keyword"
                               placeholder="Job title, keywords, or company..." value="${param.keyword}">
                    </div>
                </div>
                <div class="col-lg-5 col-md-6">
                    <div class="position-relative">
                        <i class="fas fa-map-marker-alt position-absolute" style="left: 12px; top: 50%; transform: translateY(-50%); color: #6b7280;"></i>
                        <input type="text" class="form-control ps-5" name="location"
                               placeholder="City, state, or remote" value="${param.location}">
                    </div>
                </div>
                <div class="col-lg-2 col-md-12">
                    <button type="submit" class="btn search-btn w-100">
                        <i class="fas fa-search me-2"></i>Search Jobs
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Jobs Results Section -->
    <div class="jobs-section">
        <c:if test="${not empty jobList}">
            <div class="stats-card">
                <div class="stats-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stats-content">
                    <h5>${jobList.size()} Approved Jobs Found</h5>
                    <p>Showing verified opportunities from trusted companies</p>
                </div>
            </div>

            <h2 class="section-title">
                <i class="fas fa-list-alt"></i>
                Available Positions
            </h2>

            <c:forEach var="job" items="${jobList}">
                <div class="job-card">
                    <div class="job-header">
                        <div>
                            <h4 class="job-title">${job.jobTitle}</h4>
                            <div class="d-flex align-items-center mt-1">
                                <c:if test="${not empty job.employmentType}">
                                    <span class="employment-badge">${job.employmentType}</span>
                                </c:if>
                                <span class="approved-badge">
                                    <i class="fas fa-check me-1"></i>Approved
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="job-meta">
                        <div class="meta-item">
                            <i class="fas fa-building"></i>
                            <span class="company-name">${job.companyName}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>${job.location}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-laptop-house"></i>
                            <span>${job.workMode}</span>
                        </div>
                        <c:if test="${not empty job.salaryRange}">
                            <div class="meta-item">
                                <i class="fas fa-dollar-sign"></i>
                                <span class="salary">${job.salaryRange}</span>
                            </div>
                        </c:if>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <div class="text-muted small">
                            <i class="fas fa-clock me-1"></i>
                            Posted recently
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/jobseeker/Jobdetails.jsp?jobId=${job.id}" class="apply-btn btn btn-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>
                                View Details
                            </a>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty jobList}">
            <div class="no-jobs-card">
                <i class="fas fa-search"></i>
                <h4>No Approved Jobs Found</h4>
                <p>We couldn't find any approved jobs matching your criteria. Try adjusting your search terms or check back later for new verified opportunities.</p>
                <div class="mt-3">
                    <small class="text-muted">
                        <i class="fas fa-lightbulb me-1"></i>
                        Tip: Only approved and verified job postings are shown here
                    </small>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>