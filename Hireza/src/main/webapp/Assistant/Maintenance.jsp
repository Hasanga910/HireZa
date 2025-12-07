<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Maintenance</title>

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

        /* Additional styles for the maintenance page */
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

        .status-badge.pending {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-badge.rejected {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .status-badge.expired {
            background-color: #e5e7eb;
            color: #374151;
        }

        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }
    </style>
</head>
<body>
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
            <a href="Rejected-job-posts.jsp" class="nav-link">
                <i class="fas fa-times-circle"></i>
                <span class="nav-text">Rejected Posts</span>
            </a>
        </li>

        <li class="nav-header">Communication</li>
        <li class="nav-item">
            <a href="Reminder-history.jsp" class="nav-link">
                <i class="fas fa-history"></i>
                <span class="nav-text">Reminder History</span>
            </a>
        </li>

        <li class="nav-header">Data Management</li>
        <li class="nav-item">
            <a href="Maintenance.jsp" class="nav-link active">
                <i class="fas fa-database"></i>
                <span class="nav-text">Data Maintenance</span>
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
            <h1 class="page-title" id="pageTitle">Data Maintenance</h1>
        </div>
        <div class="navbar-right">
            <div class="admin-profile" id="adminProfile">
                <div class="d-flex align-items-center">
                    <div class="profile-avatar">AA</div>
                    <div class="profile-info me-3">
                        <h6>Admin Assistant</h6>
                        <small>Job Post Manager</small>
                    </div>
                    <i class="fas fa-chevron-down profile-chevron" id="profileChevron"></i>
                </div>

                <!-- Dropdown Menu -->
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <h6>Admin Assistant</h6>
                        <small>assistant@hireza.com</small>
                    </div>
                    <div class="dropdown-menu-custom">
                        <a href="assistant-settings.jsp" class="dropdown-item-custom">
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

    <!-- Data Maintenance Content -->
    <div class="content-area">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-database me-2"></i>Data Maintenance Center</h2>
            <p>Manage system data, perform cleanup operations, backup/restore data, and maintain database integrity.</p>
        </div>



        <!-- Job Posts Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Job Posts</h5>
            </div>
</body>
</html>