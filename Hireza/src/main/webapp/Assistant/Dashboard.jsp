<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assistant Dashboard</title>
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

        /* Statistics Cards Styles - Enhanced */
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

        .stats-card.pending {
            background: linear-gradient(135deg, #fef3c7 0%, #fef7cd 100%);
            color: #92400e;
        }

        .stats-card.approved {
            background: linear-gradient(135deg, #d1fae5 0%, #d5fae9 100%);
            color: #065f46;
        }

        .stats-card.rejected {
            background: linear-gradient(135deg, #fee2e2 0%, #fee7e7 100%);
            color: #991b1b;
        }

        .stats-card.reminders {
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

        .stats-card.pending .stats-icon {
            background-color: #fbbf24;
            color: #92400e;
            box-shadow: 0 4px 8px rgba(251, 191, 36, 0.3);
        }

        .stats-card.approved .stats-icon {
            background-color: #10b981;
            color: #065f46;
            box-shadow: 0 4px 8px rgba(16, 185, 129, 0.3);
        }

        .stats-card.rejected .stats-icon {
            background-color: #ef4444;
            color: #991b1b;
            box-shadow: 0 4px 8px rgba(239, 68, 68, 0.3);
        }

        .stats-card.reminders .stats-icon {
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

        /* Additional styles for industry badges */
        .badge {
            font-size: 0.75rem;
            padding: 0.35em 0.65em;
        }

        .status-badge {
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-badge.pending {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-badge.active {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-badge.rejected {
            background-color: #fee2e2;
            color: #991b1b;
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        /* Remove real-time badge styles */
        .real-time-badge {
            display: none !important;
        }

        /* Job details styling - Added to match Pending job posts */
        .job-details {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 4px;
        }

        .job-details .separator {
            margin: 0 6px;
            color: #adb5bd;
        }

        .text-truncate {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
            <a href="Dashboard.jsp" class="nav-link active">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Overview</span>
            </a>
        </li>

        <li class="nav-header">Job Post Management</li>
        <li class="nav-item">
            <a href="Pending-job-posts.jsp" class="nav-link">
                <i class="fas fa-clock"></i>
                <span class="nav-text">Pending Posts</span>
                <!-- Removed the real-time badge -->
            </a>
        </li>
        <li class="nav-item">
            <a href="Approved-job-posts.jsp" class="nav-link">
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
            <h1 class="page-title" id="pageTitle">Dashboard</h1>
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

    <!-- Dashboard Content -->
    <div class="content-area">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-briefcase me-2"></i>Job Post Management Dashboard</h2>
            <p>Welcome back, <%= loggedInUser.getFullName() != null ? loggedInUser.getFullName() : loggedInUser.getUsername() %>! Manage job posts, approve/reject submissions, send reminders, and maintain data efficiently.</p>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <a href="Pending-job-posts.jsp" class="stats-card pending text-decoration-none">
                <div class="stats-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stats-number" id="pendingCount">0</div>
                <div class="stats-label">Pending Posts</div>
                <div class="view-details">
                    View Details <i class="fas fa-arrow-right"></i>
                </div>
            </a>

            <a href="Approved-job-posts.jsp" class="stats-card approved text-decoration-none">
                <div class="stats-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stats-number" id="approvedCount">0</div>
                <div class="stats-label">Approved Posts</div>
                <div class="view-details">
                    View Details <i class="fas fa-arrow-right"></i>
                </div>
            </a>

            <a href="Rejected-job-posts.jsp" class="stats-card rejected text-decoration-none">
                <div class="stats-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stats-number" id="rejectedCount">0</div>
                <div class="stats-label">Rejected Posts</div>
                <div class="view-details">
                    View Details <i class="fas fa-arrow-right"></i>
                </div>
            </a>

            <a href="send-reminders.jsp" class="stats-card reminders text-decoration-none">
                <div class="stats-icon">
                    <i class="fas fa-paper-plane"></i>
                </div>
                <div class="stats-number" id="remindersSent">0</div>
                <div class="stats-label">Reminders Sent</div>
                <div class="view-details">
                    Send New <i class="fas fa-arrow-right"></i>
                </div>
            </a>
        </div>

        <!-- Recent Job Posts Section -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-tasks me-2"></i>Recent Job Posts</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Job Title</th>
                                    <th>Company</th>
                                    <th>Industry</th>
                                    <th>Location</th>
                                    <th>Posted Date</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody id="recentJobsTable">
                                <tr>
                                    <td colspan="6" class="text-center">
                                        <i class="fas fa-spinner fa-spin me-2"></i>Loading recent job posts...
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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

    // Helper function to get industry badge class (same as in Approved-job-posts.jsp)
    function getIndustryBadgeClass(industry) {
        if (!industry || industry === "Not Specified") return "bg-secondary";

        const industryLower = industry.toLowerCase();

        if (industryLower.includes("technology") || industryLower.includes("tech") ||
            industryLower.includes("software") || industryLower.includes("it") ||
            industryLower.includes("computer") || industryLower.includes("information")) {
            return "bg-primary";
        } else if (industryLower.includes("marketing") || industryLower.includes("advertising") ||
            industryLower.includes("sales") || industryLower.includes("brand") ||
            industryLower.includes("digital")) {
            return "bg-success";
        } else if (industryLower.includes("finance") || industryLower.includes("banking") ||
            industryLower.includes("accounting") || industryLower.includes("investment") ||
            industryLower.includes("financial")) {
            return "bg-warning text-dark";
        } else if (industryLower.includes("health") || industryLower.includes("medical") ||
            industryLower.includes("care") || industryLower.includes("hospital") ||
            industryLower.includes("pharmaceutical")) {
            return "bg-danger";
        } else if (industryLower.includes("education") || industryLower.includes("school") ||
            industryLower.includes("university") || industryLower.includes("training") ||
            industryLower.includes("academic")) {
            return "bg-info";
        } else if (industryLower.includes("manufacturing") || industryLower.includes("production") ||
            industryLower.includes("construction") || industryLower.includes("engineering") ||
            industryLower.includes("industrial")) {
            return "bg-dark";
        } else if (industryLower.includes("retail") || industryLower.includes("e-commerce") ||
            industryLower.includes("commerce") || industryLower.includes("shop") ||
            industryLower.includes("consumer")) {
            return "bg-secondary";
        } else if (industryLower.includes("consulting") || industryLower.includes("professional") ||
            industryLower.includes("services")) {
            return "bg-primary";
        } else if (industryLower.includes("media") || industryLower.includes("entertainment") ||
            industryLower.includes("creative") || industryLower.includes("design")) {
            return "bg-info";
        } else if (industryLower.includes("food") || industryLower.includes("beverage") ||
            industryLower.includes("restaurant") || industryLower.includes("hospitality")) {
            return "bg-warning text-dark";
        } else if (industryLower.includes("transport") || industryLower.includes("logistics") ||
            industryLower.includes("shipping") || industryLower.includes("delivery")) {
            return "bg-dark";
        } else {
            return "bg-light text-dark";
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        // Initialize dashboard
        initializeDashboard();
        setupSidebar();
        setupProfileDropdown();

        // Show loading overlay briefly for better UX
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
                loadDashboardData();
            }, 800);
        }
    });

    function initializeDashboard() {
        setActiveNavigation();
        updatePageTitle();
        console.log('Dashboard initialized for user:', currentUser.username);
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

    function loadDashboardData() {
        showLoading();

        // Load dashboard statistics - FIXED URL
        fetch('<%= request.getContextPath() %>/AssistantDashboardServlet?action=getDashboardStats')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('pendingCount').textContent = data.pendingCount;
                    document.getElementById('approvedCount').textContent = data.approvedCount;
                    document.getElementById('rejectedCount').textContent = data.rejectedCount;
                    document.getElementById('remindersSent').textContent = data.remindersSent;

                    // Animate counters
                    animateCounters();
                } else {
                    console.error('Failed to load dashboard stats:', data.message);
                    showAlert('Failed to load dashboard statistics', 'error');
                }
                hideLoading();
            })
            .catch(error => {
                console.error('Error loading dashboard stats:', error);
                showAlert('Error loading dashboard data', 'error');
                hideLoading();
            });

        // Load recent job posts - FIXED URL
        loadRecentJobPosts();
    }

    function loadRecentJobPosts() {
        const tableBody = document.getElementById('recentJobsTable');

        // FIXED URL
        fetch('<%= request.getContextPath() %>/AssistantDashboardServlet?action=getRecentJobPosts')
            .then(response => response.json())
            .then(data => {
                if (data.success && data.recentPosts) {
                    // Parse the recentPosts which is already a JSON string
                    let posts;
                    if (typeof data.recentPosts === 'string') {
                        posts = JSON.parse(data.recentPosts);
                    } else {
                        posts = data.recentPosts;
                    }
                    renderRecentJobPosts(tableBody, posts);
                } else {
                    tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted"><i class="fas fa-exclamation-circle me-2"></i>No job posts found</td></tr>';
                }
            })
            .catch(error => {
                console.error('Error loading recent job posts:', error);
                tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Error loading job posts</td></tr>';
            });
    }

    function renderRecentJobPosts(tableBody, posts) {
        if (!posts || posts.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="6" class="text-center text-muted"><i class="fas fa-inbox me-2"></i>No job posts available</td></tr>';
            return;
        }

        let html = '';
        posts.forEach(post => {
            // Add null checks for all post properties
            const postedDate = post.createdAt ? new Date(post.createdAt).toLocaleDateString() : 'N/A';
            const statusBadge = getStatusBadge(post.status);
            const salaryText = post.salaryRange ? post.salaryRange : 'Salary not specified';
            const employmentType = post.employmentType || 'N/A';
            const workMode = post.workMode || 'Not specified';
            const industry = post.industry || 'Not Specified';
            const badgeClass = getIndustryBadgeClass(industry);

            html += '<tr>' +
                '<td class="text-truncate" title="' + escapeHtml(post.jobTitle || 'N/A') + '">' +
                '<strong>' + escapeHtml(post.jobTitle || 'N/A') + '</strong>' +
                '<div class="job-details">' +
                '<small class="text-muted">' +
                escapeHtml(employmentType) +
                '<span class="separator">•</span>' +
                escapeHtml(workMode) +
                '<span class="separator">•</span>' +
                escapeHtml(salaryText) +
                '</small>' +
                '</div>' +
                '</td>' +
                '<td>' + escapeHtml(post.companyName || 'N/A') + '</td>' +
                '<td><span class="badge ' + badgeClass + '">' + escapeHtml(industry) + '</span></td>' +
                '<td>' + escapeHtml(post.location || 'N/A') + '</td>' +
                '<td>' + postedDate + '</td>' +
                '<td>' + statusBadge + '</td>' +
                '</tr>';
        });

        tableBody.innerHTML = html;
    }

    function getStatusBadge(status) {
        switch (status) {
            case 'pending':
                return '<span class="status-badge pending">Pending</span>';
            case 'approved':
                return '<span class="status-badge active">Approved</span>';
            case 'rejected':
                return '<span class="status-badge rejected">Rejected</span>';
            default:
                return '<span class="badge bg-secondary">Unknown</span>';
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

    function setActiveNavigation() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === currentPage ||
                (currentPage === '' && link.getAttribute('href') === 'Dashboard.jsp')) {
                link.classList.add('active');
            }
        });
    }

    function updatePageTitle() {
        const pageTitle = document.getElementById('pageTitle');
        if (pageTitle) {
            pageTitle.textContent = 'Dashboard';
        }
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
        // Remove existing alerts
        const existingAlerts = document.querySelectorAll('.custom-alert');
        existingAlerts.forEach(alert => alert.remove());

        // Create alert element
        const alertDiv = document.createElement('div');
        alertDiv.className = 'custom-alert alert-' + type;
        alertDiv.innerHTML = `
            <div class="alert-content">
                <span>${message}</span>
                <button class="alert-close" onclick="this.parentElement.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;

        document.body.appendChild(alertDiv);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (alertDiv.parentElement) {
                alertDiv.remove();
            }
        }, 5000);
    }

    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = '<%= request.getContextPath() %>/LogoutServlet';
        }
    }

    // Utility function to escape HTML
    function escapeHtml(text) {
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text ? text.replace(/[&<>"']/g, m => map[m]) : '';
    }
</script>
</body>
</html>