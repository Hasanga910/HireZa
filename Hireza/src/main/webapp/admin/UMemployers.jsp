<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>

<%
    // ✅ Check if we're coming from the right source
    String currentRole = "Employer"; // This page is specifically for Employers

    // ✅ Fetch from session (because we are using sendRedirect)
    List<User> employers = (List<User>) session.getAttribute("users");
    String selectedRole = (String) session.getAttribute("selectedRole");

    // ✅ Debug logging (remove in production)
    System.out.println("JSP - Selected Role: " + selectedRole);
    System.out.println("JSP - Users count: " + (employers != null ? employers.size() : 0));

    // ✅ If no data OR wrong role data, redirect to fetch correct data
    if (employers == null || !currentRole.equals(selectedRole)) {
        System.out.println("JSP - Redirecting to fetch Employer data");
        response.sendRedirect(request.getContextPath() + "/UserManagementServlet?action=fetch&userRole=Employer");
        return;
    }

    String errorMessage = (String) session.getAttribute("errorMessage");
    String successMessage = (String) session.getAttribute("successMessage");
    Integer totalCount = (Integer) session.getAttribute("totalUsers");

    if (employers == null) employers = new java.util.ArrayList<>();
    if (totalCount == null) totalCount = 0;

    // ✅ Clear message attributes after reading so they don't persist
    if (errorMessage != null) session.removeAttribute("errorMessage");
    if (successMessage != null) session.removeAttribute("successMessage");
%>
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
    <link rel="stylesheet" href="../css/admin.css">

    <style>
        /* Stats Cards Styles - Yellow Theme */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            padding: 25px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.2);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: rotate(45deg);
            transition: all 0.5s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
        }

        .stat-card:hover::before {
            animation: shine 0.5s ease-in-out;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .stat-card h3 {
            font-size: 2.5rem;
            font-weight: bold;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .stat-card p {
            margin: 8px 0 0;
            font-size: 0.95rem;
            opacity: 0.9;
            font-weight: 500;
        }

        .stat-card .stat-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            opacity: 0.8;
        }

        /* Search and Filters Styles - Yellow Theme */
        .search-filters {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .search-filters .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
        }

        .search-filters .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 16px;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .search-filters .form-control:focus {
            border-color: #f59e0b;
            box-shadow: 0 0 0 0.2rem rgba(245, 158, 11, 0.25);
        }

        .search-filters .btn {
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .search-filters .btn-primary {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            border: none;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .search-filters .btn-primary:hover {
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(245, 158, 11, 0.4);
        }

        /* Enhanced Table Styles */
        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
            color: white;
            font-weight: 600;
            border: none;
            padding: 15px 12px;
        }

        .table td {
            padding: 15px 12px;
            vertical-align: middle;
            border-color: #f3f4f6;
        }

        .table tbody tr:hover {
            background-color: #fef3c7;
            transition: background-color 0.3s ease;
        }

        .btn-outline-danger {
            border-color: #dc2626;
            color: #dc2626;
            transition: all 0.3s ease;
        }

        .btn-outline-danger:hover {
            background-color: #dc2626;
            border-color: #dc2626;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        /* Card Header Enhancement */
        .card-header {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-bottom: 2px solid #e2e8f0;
            font-weight: 600;
        }

        .badge {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%) !important;
            color: white !important;
            font-size: 0.8rem;
            padding: 6px 10px;
        }

        /* User Avatar Styles - Yellow Theme */
        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            box-shadow: 0 2px 8px rgba(245, 158, 11, 0.3);
        }

        /* Loading Animation */
        .loading-stats {
            opacity: 0.6;
        }

        .loading-stats h3 {
            color: transparent;
            background: linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
            border-radius: 4px;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

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

        /* Additional Yellow Theme Elements */
        .btn-primary {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            border: none;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(245, 158, 11, 0.4);
        }

        .text-primary {
            color: #f59e0b !important;
        }

        .border-primary {
            border-color: #f59e0b !important;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .stats-cards {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .stat-card {
                padding: 20px 15px;
            }

            .stat-card h3 {
                font-size: 2rem;
            }

            .search-filters {
                padding: 20px;
            }
        }
    </style>
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
        <img src="../images/index/favicon.png" alt="HireZa Logo">
        <span class="brand-text">HireZa</span>
    </a>

    <ul class="sidebar-nav">
        <li class="nav-header">Main</li>
        <li class="nav-item">
            <a href="dashboard.jsp" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Dashboard</span>
            </a>
        </li>

        <li class="nav-header">User Management</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=JobSeeker" class="nav-link">
                <i class="fas fa-users"></i>
                <span class="nav-text">Job Seekers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=Employer" class="nav-link active">
                <i class="fas fa-building"></i>
                <span class="nav-text">Employers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=Recruiter" class="nav-link">
                <i class="fas fa-user-tie"></i>
                <span class="nav-text">Recruiters</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=JobCounsellor" class="nav-link">
                <i class="fas fa-user-graduate"></i>
                <span class="nav-text">Job Counselors</span>
            </a>
        </li>

        <li class="nav-header">Administration</li>
        <li class="nav-item">
            <a href="Aadminassistants.jsp" class="nav-link">
                <i class="fas fa-user-shield"></i>
                <span class="nav-text">Admin Assistants</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="systemlogs.jsp" class="nav-link">
                <i class="fas fa-clipboard-list"></i>
                <span class="nav-text">System Logs</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="adminsettings.jsp" class="nav-link">
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
            <h1 class="page-title" id="pageTitle">Employers</h1>
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

    <!-- Employers Content -->
    <div class="dashboard-content">
        <div class="welcome-section">
            <h2><i class="fas fa-building me-2"></i>Employers Management</h2>
            <p class="mb-0">Manage employer accounts and monitor their recruitment activities on the platform.</p>
        </div>

        <!-- ✅ Show success/error messages -->
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            <%= successMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <%= errorMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Statistics Cards -->
        <div class="stats-cards" id="statsCards">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-building"></i>
                </div>
                <h3 id="totalEmployers"><%= totalCount %></h3>
                <p>Total Employers</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-briefcase"></i>
                </div>
                <h3 id="activejobposts">-</h3>
                <p>Active Job Posts</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <h3 id="totaljobposts">-</h3>
                <p>Total Job Posts</p>
            </div>
        </div>

        <!-- Search and Filters -->
        <div class="search-filters">
            <div class="row">
                <div class="col-md-8">
                    <label for="searchEmployer" class="form-label">Search Employers</label>
                    <input type="text" class="form-control" id="searchEmployer" placeholder="Search by name, email, username, phone...">
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button class="btn btn-outline-secondary me-2" onclick="clearFilters()">
                        <i class="fas fa-times"></i> Clear
                    </button>
                    <button class="btn btn-primary flex-fill" onclick="applyFilters()">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </div>
        </div>

        <!-- Employers Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    Employers List <span class="badge bg-primary" id="filteredCount"><%= totalCount %></span>
                </h5>
                <button class="btn btn-primary btn-sm" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
            </div>
            <div class="card-body">
                <% if (!employers.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="employerTable">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (User e : employers) { %>
                        <tr data-user-id="<%= e.getId() %>">
                            <td>
                                <span class="badge bg-primary"><%= e.getId() %></span>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="user-avatar me-2">
                                        <%= e.getFullName() != null && !e.getFullName().isEmpty() ?
                                                e.getFullName().charAt(0) : "?" %>
                                    </div>
                                    <%= e.getFullName() != null ? e.getFullName() : "N/A" %>
                                </div>
                            </td>
                            <td><%= e.getUsername() != null ? e.getUsername() : "N/A" %></td>
                            <td>
                                <% if (e.getEmail() != null && !e.getEmail().isEmpty()) { %>
                                <a href="mailto:<%= e.getEmail() %>" class="text-decoration-none">
                                    <%= e.getEmail() %>
                                </a>
                                <% } else { %>
                                N/A
                                <% } %>
                            </td>
                            <td>
                                <% if (e.getPhone() != null && !e.getPhone().isEmpty()) { %>
                                <a href="tel:<%= e.getPhone() %>" class="text-decoration-none">
                                    <%= e.getPhone() %>
                                </a>
                                <% } else { %>
                                N/A
                                <% } %>
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-danger"
                                        onclick="deleteUser('<%= e.getId() %>', '<%= e.getFullName() != null ? e.getFullName().replace("'", "\\'") : "this employer" %>')">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                <div class="text-center text-muted py-5">
                    <i class="fas fa-info-circle fa-3x mb-3"></i>
                    <h5>No employers found</h5>
                    <p>Make sure there are users with role "Employer" in your database.</p>
                </div>
                <% } %>

                <!-- No Results Message (Hidden by default) -->
                <div id="noResultsMessage" class="text-center text-muted py-5" style="display: none;">
                    <i class="fas fa-search fa-3x mb-3"></i>
                    <h5>No results found</h5>
                    <p>Try adjusting your search criteria or clearing the filters.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Dashboard JavaScript with AJAX Data Loading
    let dashboardData = null;
    let originalTableRows = [];
    let filteredEmployers = [];

    document.addEventListener('DOMContentLoaded', () => {
        // Initialize dashboard
        initializeDashboard();

        // Store original table rows for filtering
        storeOriginalTableRows();

        // Initialize search functionality
        initializeSearch();

        // Calculate and display statistics
        calculateStatistics();

        fetchJobPostStats();
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

    async function fetchJobPostStats() {
        try {
            const response = await fetch('${pageContext.request.contextPath}/JobPostStatsServlet?type=employer');

            if (!response.ok) {
                throw new Error('Failed to fetch job post statistics');
            }

            const data = await response.json();

            if (data.success && data.type === 'employer') {
                // Update the stat cards with animated numbers
                animateNumber('activejobposts', data.activePosts || 0);
                animateNumber('totaljobposts', data.totalPosts || 0);
            } else {
                console.error('Error from server:', data.error);
                // Set to 0 if there's an error
                document.getElementById('activejobposts').textContent = '0';
                document.getElementById('totaljobposts').textContent = '0';
            }
        } catch (error) {
            console.error('Error fetching job post stats:', error);
            // Set to 0 if there's an error
            document.getElementById('activejobposts').textContent = '0';
            document.getElementById('totaljobposts').textContent = '0';
        }
    }

    function storeOriginalTableRows() {
        const tableBody = document.querySelector('#employerTable tbody');
        if (tableBody) {
            originalTableRows = Array.from(tableBody.querySelectorAll('tr'));
            filteredEmployers = [...originalTableRows];
        }
    }

    function initializeSearch() {
        const searchInput = document.getElementById('searchEmployer');

        // Add event listeners for real-time search
        if (searchInput) {
            searchInput.addEventListener('input', debounce(applyFilters, 300));
        }
    }

    function calculateStatistics() {
        const totalEmployers = originalTableRows.length;

        // Update stats with animation
        animateNumber('totalEmployers', totalEmployers);

    }

    function animateNumber(elementId, targetNumber) {
        const element = document.getElementById(elementId);
        if (!element) return;

        const duration = 1000;
        const increment = targetNumber / (duration / 16);
        let current = 0;

        const timer = setInterval(() => {
            current += increment;
            if (current >= targetNumber) {
                current = targetNumber;
                clearInterval(timer);
            }
            element.textContent = Math.floor(current);
        }, 16);
    }

    function applyFilters() {
        const searchTerm = document.getElementById('searchEmployer').value.toLowerCase();

        filteredEmployers = originalTableRows.filter(row => {
            const userId = row.cells[0].textContent.toLowerCase();
            const fullName = row.cells[1].textContent.toLowerCase();
            const username = row.cells[2].textContent.toLowerCase();
            const email = row.cells[3].textContent.toLowerCase();
            const phone = row.cells[4].textContent.toLowerCase();

            // Search filter - check all relevant fields
            const matchesSearch = !searchTerm ||
                userId.includes(searchTerm) ||
                fullName.includes(searchTerm) ||
                username.includes(searchTerm) ||
                email.includes(searchTerm) ||
                phone.includes(searchTerm);

            return matchesSearch;
        });

        // Update table display
        updateTableDisplay();

        // Update filtered count
        updateFilteredCount();
    }

    function updateTableDisplay() {
        const tableBody = document.querySelector('#employerTable tbody');
        const noResultsMessage = document.getElementById('noResultsMessage');
        const tableContainer = document.querySelector('.table-responsive');

        if (!tableBody) return;

        // Clear current rows
        tableBody.innerHTML = '';

        if (filteredEmployers.length === 0) {
            // Show no results message
            if (tableContainer) tableContainer.style.display = 'none';
            if (noResultsMessage) noResultsMessage.style.display = 'block';
        } else {
            // Show filtered rows
            if (tableContainer) tableContainer.style.display = 'block';
            if (noResultsMessage) noResultsMessage.style.display = 'none';

            filteredEmployers.forEach((row) => {
                const newRow = row.cloneNode(true);
                tableBody.appendChild(newRow);
            });
        }
    }

    function updateFilteredCount() {
        const countElement = document.getElementById('filteredCount');
        if (countElement) {
            countElement.textContent = filteredEmployers.length;
        }
    }

    function clearFilters() {
        // Clear search input
        document.getElementById('searchEmployer').value = '';

        // Reset filtered data
        filteredEmployers = [...originalTableRows];

        // Update display
        updateTableDisplay();
        updateFilteredCount();
    }

    // Utility function for debouncing search input
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
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
                updateAdminProfile(data);
            } else {
                throw new Error('Invalid response from server');
            }

        } catch (error) {
            console.error('Error fetching dashboard data:', error);
            // Don't throw error - this is optional data
        }
    }

    function updateAdminProfile(data) {
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
                    sidebar.classList.toggle('show');
                } else {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');
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
        handleResize();
        // Remove the undefined function calls:
        // initializeStatsCards();
        // initializeAnalyticsCards();
        // animateCounters();
        // initializeActivityItems();
    }

    // Set Active Navigation Based on Current Page
    function setActiveNavigation() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            link.classList.remove('active');
        });

        // Set active for employers page specifically
        const employerLinks = document.querySelectorAll('a[href*="userRole=Employer"]');
        employerLinks.forEach(link => {
            link.classList.add('active');
        });
    }

    // Update page title
    function updatePageTitle() {
        const pageTitle = document.getElementById('pageTitle');
        if (pageTitle) {
            pageTitle.textContent = 'Employers';
        }
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
    // Window resize event listener
    window.addEventListener('resize', handleResize);

    // ✅ Refresh data function - force reload with correct role
    function refreshData() {
        window.location.href = '${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=Employer';
    }

    // ✅ Delete user function
    function deleteUser(userId, fullName) {
        if (confirm('Are you sure you want to delete user: ' + fullName + '?')) {
            window.location.href = '${pageContext.request.contextPath}/UserManagementServlet?action=delete&userId=' + userId + '&userRole=Employer';
        }
    }

    // Add this to each JSP's existing JavaScript
    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.getElementById('sidebar');
        const currentPath = window.location.pathname;

        // Apply section-specific class based on current page
        if (currentPath.includes('dashboard.jsp')) {
            sidebar.classList.add('section-dashboard');
        } else if (currentPath.includes('UMjobseeker.jsp') || currentPath.includes('userRole=JobSeeker')) {
            sidebar.classList.add('section-jobseekers');
        } else if (currentPath.includes('UMemployers.jsp') || currentPath.includes('userRole=Employer')) {
            sidebar.classList.add('section-employers');
        } else if (currentPath.includes('UMrecruiters.jsp') || currentPath.includes('userRole=Recruiter')) {
            sidebar.classList.add('section-recruiters');
        } else if (currentPath.includes('UMcounselors.jsp') || currentPath.includes('userRole=JobCounsellor')) {
            sidebar.classList.add('section-counselors');
        } else if (currentPath.includes('Aadminassistants.jsp') || currentPath.includes('ManageAdminAssistants')) {
            sidebar.classList.add('section-admin-assistants');
        }
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
</script>
</body>
</html>