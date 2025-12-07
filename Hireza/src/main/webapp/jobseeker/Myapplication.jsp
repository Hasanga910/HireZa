<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Navigation styles */
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
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color:#1e3a8a;
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

        :root {
            --primary-color: #007bff;
            --secondary-color: #00a0dc;
            --accent-color: #f3f2ef;
            --text-dark: #000000de;
            --border-color: #e9ecef;
            --success-color: #059669;
            --warning-color: #d97706;
            --pending-color: #0891b2;
            --rejected-color: #dc2626;
            --text-muted: #6b7280;
            --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            line-height: 1.6;
            min-height: 100vh;
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

        /* Professional Content Styles */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #5b80f3 100%);
            color: white;
            padding: 2.5rem 2rem;
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

        .page-header h2 {
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-header h2::before {
            content: '\f0c2';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
            position: relative;
        }

        .applications-section {
            margin-top: 2rem;
        }

        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: white;
        }

        .stat-icon.total {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }

        .stat-icon.pending {
            background: linear-gradient(135deg, var(--pending-color), #0ea5e9);
        }

        .stat-icon.approved {
            background: linear-gradient(135deg, var(--success-color), #10b981);
        }

        .stat-icon.rejected {
            background: linear-gradient(135deg, var(--rejected-color), #ef4444);
        }

        .stat-content h5 {
            margin: 0 0 0.25rem 0;
            color: #1f2937;
            font-weight: 600;
            font-size: 1.75rem;
        }

        .stat-content p {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.9rem;
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
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(59, 130, 246, 0.1);
        }

        .job-card:hover::before {
            transform: scaleY(1);
        }

        .job-header {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            gap: 1rem;
        }

        .job-title {
            color: #1f2937;
            font-weight: 700;
            font-size: 1.375rem;
            margin-bottom: 0;
            line-height: 1.3;
            flex: 1;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .status-pending {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: var(--pending-color);
            border: 1px solid rgba(8, 145, 178, 0.2);
        }

        .status-approved, .status-accepted {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: var(--success-color);
            border: 1px solid rgba(5, 150, 105, 0.2);
        }

        .status-rejected {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: var(--rejected-color);
            border: 1px solid rgba(220, 38, 38, 0.2);
        }

        .job-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
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

        .resume-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 0.75rem 1.25rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .resume-link:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .empty-state {
            background: white;
            border-radius: 16px;
            padding: 4rem 2rem;
            text-align: center;
            border: 2px dashed #e5e7eb;
            margin-top: 2rem;
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--text-muted);
            margin-bottom: 1.5rem;
            opacity: 0.6;
        }

        .empty-state h4 {
            color: #374151;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .empty-state p {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .cta-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .cta-button:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .page-header {
                padding: 2rem 1.5rem;
            }

            .page-header h2 {
                font-size: 1.75rem;
            }

            .job-card {
                padding: 1.5rem;
            }

            .job-meta {
                grid-template-columns: 1fr;
            }

            .job-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .stats-overview {
                grid-template-columns: 1fr;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/jobseeker/Myapplication">My Applications</a>
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
        <h2>My Applied Jobs</h2>
        <p>Track and manage all your job applications in one place</p>
    </div>

    <c:if test="${not empty appliedJobs}">
        <!-- Stats Overview with Dynamic Data -->
        <div class="stats-overview">
            <div class="stat-card">
                <div class="stat-icon total">
                    <i class="fas fa-briefcase"></i>
                </div>
                <div class="stat-content">
                    <h5>${totalApplications}</h5>
                    <p>Total Applications</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon pending">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h5>${pendingCount}</h5>
                    <p>Pending Review</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon approved">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-content">
                    <h5>${approvedCount}</h5>
                    <p>Approved</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon rejected">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-content">
                    <h5>${rejectedCount}</h5>
                    <p>Rejected</p>
                </div>
            </div>
        </div>

        <!-- Applications List -->
        <div class="applications-section">
            <c:forEach var="job" items="${appliedJobs}">
                <div class="job-card">
                    <div class="job-header">
                        <h5 class="job-title">${job.jobTitle}</h5>
                        <span class="status-badge status-${job.status.toLowerCase()}">${job.status}</span>
                    </div>

                    <div class="job-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span><strong>Applied:</strong> ${job.appliedAt}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-info-circle"></i>
                            <span><strong>Status:</strong> ${job.status}</span>
                        </div>
                    </div>

                    <c:if test="${not empty job.resumeFile}">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                <i class="fas fa-paperclip me-1"></i>
                                Resume attached
                            </div>
                            <a href="${pageContext.request.contextPath}/${job.resumeFile}"
                               class="resume-link" target="_blank">
                                <i class="fas fa-eye"></i>
                                View Resume
                            </a>
                        </div>
                    </c:if>

                    <div class="mt-2 d-flex gap-2">
                        <!-- Delete Form -->
                        <form action="${pageContext.request.contextPath}/DeleteApplicationServlet" method="post"
                              onsubmit="return confirm('Are you sure you want to delete this application?');">
                            <input type="hidden" name="applicationId" value="${job.applicationId}" />
                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                <i class="fas fa-trash me-1"></i> Delete
                            </button>
                        </form>

                        <!-- Update Form -->
                        <form action="${pageContext.request.contextPath}/EditApplicationServlet" method="get">
                            <input type="hidden" name="id" value="${job.applicationId}" />
                            <button type="submit" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-edit me-1"></i> Update
                            </button>
                        </form>
                    </div>
                </div> <!-- End job-card -->
            </c:forEach>
        </div> <!-- End applications-section -->

    </c:if>

    <c:if test="${empty appliedJobs}">
        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <h4>No Applications Yet</h4>
            <p>You haven't applied to any jobs yet. Start exploring opportunities and take the next step in your career!</p>
            <a href="${pageContext.request.contextPath}/search-jobs" class="cta-button">
                <i class="fas fa-search"></i>
                Browse Jobs
            </a>
        </div>
    </c:if>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>