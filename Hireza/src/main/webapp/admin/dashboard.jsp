<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireZa</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

</head>
<body>
<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="#" class="sidebar-brand">
        <img src="${pageContext.request.contextPath}/images/index/favicon.png" alt="HireZa Logo">
        <span class="brand-text">HireZa</span>
    </a>

    <ul class="sidebar-nav">
        <li class="nav-header">Main</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link active">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Dashboard</span>
            </a>
        </li>

        <li class="nav-header">User Management</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/UMjobseeker.jsp" class="nav-link">
                <i class="fas fa-users"></i>
                <span class="nav-text">Job Seekers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/UMemployers.jsp" class="nav-link">
                <i class="fas fa-building"></i>
                <span class="nav-text">Employers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/UMrecruiters.jsp" class="nav-link">
                <i class="fas fa-user-tie"></i>
                <span class="nav-text">Recruiters</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/UMcounselors.jsp" class="nav-link">
                <i class="fas fa-user-graduate"></i>
                <span class="nav-text">Job Counselors</span>
            </a>
        </li>

        <li class="nav-header">Administration</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/Aadminassistants.jsp" class="nav-link">
                <i class="fas fa-user-shield"></i>
                <span class="nav-text">Admin Assistants</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/systemlogs.jsp" class="nav-link">
                <i class="fas fa-clipboard-list"></i>
                <span class="nav-text">System Logs</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/adminsettings.jsp" class="nav-link">
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
            <div class="admin-profile dropdown">
                <div class="d-flex align-items-center" data-bs-toggle="dropdown" aria-expanded="false" style="cursor: pointer;">
                    <div class="profile-avatar" id="profileAvatar">A</div>
                    <div class="profile-info">
                        <h6 id="adminFullName">Loading...</h6>
                        <small>Administrator</small>
                    </div>
                    <i class="fas fa-chevron-down ms-2"></i>
                </div>

                <!-- Dropdown Menu -->
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/adminsettings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-home me-2"></i>Welcome to HireZa Admin Dashboard</h2>
            <p class="mb-0">Monitor and manage your recruitment platform efficiently. Get insights into user activity and system performance.</p>
        </div>

        <!-- Stats Cards - All in Single Row -->
        <div class="row g-4 mb-4">
            <div class="col-xl-2-4 col-lg-3 col-md-6 col-sm-12">
                <a href="${pageContext.request.contextPath}/admin/UMjobseeker.jsp" class="stats-card jobseekers card h-100 text-decoration-none">
                    <div class="card-body text-center">
                        <div class="stats-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h2 class="stats-number" id="jobseekersCount">0</h2>
                        <p class="stats-label">Job Seekers</p>
                        <small class="d-block mt-2">
                            <i class="fas fa-arrow-right me-1"></i>View Details
                        </small>
                    </div>
                </a>
            </div>

            <div class="col-xl-2-4 col-lg-3 col-md-6 col-sm-12">
                <a href="${pageContext.request.contextPath}/admin/UMemployers.jsp" class="stats-card employers card h-100 text-decoration-none">
                    <div class="card-body text-center">
                        <div class="stats-icon">
                            <i class="fas fa-building"></i>
                        </div>
                        <h2 class="stats-number" id="employersCount">0</h2>
                        <p class="stats-label">Employers</p>
                        <small class="d-block mt-2">
                            <i class="fas fa-arrow-right me-1"></i>View Details
                        </small>
                    </div>
                </a>
            </div>

            <div class="col-xl-2-4 col-lg-3 col-md-6 col-sm-12">
                <a href="${pageContext.request.contextPath}/admin/UMrecruiters.jsp" class="stats-card recruiters card h-100 text-decoration-none">
                    <div class="card-body text-center">
                        <div class="stats-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h2 class="stats-number" id="recruitersCount">0</h2>
                        <p class="stats-label">Recruiters</p>
                        <small class="d-block mt-2">
                            <i class="fas fa-arrow-right me-1"></i>View Details
                        </small>
                    </div>
                </a>
            </div>

            <div class="col-xl-2-4 col-lg-3 col-md-6 col-sm-12">
                <a href="${pageContext.request.contextPath}/admin/UMcounselors.jsp" class="stats-card counselors card h-100 text-decoration-none">
                    <div class="card-body text-center">
                        <div class="stats-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <h2 class="stats-number" id="counselorsCount">0</h2>
                        <p class="stats-label">Job Counselors</p>
                        <small class="d-block mt-2">
                            <i class="fas fa-arrow-right me-1"></i>View Details
                        </small>
                    </div>
                </a>
            </div>

            <div class="col-xl-2-4 col-lg-3 col-md-6 col-sm-12">
                <a href="${pageContext.request.contextPath}/admin/Aadminassistants.jsp" class="stats-card admin-assistants card h-100 text-decoration-none">
                    <div class="card-body text-center">
                        <div class="stats-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h2 class="stats-number" id="adminAssistantsCount">0</h2>
                        <p class="stats-label">Admin Assistants</p>
                        <small class="d-block mt-2">
                            <i class="fas fa-arrow-right me-1"></i>View Details
                        </small>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Custom CSS for 5-column layout -->
<style>
    /* Custom 5-column layout for XL screens and above */
    @media (min-width: 1200px) {
        .col-xl-2-4 {
            flex: 0 0 20%;
            max-width: 20%;
        }
    }

    /* Ensure proper spacing and responsiveness */
    @media (max-width: 1199px) {
        .col-xl-2-4 {
            flex: 0 0 33.333333%;
            max-width: 33.333333%;
        }
    }

    @media (max-width: 991px) {
        .col-xl-2-4 {
            flex: 0 0 50%;
            max-width: 50%;
        }
    }

    @media (max-width: 575px) {
        .col-xl-2-4 {
            flex: 0 0 100%;
            max-width: 100%;
        }
    }

    /* Adjust stats cards for smaller screens */
    @media (max-width: 1400px) {
        .stats-card {
            min-height: 160px;
            padding: 20px 15px;
        }

        .stats-number {
            font-size: 2.2rem;
        }

        .stats-icon {
            font-size: 2rem;
            width: 60px;
            height: 60px;
        }

        .stats-label {
            font-size: 0.9rem;
        }
    }

    @media (max-width: 1200px) {
        .stats-card {
            min-height: 140px;
            padding: 18px 12px;
        }

        .stats-number {
            font-size: 2rem;
        }

        .stats-icon {
            font-size: 1.8rem;
            width: 50px;
            height: 50px;
        }

        .stats-label {
            font-size: 0.85rem;
        }
    }

    /* Recent Activity Section - Blue Theme with Category Colors */
    .recent-activity-section {
        background: white;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
        overflow: hidden;
    }

    .activity-header {
        background: white;
        color: #1f2937;
        padding: 20px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #e5e7eb;
    }

    .activity-header h5 {
        margin: 0;
        font-size: 1.125rem;
        font-weight: 600;
    }

    .activity-header h5 i {
        margin-right: 8px;
    }

    .view-all-btn {
        background: #2563eb;
        border: 1px solid #2563eb;
        color: white;
        padding: 6px 16px;
        border-radius: 6px;
        font-size: 0.875rem;
        cursor: pointer;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .view-all-btn:hover {
        background: #1d4ed8;
        border-color: #1d4ed8;
        color: white;
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
    }

    .activity-tabs {
        display: flex;
        border-bottom: 1px solid #e5e7eb;
        background: #fafafa;
        padding: 0 25px;
        overflow-x: auto;
    }

    .activity-tab {
        background: transparent;
        border: none;
        padding: 14px 20px;
        color: #6b7280;
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        border-bottom: 2px solid transparent;
        transition: all 0.2s ease;
        white-space: nowrap;
    }

    .activity-tab:hover {
        color: #374151;
    }

    /* Default active state (blue) */
    .activity-tab.active {
        color: #2563eb;
        border-bottom-color: #2563eb;
    }

    /* Category-specific active states */
    .activity-tab.active[data-category="all"] {
        color: #2563eb;
        border-bottom-color: #2563eb;
    }

    .activity-tab.active[data-category="users"] {
        color: #2563eb;
        border-bottom-color: #2563eb;
    }

    .activity-tab.active[data-category="jobs"] {
        color: #ea580c;
        border-bottom-color: #ea580c;
    }

    .activity-tab.active[data-category="applications"] {
        color: #059669;
        border-bottom-color: #059669;
    }

    .activity-tab.active[data-category="system"] {
        color: #9333ea;
        border-bottom-color: #9333ea;
    }

    .activity-tab i {
        margin-right: 6px;
        font-size: 0.85rem;
    }

    .activity-content {
        padding: 20px 25px;
        max-height: 450px;
        overflow-y: auto;
    }

    .activity-content::-webkit-scrollbar {
        width: 6px;
    }

    .activity-content::-webkit-scrollbar-track {
        background: #f5f5f5;
    }

    .activity-content::-webkit-scrollbar-thumb {
        background: #d1d5db;
        border-radius: 3px;
    }

    .activity-content::-webkit-scrollbar-thumb:hover {
        background: #9ca3af;
    }

    .activity-item {
        display: flex;
        padding: 14px;
        border-radius: 6px;
        margin-bottom: 10px;
        transition: all 0.2s ease;
        border: 1px solid transparent;
    }

    .activity-item:hover {
        background: #f9fafb;
        border-color: #e5e7eb;
    }

    .activity-icon-wrapper {
        width: 38px;
        height: 38px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        margin-right: 14px;
    }

    /* Category Icon Colors */
    .activity-icon-wrapper.blue {
        background: #dbeafe;
        color: #2563eb;
    }

    .activity-icon-wrapper.orange {
        background: #fed7aa;
        color: #ea580c;
    }

    .activity-icon-wrapper.green {
        background: #d1fae5;
        color: #059669;
    }

    .activity-icon-wrapper.purple {
        background: #e9d5ff;
        color: #9333ea;
    }

    .activity-icon-wrapper.cyan {
        background: #cffafe;
        color: #0891b2;
    }

    .activity-icon-wrapper.yellow {
        background: #fef3c7;
        color: #d97706;
    }

    .activity-icon-wrapper i {
        font-size: 1rem;
    }

    .activity-details {
        flex: 1;
        min-width: 0;
    }

    .activity-title {
        font-size: 0.9rem;
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 3px;
    }

    .activity-description {
        font-size: 0.85rem;
        color: #6b7280;
        margin-bottom: 4px;
    }

    .activity-time {
        font-size: 0.75rem;
        color: #9ca3af;
    }

    .activity-time i {
        margin-right: 4px;
    }

    .no-activity {
        text-align: center;
        padding: 50px 20px;
        color: #9ca3af;
    }

    .no-activity i {
        font-size: 3rem;
        margin-bottom: 12px;
        opacity: 0.4;
    }

    .no-activity p {
        margin: 0;
        font-size: 0.9rem;
    }

    .tab-content {
        display: none;
    }

    .tab-content.active {
        display: block;
        animation: fadeIn 0.25s ease;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(5px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .loading-spinner {
        text-align: center;
        padding: 40px;
        color: #6b7280;
    }

    .loading-spinner i {
        font-size: 2rem;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }

    /* Responsive */
    @media (max-width: 768px) {
        .activity-header {
            flex-direction: column;
            gap: 12px;
            align-items: flex-start;
        }

        .activity-tabs {
            padding: 0 15px;
        }

        .activity-tab {
            padding: 12px 16px;
            font-size: 0.8rem;
        }

        .activity-content {
            padding: 15px;
            max-height: 400px;
        }

        .activity-item {
            padding: 12px;
        }
    }
</style>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Dashboard JavaScript with AJAX Data Loading
    let dashboardData = null;

    document.addEventListener('DOMContentLoaded', () => {
        // Initialize dashboard
        initializeDashboard();
    });

    async function initializeDashboard() {
        try {
            // Show loading overlay
            showLoading(true);

            // Fetch dashboard data
            await fetchDashboardData();

            // Hide loading overlay
            showLoading(false);

            // Initialize UI components
            initializeUIComponents();

        } catch (error) {
            console.error('Dashboard initialization failed:', error);
            showLoading(false);
            showError('Failed to load dashboard data');
        }
    }

    async function fetchDashboardData() {
        try {
            const response = await fetch('${pageContext.request.contextPath}/api/dashboard', {
                method: 'GET',
                credentials: 'same-origin',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const data = await response.json();

            if (!response.ok) {
                if (data.redirect) {
                    window.location.href = '${pageContext.request.contextPath}' + data.redirect;
                    return;
                }
                throw new Error(data.error || 'Failed to fetch dashboard data');
            }

            if (data.success) {
                dashboardData = data;
                updateDashboardUI(data);
            } else {
                throw new Error('Invalid response from server');
            }

        } catch (error) {
            console.error('Error fetching dashboard data:', error);
            throw error;
        }
    }

    function updateDashboardUI(data) {
        // Update admin profile information
        if (data.admin) {
            const adminFullName = document.getElementById('adminFullName');
            const profileAvatar = document.getElementById('profileAvatar');

            if (adminFullName && data.admin.fullName) {
                adminFullName.textContent = data.admin.fullName;
            }

            if (profileAvatar && data.admin.fullName) {
                const initial = data.admin.fullName.charAt(0).toUpperCase();
                profileAvatar.textContent = initial;
            }
        }

        // Update count displays
        if (data.counts) {
            updateCount('employersCount', data.counts.employers);
            updateCount('recruitersCount', data.counts.recruiters);
            updateCount('jobseekersCount', data.counts.jobseekers);
            updateCount('counselorsCount', data.counts.counselors);
            updateCount('adminAssistantsCount', data.counts.adminAssistants);
        }

        // Update job market analytics
        if (data.analytics) {
            updateAnalytics(data.analytics);
        }
    }

    function updateCount(elementId, count) {
        const element = document.getElementById(elementId);
        if (element) {
            element.textContent = count || 0;
        }
    }

    function updateAnalytics(analytics) {
        // Update active jobs count
        if (analytics.activeJobs !== undefined) {
            updateCount('activeJobsCount', analytics.activeJobs);
        }

        // Update success rate
        if (analytics.successRate !== undefined) {
            const successRateElement = document.getElementById('successRate');
            if (successRateElement) {
                successRateElement.textContent = analytics.successRate;
            }
        }

        // Update average time to fill
        if (analytics.avgTimeToFill !== undefined) {
            const avgTimeElement = document.getElementById('avgTimeToFill');
            if (avgTimeElement) {
                avgTimeElement.textContent = analytics.avgTimeToFill;
            }
        }

        // Update top category
        if (analytics.topCategory) {
            const topCategoryElement = document.getElementById('topCategory');
            if (topCategoryElement) {
                topCategoryElement.textContent = analytics.topCategory.name || 'Technology';
            }

            const topCategoryPercentElement = document.getElementById('topCategoryPercent');
            if (topCategoryPercentElement && analytics.topCategory.percentage) {
                topCategoryPercentElement.textContent = analytics.topCategory.percentage + '%';
            }
        }

        // Update change indicators
        if (analytics.changes) {
            updateChangeIndicator('activeJobsChange', analytics.changes.activeJobs);
            updateChangeIndicator('successRateChange', analytics.changes.successRate);
            updateChangeIndicator('timeToFillChange', analytics.changes.timeToFill);
        }
    }

    function updateChangeIndicator(elementId, change) {
        const element = document.getElementById(elementId);
        if (element && change !== undefined) {
            element.textContent = change;
        }
    }

    function showLoading(show) {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.style.display = show ? 'flex' : 'none';
        }
    }

    function showError(message) {
        // Create and show error alert
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-danger alert-dismissible fade show position-fixed';
        alertDiv.style.top = '20px';
        alertDiv.style.right = '20px';
        alertDiv.style.zIndex = '9999';
        alertDiv.innerHTML = `
            <i class="fas fa-exclamation-triangle me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.body.appendChild(alertDiv);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.parentNode.removeChild(alertDiv);
            }
        }, 5000);
    }


    function initializeUIComponents() {
        // DOM Elements
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        // Enhanced Sidebar Toggle Functionality with Persistence
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                if (window.innerWidth <= 768) {
                    // Mobile behavior - show/hide sidebar
                    sidebar.classList.toggle('show');
                } else {
                    // Desktop behavior - collapse/expand sidebar
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');

                    // Store state for persistence
                    localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
                }
            });
        }

        // Restore sidebar state on page load
        const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
        if (isCollapsed && window.innerWidth > 768) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('expanded');
        }

        // Initialize other dashboard features
        setActiveNavigation();
        initializeStatsCards();
        initializeAnalyticsCards();
        animateCounters();
        initializeActivityItems();
        handleResize();
    }

    // Initialize Analytics Cards Animation
    function initializeAnalyticsCards() {
        const analyticsItems = document.querySelectorAll('.analytics-item');

        analyticsItems.forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
                this.style.boxShadow = '0 6px 20px rgba(0,0,0,0.15)';
            });

            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-2px)';
                this.style.boxShadow = '0 4px 15px rgba(0,0,0,0.1)';
            });
        });

        // Animate progress bars
        const progressBars = document.querySelectorAll('.progress-bar');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const progressBar = entry.target;
                    const width = progressBar.style.width;
                    progressBar.style.width = '0%';
                    progressBar.style.transition = 'width 1s ease-in-out';

                    setTimeout(() => {
                        progressBar.style.width = width;
                    }, 100);

                    observer.unobserve(progressBar);
                }
            });
        });

        progressBars.forEach(bar => observer.observe(bar));
    }

    // Set Active Navigation Based on Current Page
    function setActiveNavigation() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            link.classList.remove('active');
            const linkHref = link.getAttribute('href');

            if (currentPage === 'dashboard.jsp' && linkHref.includes('dashboard.jsp')) {
                link.classList.add('active');
            }
        });
    }

    // Responsive Sidebar Handling
    function handleResize() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        window.addEventListener('resize', () => {
            if (window.innerWidth <= 768) {
                // On mobile, remove collapsed state and use show/hide instead
                sidebar.classList.remove('collapsed');
                mainContent.classList.remove('expanded');
                sidebar.classList.remove('show');
            } else {
                // On desktop, restore the saved state
                const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
                if (isCollapsed) {
                    sidebar.classList.add('collapsed');
                    mainContent.classList.add('expanded');
                }
            }
        });
    }

    // Stats Cards Animation
    function initializeStatsCards() {
        const statsCards = document.querySelectorAll('.stats-card');

        statsCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px) scale(1.02)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = '';
            });
        });
    }

    // Counter Animation for Stats Numbers
    function animateCounters() {
        const counters = document.querySelectorAll('.stats-number, .analytics-item h4');

        counters.forEach(counter => {
            const target = parseInt(counter.textContent);
            if (isNaN(target)) return;

            const increment = target / 50;
            let current = 0;

            const updateCounter = () => {
                if (current < target) {
                    current += increment;
                    counter.textContent = Math.ceil(current);
                    requestAnimationFrame(updateCounter);
                } else {
                    counter.textContent = target;
                }
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        updateCounter();
                        observer.unobserve(entry.target);
                    }
                });
            });

            observer.observe(counter);
        });
    }

    // Activity Items Animation
    function initializeActivityItems() {
        const activityItems = document.querySelectorAll('.activity-item');

        activityItems.forEach((item, index) => {
            setTimeout(() => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(-20px)';
                item.style.transition = 'all 0.3s ease';

                requestAnimationFrame(() => {
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                });
            }, index * 100);
        });
    }

    // Refresh dashboard data
    function refreshDashboard() {
        initializeDashboard();
    }

    // Auto-refresh dashboard every 5 minutes
    setInterval(() => {
        refreshDashboard();
    }, 300000); // 5 minutes

    // Window resize event listener
    window.addEventListener('resize', handleResize);

    // Initialize tooltips for better UX
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    document.addEventListener('click', (e) => {
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');

        if (window.innerWidth <= 768 &&
            sidebar.classList.contains('show') &&
            !sidebar.contains(e.target) &&
            !sidebarToggle.contains(e.target)) {
            sidebar.classList.remove('show');
        }
    });

    // Activity tab management
    let currentActivityTab = 'all';

    function switchActivityTab(tabName) {
        document.querySelectorAll('.activity-tab').forEach(tab => {
            tab.classList.remove('active');
        });
        event.target.closest('.activity-tab').classList.add('active');

        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });
        document.getElementById(tabName + '-tab').classList.add('active');

        currentActivityTab = tabName;
        loadRecentActivities(tabName);
    }

    async function loadRecentActivities(type = 'all') {
        const tabContent = document.getElementById(type + '-tab');

        tabContent.innerHTML = `
        <div class="loading-spinner">
            <i class="fas fa-spinner"></i>
            <p class="mt-2">Loading activities...</p>
        </div>
    `;

        try {
            const response = await fetch('${pageContext.request.contextPath}/RecentActivityServlet?type=' + type);
            const data = await response.json();

            if (data.success && data.activities && data.activities.length > 0) {
                renderActivities(data.activities, tabContent);
            } else {
                showNoActivity(tabContent, type);
            }
        } catch (error) {
            console.error('Error loading activities:', error);
            tabContent.innerHTML = `
            <div class="no-activity">
                <i class="fas fa-exclamation-circle"></i>
                <p>Failed to load activities. Please try again.</p>
            </div>
        `;
        }
    }

    function renderActivities(activities, container) {
        container.innerHTML = activities.map(activity => `
        <div class="activity-item">
            <div class="activity-icon-wrapper ${activity.iconColor}">
                <i class="${activity.icon}"></i>
            </div>
            <div class="activity-details">
                <div class="activity-title">${activity.title}</div>
                <div class="activity-description">${activity.description}</div>
                <div class="activity-time">
                    <i class="far fa-clock"></i>${activity.timeAgo}
                </div>
            </div>
        </div>
    `).join('');
    }

    function showNoActivity(container, type) {
        const messages = {
            all: 'No recent activity',
            users: 'No user activity',
            jobs: 'No job post activity',
            applications: 'No application activity',
            system: 'No system activity'
        };

        container.innerHTML = `
        <div class="no-activity">
            <i class="fas fa-inbox"></i>
            <p>${messages[type] || 'No activities found'}</p>
        </div>
    `;
    }

    // Load activities when page loads
    document.addEventListener('DOMContentLoaded', function() {
        loadRecentActivities('all');
    });

</script>

</body>
</html>