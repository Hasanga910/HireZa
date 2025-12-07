<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="dao.CompanyDAO" %>
<%@ page import="model.JobPost" %>
<%@ page import="model.Company" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%
    // Check if user is logged in
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    // Generate initials for avatar
    String initials = "AA";
    if (loggedInUser.getFullName() != null && !loggedInUser.getFullName().trim().isEmpty()) {
        String[] names = loggedInUser.getFullName().trim().split("\\s+");
        StringBuilder initialsBuilder = new StringBuilder();
        for (int i = 0; i < Math.min(2, names.length); i++) {
            if (!names[i].isEmpty()) {
                initialsBuilder.append(names[i].charAt(0));
            }
        }
        initials = initialsBuilder.toString().toUpperCase();
    }

    // Get ONLY approved job posts from database using the dedicated method
    JobPostDAO jobPostDAO = new JobPostDAO();
    CompanyDAO companyDAO = new CompanyDAO();
    List<JobPost> approvedJobPosts = jobPostDAO.getApprovedJobPosts();

    // Create date formatters
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date today = new Date();
    Calendar cal = Calendar.getInstance();
    cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
    cal.set(Calendar.HOUR_OF_DAY, 0);
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0);
    cal.set(Calendar.MILLISECOND, 0);
    Date weekStart = cal.getTime();

    String todayStr = dateFormat.format(today);

    // Calculate statistics for the boxes
    int totalApproved = 0;
    int todayApproved = 0;
    int thisWeekApproved = 0;

    if (approvedJobPosts != null) {
        totalApproved = approvedJobPosts.size();

        for (JobPost post : approvedJobPosts) {
            if (post.getCreatedAt() != null) {
                try {
                    Date postDate = new Date(post.getCreatedAt().getTime());
                    String postDateStr = dateFormat.format(postDate);

                    if (postDateStr.equals(todayStr)) {
                        todayApproved++;
                    }

                    if (!postDate.before(weekStart)) {
                        thisWeekApproved++;
                    }
                } catch (Exception e) {
                    System.err.println("Error processing date for job: " + e.getMessage());
                }
            }
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

    // Helper method to escape HTML for safe display
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    // Helper method to format text for display (replace underscores)
    private String formatForDisplay(String text) {
        if (text == null || text.trim().isEmpty()) {
            return "N/A";
        }
        return text.replace("_", " ");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Approved Job Posts</title>

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
        /* Remove the horizontal line below the logo */
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

        /* Statistics Cards Styles - Updated to match Pending job posts */
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

        .stats-card.total-approved {
            background: linear-gradient(135deg, #d1fae5 0%, #d5fae9 100%);
            color: #065f46;
        }

        .stats-card.today-approved {
            background: linear-gradient(135deg, #dbeafe 0%, #e0f0ff 100%);
            color: #1e40af;
        }

        .stats-card.week-approved {
            background: linear-gradient(135deg, #f0fdf4 0%, #f3fdf6 100%);
            color: #16a34a;
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

        .stats-card.total-approved .stats-icon {
            background-color: #10b981;
            color: #065f46;
            box-shadow: 0 4px 8px rgba(16, 185, 129, 0.3);
        }

        .stats-card.today-approved .stats-icon {
            background-color: #3b82f6;
            color: #1e40af;
            box-shadow: 0 4px 8px rgba(59, 130, 246, 0.3);
        }

        .stats-card.week-approved .stats-icon {
            background-color: #16a34a;
            color: #f0fdf4;
            box-shadow: 0 4px 8px rgba(22, 163, 74, 0.3);
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
            z-index: 9999;
            min-width: 300px;
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

        /* Job details styling */
        .job-details {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 4px;
        }

        .job-details .separator {
            margin: 0 6px;
            color: #adb5bd;
        }

        /* Additional custom styles */
        .badge {
            font-size: 0.75rem;
            padding: 0.35em 0.65em;
        }

        .table td {
            vertical-align: middle;
        }

        .status-badge {
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-badge.active {
            background-color: #d1fae5;
            color: #065f46;
        }

        .pagination .page-link {
            color: var(--color-primary);
            border-color: var(--color-border-primary);
        }

        .pagination .page-item.active .page-link {
            background-color: var(--color-primary);
            border-color: var(--color-primary);
        }

        .pagination .page-link:hover {
            color: var(--color-primary-hover);
            background-color: var(--color-hover-light);
            border-color: var(--color-border-hover);
        }

        /* Responsive improvements */
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
            <a href="Approved-job-posts.jsp" class="nav-link active">
                <i class="fas fa-check-circle"></i>
                <span class="nav-text">Approved Posts</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="Rejected-job-posts.jsp" class="nav-link">
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
            <h1 class="page-title" id="pageTitle">Approved Job Posts</h1>
        </div>
        <div class="navbar-right">
            <div class="admin-profile" id="adminProfile">
                <div class="d-flex align-items-center">
                    <div class="profile-avatar"><%= initials %></div>
                    <div class="profile-info me-3">
                        <h6><%= loggedInUser.getFullName() != null ? loggedInUser.getFullName() : loggedInUser.getUsername() %></h6>
                        <small><%= loggedInUser.getRole() %></small>
                    </div>
                    <i class="fas fa-chevron-down profile-chevron" id="profileChevron"></i>
                </div>

                <!-- Dropdown Menu -->
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <h6><%= loggedInUser.getFullName() != null ? loggedInUser.getFullName() : loggedInUser.getUsername() %></h6>
                        <small><%= loggedInUser.getEmail() %></small>
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
        <!-- Header Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-check-circle me-2"></i>Approved Job Posts</h2>
            <p>Manage and monitor all approved job posts. Send confirmation notifications and track post performance.</p>
        </div>

        <!-- Statistics Cards - Updated to match Pending job posts -->
        <div class="stats-grid">
            <div class="stats-card total-approved">
                <div class="stats-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stats-number" id="totalApproved"><%= totalApproved %></div>
                <div class="stats-label">Total Approved</div>
                <div class="view-details">
                    View All <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card today-approved">
                <div class="stats-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stats-number" id="todayApproved"><%= todayApproved %></div>
                <div class="stats-label">Approved Today</div>
                <div class="view-details">
                    View Today <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card week-approved">
                <div class="stats-icon">
                    <i class="fas fa-calendar-week"></i>
                </div>
                <div class="stats-number" id="weekApproved"><%= thisWeekApproved %></div>
                <div class="stats-label">This Week</div>
                <div class="view-details">
                    View This Week <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <!-- Approved Job Posts Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Approved Job Posts</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-container">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Industry</th>
                            <th>Posted Date</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody id="approvedJobsTable">
                        <%
                            if (approvedJobPosts.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-4">
                                <i class="fas fa-info-circle fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No approved job posts found.</p>
                            </td>
                        </tr>
                        <%
                        } else {
                            SimpleDateFormat displayDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                            for (JobPost post : approvedJobPosts) {
                                // Double-check that this post is actually approved
                                if (!"approved".equals(post.getStatus())) {
                                    continue;
                                }

                                // Format the date
                                String postedDate = "";
                                if (post.getCreatedAt() != null) {
                                    postedDate = displayDateFormat.format(new java.util.Date(post.getCreatedAt().getTime()));
                                }

                                // Get company industry
                                String industry = "Not Specified";
                                try {
                                    if (post.getCompanyId() != null && !post.getCompanyId().trim().isEmpty()) {
                                        Company company = companyDAO.getCompanyByCompanyId(post.getCompanyId());
                                        if (company != null && company.getIndustry() != null && !company.getIndustry().trim().isEmpty()) {
                                            industry = company.getIndustry();
                                        }
                                    }
                                } catch (Exception e) {
                                    System.err.println("Error fetching company industry for companyId " + post.getCompanyId() + ": " + e.getMessage());
                                }

                                String badgeClass = getIndustryBadgeClass(industry);
                        %>
                        <tr>
                            <td class="text-truncate" title="<%= escapeHtml(formatForDisplay(post.getJobTitle())) %>">
                                <strong><%= escapeHtml(formatForDisplay(post.getJobTitle())) %></strong><br>
                                <small class="text-muted">
                                    <%= escapeHtml(formatForDisplay(post.getEmploymentType())) %> &bull;
                                    <%= escapeHtml(formatForDisplay(post.getWorkMode())) %> &bull;
                                    <%= escapeHtml(formatForDisplay(post.getSalaryRange())) %>
                                </small>
                            </td>
                            <td><%= escapeHtml(formatForDisplay(post.getCompanyName())) %></td>
                            <td><span class="badge <%= badgeClass %>"><%= escapeHtml(formatForDisplay(industry)) %></span></td>
                            <td><%= postedDate %></td>
                            <td><span class="status-badge active">Approved</span></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer d-flex justify-content-between align-items-center">
                <div class="text-muted">
                    Showing <%= approvedJobPosts.size() %> approved job posts
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Store user data from JSP
    const currentUser = {
        id: '<%= loggedInUser.getId() %>',
        fullName: '<%= loggedInUser.getFullName() != null ? loggedInUser.getFullName().replace("'", "\\'") : "" %>',
        username: '<%= loggedInUser.getUsername().replace("'", "\\'") %>',
        email: '<%= loggedInUser.getEmail().replace("'", "\\'") %>',
        role: '<%= loggedInUser.getRole().replace("'", "\\'") %>',
        initials: '<%= initials %>'
    };

    document.addEventListener('DOMContentLoaded', () => {
        initializePage();
        setupSidebar();
        setupProfileDropdown();
        animateCounters();

        // Show loading overlay briefly for better UX
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
            }, 800);
        }
    });

    function initializePage() {
        setActiveNavigation();
        console.log('Approved Job Posts page initialized for user:', currentUser.username);
    }

    function setupSidebar() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('expanded');
            });
        }
    }

    function setupProfileDropdown() {
        const adminProfile = document.getElementById('adminProfile');
        const profileDropdown = document.getElementById('profileDropdown');
        const profileChevron = document.getElementById('profileChevron');

        if (adminProfile && profileDropdown) {
            adminProfile.addEventListener('click', (e) => {
                e.stopPropagation();
                profileDropdown.classList.toggle('show');
                profileChevron.classList.toggle('rotated');
            });

            document.addEventListener('click', (e) => {
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
            if (link.getAttribute('href') === 'Approved-job-posts.jsp') {
                link.classList.add('active');
            }
        });
    }

    function updatePageTitle() {
        const pageTitle = document.getElementById('pageTitle');
        if (pageTitle) {
            pageTitle.textContent = 'Approved Job Posts';
        }
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
</script>
</body>
</html>