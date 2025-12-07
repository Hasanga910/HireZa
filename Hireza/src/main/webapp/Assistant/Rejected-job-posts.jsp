<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="dao.CompanyDAO" %>
<%@ page import="model.JobPost" %>
<%@ page import="model.Company" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Enhanced session and error handling
    User loggedInUser = null;
    List<JobPost> rejectedJobPosts = new ArrayList<>();
    int totalRejected = 0;
    int todayRejected = 0;
    int thisWeekRejected = 0;
    String errorMessage = null;

    try {
        // Check if user is logged in with null safety
        loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Initialize DAOs with proper error handling
        JobPostDAO jobPostDAO = null;
        CompanyDAO companyDAO = null;

        try {
            jobPostDAO = new JobPostDAO();
            companyDAO = new CompanyDAO();
        } catch (Exception e) {
            System.err.println("Error initializing DAOs: " + e.getMessage());
            errorMessage = "Database connection error. Please try again later.";
            throw e;
        }

        // Get ONLY rejected job posts from database with error handling
        try {
            rejectedJobPosts = jobPostDAO.getRejectedJobPosts();
            if (rejectedJobPosts == null) {
                rejectedJobPosts = new ArrayList<>();
            }
        } catch (Exception e) {
            System.err.println("Error fetching rejected job posts: " + e.getMessage());
            rejectedJobPosts = new ArrayList<>();
            errorMessage = "Error loading job posts. Please try again.";
        }

        // Get counts for statistics
        totalRejected = rejectedJobPosts.size();

        // Create date formatters with error handling
        if (!rejectedJobPosts.isEmpty()) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date today = new java.util.Date();
                String todayStr = dateFormat.format(today);

                // Calculate start of week (Monday)
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.set(java.util.Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
                cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                cal.set(java.util.Calendar.MINUTE, 0);
                cal.set(java.util.Calendar.SECOND, 0);
                cal.set(java.util.Calendar.MILLISECOND, 0);
                java.util.Date weekStart = cal.getTime();

                // Count today's and this week's rejected posts
                for (JobPost post : rejectedJobPosts) {
                    if (post != null && post.getCreatedAt() != null) {
                        try {
                            java.util.Date postDate = new java.util.Date(post.getCreatedAt().getTime());
                            String postDateStr = dateFormat.format(postDate);

                            if (postDateStr.equals(todayStr)) {
                                todayRejected++;
                            }

                            if (!postDate.before(weekStart)) {
                                thisWeekRejected++;
                            }
                        } catch (Exception e) {
                            System.err.println("Error processing date for post: " + e.getMessage());
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("Error calculating statistics: " + e.getMessage());
            }
        }

    } catch (Exception e) {
        System.err.println("Critical error in rejected job posts page: " + e.getMessage());
        errorMessage = "A system error occurred. Please contact support.";
        rejectedJobPosts = new ArrayList<>();
    }

    // Generate initials for avatar with null safety
    String initials = "AA";
    if (loggedInUser != null && loggedInUser.getFullName() != null && !loggedInUser.getFullName().trim().isEmpty()) {
        try {
            String[] names = loggedInUser.getFullName().trim().split("\\s+");
            StringBuilder initialsBuilder = new StringBuilder();
            for (int i = 0; i < Math.min(2, names.length); i++) {
                if (names[i] != null && !names[i].isEmpty()) {
                    initialsBuilder.append(names[i].charAt(0));
                }
            }
            if (initialsBuilder.length() > 0) {
                initials = initialsBuilder.toString().toUpperCase();
            }
        } catch (Exception e) {
            System.err.println("Error generating initials: " + e.getMessage());
        }
    }
%>

<%!
    // Helper method to determine badge class based on industry
    private String getIndustryBadgeClass(String industry) {
        if (industry == null || "Not Specified".equals(industry)) return "bg-secondary";

        String industryLower = industry.toLowerCase();

        if (industryLower.contains("technology") || industryLower.contains("tech") ||
                industryLower.contains("software") || industryLower.contains("it") ||
                industryLower.contains("computer") || industryLower.contains("information")) {
            return "bg-primary";
        } else if (industryLower.contains("marketing") || industryLower.contains("advertising") ||
                industryLower.contains("sales") || industryLower.contains("brand") ||
                industryLower.contains("digital")) {
            return "bg-success";
        } else if (industryLower.contains("finance") || industryLower.contains("banking") ||
                industryLower.contains("accounting") || industryLower.contains("investment") ||
                industryLower.contains("financial")) {
            return "bg-warning text-dark";
        } else if (industryLower.contains("health") || industryLower.contains("medical") ||
                industryLower.contains("care") || industryLower.contains("hospital") ||
                industryLower.contains("pharmaceutical")) {
            return "bg-danger";
        } else if (industryLower.contains("education") || industryLower.contains("school") ||
                industryLower.contains("university") || industryLower.contains("training") ||
                industryLower.contains("academic")) {
            return "bg-info";
        } else if (industryLower.contains("manufacturing") || industryLower.contains("production") ||
                industryLower.contains("construction") || industryLower.contains("engineering") ||
                industryLower.contains("industrial")) {
            return "bg-dark";
        } else if (industryLower.contains("retail") || industryLower.contains("e-commerce") ||
                industryLower.contains("commerce") || industryLower.contains("shop") ||
                industryLower.contains("consumer")) {
            return "bg-secondary";
        } else if (industryLower.contains("consulting") || industryLower.contains("professional") ||
                industryLower.contains("services")) {
            return "bg-primary";
        } else if (industryLower.contains("media") || industryLower.contains("entertainment") ||
                industryLower.contains("creative") || industryLower.contains("design")) {
            return "bg-info";
        } else if (industryLower.contains("food") || industryLower.contains("beverage") ||
                industryLower.contains("restaurant") || industryLower.contains("hospitality")) {
            return "bg-warning text-dark";
        } else if (industryLower.contains("transport") || industryLower.contains("logistics") ||
                industryLower.contains("shipping") || industryLower.contains("delivery")) {
            return "bg-dark";
        } else {
            return "bg-light text-dark";
        }
    }

    private String formatForDisplay(String text) {
        if (text == null || text.trim().isEmpty()) {
            return "N/A";
        }
        return text.replace("_", " ");
    }

    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rejected Job Posts</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/assistant.css">

    <style>
        /* nav bar border remove */
        .top-navbar,
        .sidebar,
        .content-area,
        .table {
            border: none !important;
            box-shadow: none !important;
        }
        .sidebar-brand {
            border-bottom: none !important;
        }

        /* Loading Overlay Styles */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-overlay.show {
            display: flex !important;
        }

        .loading-spinner {
            text-align: center;
        }

        /* Statistics Cards Styles - Matching Dashboard.jsp */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: center;
            position: relative;
            cursor: pointer;
            border: none;
            overflow: hidden;
            text-decoration: none;
        }

        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #3b82f6, #1e40af);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .stats-card:hover::before {
            transform: scaleX(1);
        }

        .stats-card.total-rejected {
            background: linear-gradient(135deg, #fee2e2 0%, #fee7e7 100%);
            color: #991b1b;
        }

        .stats-card.today-rejected {
            background: linear-gradient(135deg, #fef3c7 0%, #fef7cd 100%);
            color: #92400e;
        }

        .stats-card.week-rejected {
            background: linear-gradient(135deg, #dbeafe 0%, #e0f0ff 100%);
            color: #1e40af;
        }

        .stats-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 15px;
            transition: transform 0.3s ease;
        }

        .stats-card:hover .stats-icon {
            transform: scale(1.1);
        }

        .stats-card.total-rejected .stats-icon {
            background-color: #ef4444;
            color: #991b1b;
            box-shadow: 0 4px 8px rgba(239, 68, 68, 0.3);
        }

        .stats-card.today-rejected .stats-icon {
            background-color: #fbbf24;
            color: #92400e;
            box-shadow: 0 4px 8px rgba(251, 191, 36, 0.3);
        }

        .stats-card.week-rejected .stats-icon {
            background-color: #3b82f6;
            color: #1e40af;
            box-shadow: 0 4px 8px rgba(59, 130, 246, 0.3);
        }

        .stats-number {
            font-size: 2.8rem;
            font-weight: bold;
            margin: 15px 0;
            transition: transform 0.3s ease;
        }

        .stats-card:hover .stats-number {
            transform: scale(1.05);
        }

        .stats-label {
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .view-details {
            font-size: 0.9rem;
            font-weight: 600;
            margin-top: 10px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }

        .stats-card:hover .view-details {
            transform: translateX(5px);
        }

        /* Custom alert styles */
        .custom-alert {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 10000;
            min-width: 300px;
            max-width: 500px;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .alert-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .alert-close {
            background: none;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }

        .error-alert {
            border-left: 4px solid #dc3545;
        }

        .bg-purple {
            background-color: #6f42c1 !important;
        }

        .status-badge.rejected {
            color: #8B0000 !important;
            background-color: #FFE6E6 !important;
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-weight: bold;
            border: 1px solid #FFB3B3;
        }

        .rejection-reason-plain {
            color: #dc3545 !important;
            font-weight: bold;
            background: none !important;
            border: none !important;
            padding: 0 !important;
            font-size: 0.85rem;
        }

        /* Table column widths */
        #rejectedJobsTable {
            table-layout: fixed;
            width: 100%;
            border-collapse: collapse;
        }

        #rejectedJobsTable th:nth-child(1),
        #rejectedJobsTable td:nth-child(1) {
            width: 22% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 22% !important;
        }

        #rejectedJobsTable th:nth-child(2),
        #rejectedJobsTable td:nth-child(2) {
            width: 18% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 18% !important;
        }

        #rejectedJobsTable th:nth-child(3),
        #rejectedJobsTable td:nth-child(3) {
            width: 15% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 15% !important;
        }

        #rejectedJobsTable th:nth-child(4),
        #rejectedJobsTable td:nth-child(4) {
            width: 12% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 12% !important;
        }

        #rejectedJobsTable th:nth-child(5),
        #rejectedJobsTable td:nth-child(5) {
            width: 18% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 18% !important;
        }

        #rejectedJobsTable th:nth-child(6),
        #rejectedJobsTable td:nth-child(6) {
            width: 15% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 15% !important;
        }

        #rejectedJobsTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 0.75rem;
            vertical-align: middle;
        }

        .table-container {
            overflow-x: auto;
            width: 100%;
        }

        .status-badge {
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .job-details {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 4px;
        }

        .job-details .separator {
            margin: 0 6px;
            color: #adb5bd;
        }

        .badge {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
            display: inline-block;
        }

        @media (max-width: 768px) {
            .table-responsive {
                font-size: 0.875rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
        }

        @media (max-width: 576px) {
            .card-header .d-flex {
                flex-direction: column;
                gap: 10px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner">
        <i class="fas fa-spinner fa-spin fa-3x text-primary mb-3"></i>
        <p class="h5">Loading...</p>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="#" class="sidebar-brand">
        <img src="../images/index/favicon.png" alt="HireZa Logo">
        <span class="brand-text">HireZa</span>
    </a>

    <ul class="sidebar-nav">
        <li class="nav-header">Dashboard</li>
        <li class="nav-item">
            <a href="Dashboard.jsp" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Overview</span>
            </a>
        </li>

        <li class="nav-header">Job Post Management</li>
        <li class="nav-item">
            <a href="Pending-job-posts.jsp" class="nav-link">
                <i class="fas fa-clock"></i>
                <span class="nav-text">Pending Posts</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="Approved-job-posts.jsp" class="nav-link">
                <i class="fas fa-check-circle"></i>
                <span class="nav-text">Approved Posts</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="Rejected-job-posts.jsp" class="nav-link active">
                <i class="fas fa-times-circle"></i>
                <span class="nav-text">Rejected Posts</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/ExpiredJobPostsServlet" class="nav-link">
                <i class="fas fa-calendar-times"></i>
                <span class="nav-text">Expired Posts</span>
            </a>
        </li>

        <li class="nav-header">Settings</li>
        <li class="nav-item">
            <a href="Settings.jsp" class="nav-link">
                <i class="fas fa-cog"></i>
                <span class="nav-text">Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content" id="mainContent">
    <!-- Top Navbar -->
    <div class="top-navbar">
        <div class="navbar-left">
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1 class="page-title" id="pageTitle">Rejected Job Posts</h1>
        </div>
        <div class="navbar-right">
            <div class="admin-profile" id="adminProfile">
                <div class="d-flex align-items-center">
                    <div class="profile-avatar"><%= initials %></div>
                    <div class="profile-info me-3">
                        <h6><%= loggedInUser != null && loggedInUser.getFullName() != null ? escapeHtml(loggedInUser.getFullName()) : (loggedInUser != null ? escapeHtml(loggedInUser.getUsername()) : "Guest") %></h6>
                        <small><%= loggedInUser != null ? escapeHtml(loggedInUser.getRole()) : "Guest" %></small>
                    </div>
                    <i class="fas fa-chevron-down profile-chevron" id="profileChevron"></i>
                </div>

                <!-- Dropdown Menu -->
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <h6><%= loggedInUser != null && loggedInUser.getFullName() != null ? escapeHtml(loggedInUser.getFullName()) : (loggedInUser != null ? escapeHtml(loggedInUser.getUsername()) : "Guest") %></h6>
                        <small><%= loggedInUser != null ? escapeHtml(loggedInUser.getEmail()) : "" %></small>
                    </div>
                    <div class="dropdown-menu-custom">
                        <a href="Settings.jsp" class="dropdown-item-custom">
                            <i class="fas fa-cog"></i>
                            Settings
                        </a>
                        <div class="dropdown-divider-custom"></div>
                        <button class="dropdown-item-custom logout-item" onclick="handleLogout()">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger error-alert mb-4">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <%= escapeHtml(errorMessage) %>
        </div>
        <% } %>

        <!-- Header Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-times-circle me-2"></i>Rejected Job Posts</h2>
            <p>Review rejected job posts, send feedback to employers, and manage data cleanup processes.</p>
        </div>

        <!-- Statistics Cards - Updated to match Dashboard.jsp style -->
        <div class="stats-grid">
            <div class="stats-card total-rejected">
                <div class="stats-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stats-number" id="totalRejected"><%= totalRejected %></div>
                <div class="stats-label">Total Rejected</div>
                <div class="view-details">
                    View All <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card today-rejected">
                <div class="stats-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stats-number" id="todayRejected"><%= todayRejected %></div>
                <div class="stats-label">Rejected Today</div>
                <div class="view-details">
                    View Details <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card week-rejected">
                <div class="stats-icon">
                    <i class="fas fa-calendar-week"></i>
                </div>
                <div class="stats-number" id="weekRejected"><%= thisWeekRejected %></div>
                <div class="stats-label">This Week</div>
                <div class="view-details">
                    View Details <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <!-- Rejected Job Posts Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Rejected Job Posts</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-container" id="tableContainer">
                    <table class="table mb-0" id="rejectedJobsTable">
                        <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Industry</th>
                            <th>Posted Date</th>
                            <th>Rejection Reason</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            if (rejectedJobPosts.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-4">
                                <i class="fas fa-info-circle fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No rejected job posts found.</p>
                            </td>
                        </tr>
                        <%
                        } else {
                            SimpleDateFormat displayDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            for (JobPost post : rejectedJobPosts) {
                                if (post == null) continue;

                                if (!"rejected".equalsIgnoreCase(post.getStatus())) {
                                    continue;
                                }

                                try {
                                    String postedDate = "";
                                    if (post.getCreatedAt() != null) {
                                        postedDate = displayDateFormat.format(new java.util.Date(post.getCreatedAt().getTime()));
                                    }

                                    String industry = "Not Specified";
                                    try {
                                        if (post.getCompanyId() != null && !post.getCompanyId().trim().isEmpty()) {
                                            CompanyDAO companyDAO = new CompanyDAO();
                                            Company company = companyDAO.getCompanyByCompanyId(post.getCompanyId());
                                            if (company != null && company.getIndustry() != null && !company.getIndustry().trim().isEmpty()) {
                                                industry = company.getIndustry();
                                            }
                                        }
                                    } catch (Exception e) {
                                        System.err.println("Error fetching company industry for companyId " + post.getCompanyId() + ": " + e.getMessage());
                                    }

                                    String badgeClass = getIndustryBadgeClass(industry);

                                    // Get rejection reason from AdminNotes
                                    String rejectionReason = post.getAdminNotes();
                                    if (rejectionReason == null || rejectionReason.trim().isEmpty() || "No notes provided".equals(rejectionReason)) {
                                        rejectionReason = "No reason provided";
                                    }
                        %>
                        <tr data-job-id="<%= post.getJobId() %>">
                            <td class="text-truncate" title="<%= escapeHtml(post.getJobTitle()) %>">
                                <strong><%= escapeHtml(post.getJobTitle()) %></strong><br>
                                <small class="text-muted job-details">
                                    <%= escapeHtml(post.getEmploymentType() != null ? post.getEmploymentType() : "Not specified") %><span class="separator">&bull;</span><%= escapeHtml(post.getWorkMode() != null ? post.getWorkMode() : "Not specified") %><span class="separator">&bull;</span><%= escapeHtml(post.getSalaryRange() != null ? post.getSalaryRange() : "Salary not specified") %>
                                </small>
                            </td>
                            <td class="text-truncate" title="<%= escapeHtml(post.getCompanyName()) %>">
                                <%= escapeHtml(post.getCompanyName()) %>
                            </td>
                            <td><span class="badge <%= badgeClass %>"><%= escapeHtml(industry) %></span></td>
                            <td><%= postedDate %></td>
                            <td>
                                <span class="rejection-reason-plain"
                                      data-bs-toggle="tooltip"
                                      data-bs-placement="top"
                                      title="<%= escapeHtml(rejectionReason) %>">
                                    <%= rejectionReason.length() > 30 ? escapeHtml(rejectionReason.substring(0, 30)) + "..." : escapeHtml(rejectionReason) %>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <button class="btn btn-outline-danger btn-sm" onclick="deletePost('<%= post.getJobId() %>')" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                                    } catch (Exception e) {
                                        System.err.println("Error processing job post " + (post != null ? post.getId() : "unknown") + ": " + e.getMessage());
                                    }
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer d-flex justify-content-between align-items-center">
                <div class="text-muted">
                    Showing <%= rejectedJobPosts.size() %> rejected job posts
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-trash me-2"></i>Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this rejected job post? This action cannot be undone.</p>
                <p class="text-danger"><strong>Warning:</strong> All data associated with this job post will be permanently removed.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete Permanently</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
    const currentUser = {
        id: '<%= loggedInUser != null ? loggedInUser.getId() : "" %>',
        fullName: '<%= loggedInUser != null && loggedInUser.getFullName() != null ? loggedInUser.getFullName().replace("'", "\\'") : "" %>',
        username: '<%= loggedInUser != null ? loggedInUser.getUsername().replace("'", "\\'") : "Guest" %>',
        email: '<%= loggedInUser != null ? loggedInUser.getEmail().replace("'", "\\'") : "" %>',
        role: '<%= loggedInUser != null ? loggedInUser.getRole().replace("'", "\\'") : "Guest" %>',
        initials: '<%= initials %>'
    };

    let currentJobId = null;

    document.addEventListener('DOMContentLoaded', function() {
        console.log('Initializing Rejected Job Posts page...');

        initializePage();
        setupSidebar();
        setupProfileDropdown();

        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
                animateCounters();
            }, 800);
        }

        console.log('Page initialization complete.');
    });

    function initializePage() {
        setActiveNavigation();
        console.log('Rejected Job Posts page initialized for user:', currentUser.username);
    }

    function setupSidebar() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        if (sidebarToggle && sidebar && mainContent) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('expanded');
            });
        }
    }

    function setupProfileDropdown() {
        const adminProfile = document.getElementById('adminProfile');
        const profileDropdown = document.getElementById('profileDropdown');
        const profileChevron = document.getElementById('profileChevron');

        if (adminProfile && profileDropdown && profileChevron) {
            adminProfile.addEventListener('click', function(e) {
                e.stopPropagation();
                profileDropdown.classList.toggle('show');
                profileChevron.classList.toggle('rotated');
            });

            document.addEventListener('click', function(e) {
                if (!adminProfile.contains(e.target)) {
                    profileDropdown.classList.remove('show');
                    profileChevron.classList.remove('rotated');
                }
            });
        }
    }

    function setActiveNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === 'Rejected-job-posts.jsp') {
                link.classList.add('active');
            }
        });
    }

    function animateCounters() {
        const counters = document.querySelectorAll('.stats-number');
        counters.forEach(counter => {
            counter.style.opacity = '0.7';
            setTimeout(() => {
                counter.style.opacity = '1';
            }, Math.random() * 1000 + 500);
        });
    }

    function showLoading() {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
        }
    }

    function hideLoading() {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.remove('show');
        }
    }

    function showAlert(message, type) {
        const existingAlerts = document.querySelectorAll('.custom-alert');
        existingAlerts.forEach(alert => alert.remove());

        const alertDiv = document.createElement('div');
        alertDiv.className = `custom-alert alert-${type}`;
        alertDiv.innerHTML = `
            <div class="alert-content">
                <span class="alert-message">${message}</span>
                <button class="alert-close" onclick="this.parentElement.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;

        document.body.appendChild(alertDiv);

        setTimeout(() => {
            if (alertDiv.parentElement) {
                alertDiv.remove();
            }
        }, 5000);
    }

    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {
            showLoading();

            setTimeout(() => {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/LogoutServlet';
                document.body.appendChild(form);
                form.submit();
            }, 500);
        }
    }

    function deletePost(jobId) {
        currentJobId = jobId;
        console.log('Attempting to delete job post with ID:', jobId);

        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        modal.show();

        const confirmBtn = document.getElementById('confirmDeleteBtn');
        // Remove any existing event listeners
        confirmBtn.replaceWith(confirmBtn.cloneNode(true));

        // Get the new button reference
        const newConfirmBtn = document.getElementById('confirmDeleteBtn');
        newConfirmBtn.onclick = function() {
            performDelete(jobId);
            modal.hide();
        };
    }

    function performDelete(jobId) {
        showLoading();
        console.log('Deleting job post:', jobId);

        $.ajax({
            url: '../DeleteRejectJobPostServlet',
            type: 'POST',
            data: {
                jobId: jobId
            },
            dataType: 'json',
            success: function(response) {
                console.log('Delete response:', response);

                if (response.success) {
                    showAlert('Job post deleted successfully! Refreshing page...', 'success');

                    // Wait a moment for the user to see the success message, then reload
                    setTimeout(function() {
                        window.location.reload();
                    }, 1000);

                } else {
                    hideLoading();
                    showAlert(response.message || 'Failed to delete job post.', 'error');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Delete error:', error);
                console.log('Response text:', xhr.responseText);

                try {
                    const errorResponse = JSON.parse(xhr.responseText);
                    showAlert(errorResponse.message || 'Error deleting job post. Please try again.', 'error');
                } catch (e) {
                    showAlert('Error deleting job post. Please try again.', 'error');
                }
            }
        });
    }

    function updateFooterCount() {
        const tableBody = document.querySelector('#rejectedJobsTable tbody');
        const dataRows = tableBody.querySelectorAll('tr:not([style*="display"]):not(:has(td[colspan]))');
        const footerText = document.querySelector('.card-footer .text-muted');

        if (footerText) {
            if (dataRows.length === 0) {
                footerText.textContent = 'Showing 0 rejected job posts';
            } else {
                footerText.textContent = `Showing ${dataRows.length} rejected job posts`;
            }
        }
    }

    function updateStatistics(change) {
        const totalElement = document.getElementById('totalRejected');
        const todayElement = document.getElementById('todayRejected');
        const weekElement = document.getElementById('weekRejected');

        if (totalElement) {
            const currentTotal = parseInt(totalElement.textContent) || 0;
            const newTotal = Math.max(0, currentTotal + change);
            totalElement.textContent = newTotal;

            // Add animation effect
            totalElement.style.transform = 'scale(1.2)';
            setTimeout(() => {
                totalElement.style.transform = 'scale(1)';
            }, 300);
        }
    }
</script>
</body>
</html>