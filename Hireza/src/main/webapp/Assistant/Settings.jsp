<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.UserDAO, model.User, javax.servlet.http.HttpSession" %>
<%
    // Get user from session
    User currentUser = null;
    HttpSession userSession = request.getSession(false);
    if (userSession != null) {
        currentUser = (User) userSession.getAttribute("user");
    }

    // If no user in session, redirect to login
    if (currentUser == null) {
        response.sendRedirect("../Index.jsp");
        return;
    }

    // Initialize UserDAO
    UserDAO userDAO = new UserDAO();

    // Check for success/error messages from servlet
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    // Clear the messages after retrieving
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
    if (errorMessage != null) {
        session.removeAttribute("errorMessage");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>

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
        .content-area {
            border: none !important;
            box-shadow: none !important;
        }
        /* Remove the horizontal line below the logo */
        .sidebar-brand {
            border-bottom: none !important;
        }

        /* Additional styles for read-only form elements */
        .form-control[readonly] {
            background-color: #f8f9fa;
            border-color: #e9ecef;
            cursor: not-allowed;
        }

        .form-control:disabled {
            background-color: #f8f9fa;
            border-color: #e9ecef;
            cursor: not-allowed;
        }

        /* Profile photo styles */
        .profile-photo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(45deg, #007bff, #6610f2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
            margin: 0 auto 15px;
            position: relative;
        }

        .profile-photo-container {
            position: relative;
            display: inline-block;
        }

        .photo-upload-btn {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #007bff;
            color: white;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
        }

        /* Alert styles */
        .alert-auto-close {
            position: fixed;
            top: 100px;
            right: 20px;
            z-index: 1050;
            min-width: 300px;
            animation: slideInRight 0.3s, slideOutRight 0.3s 4.7s;
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        /* Enhanced Modal Styles */
        .modal-header.bg-success {
            background: linear-gradient(135deg, #28a745, #20c997) !important;
            border-bottom: none;
        }

        .modal-header.bg-danger {
            background: linear-gradient(135deg, #dc3545, #e83e8c) !important;
            border-bottom: none;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            font-weight: 600;
            padding: 8px 20px;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #218838, #1ea085);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #e83e8c);
            border: none;
            font-weight: 600;
            padding: 8px 20px;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #d91a7a);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }

        .modal-content {
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border: none;
        }

        .modal-header {
            border-radius: 12px 12px 0 0;
            padding: 15px 20px;
        }

        .modal-body {
            padding: 20px;
            font-size: 16px;
        }

        .modal-footer {
            border-top: 1px solid #e9ecef;
            padding: 15px 20px;
        }

        .modal-title {
            font-weight: 600;
            font-size: 18px;
        }

        /* Loading Overlay Styles - Updated to match Pending-job-posts.jsp */
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
    </style>
</head>
<body>
<!-- Loading Overlay - Updated to match Pending-job-posts.jsp -->
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
            <a href="Settings.jsp" class="nav-link active">
                <i class="fas fa-cog"></i>
                <span class="nav-text">Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content" id="mainContent">
    <!-- Top Navbar - Keep "Assistant Settings" title as requested -->
    <div class="top-navbar">
        <div class="navbar-left">
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1 class="page-title" id="pageTitle">Assistant Settings</h1>
        </div>
        <div class="navbar-right">
            <div class="admin-profile" id="adminProfile">
                <div class="d-flex align-items-center">
                    <div class="profile-avatar">
                        <%
                            if (currentUser != null) {
                                String[] nameParts = currentUser.getFullName().split(" ");
                                String initials = "";
                                for (String part : nameParts) {
                                    if (!part.isEmpty()) {
                                        initials += part.substring(0, 1).toUpperCase();
                                    }
                                }
                                out.print(initials.length() > 2 ? initials.substring(0, 2) : initials);
                            }
                        %>
                    </div>
                    <div class="profile-info me-3">
                        <h6><%= currentUser != null ? currentUser.getFullName() : "Admin Assistant" %></h6>
                        <small><%= currentUser != null ? currentUser.getRole() : "Job Post Manager" %></small>
                    </div>
                    <i class="fas fa-chevron-down profile-chevron" id="profileChevron"></i>
                </div>

                <!-- Dropdown Menu -->
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <h6><%= currentUser != null ? currentUser.getFullName() : "Admin Assistant" %></h6>
                        <small><%= currentUser != null ? currentUser.getEmail() : "assistant@hireza.com" %></small>
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

    <!-- Settings Content -->
    <div class="content-area">
        <div class="settings-container">
            <!-- Profile Information Card -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="settings-card">
                        <div class="card-header">
                            <h5><i class="fas fa-user-circle me-2"></i>Profile Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="profile-photo-section">
                                <div class="profile-photo-container">
                                    <div class="profile-photo" id="profilePhoto">
                                        <%
                                            if (currentUser != null) {
                                                String[] nameParts = currentUser.getFullName().split(" ");
                                                String initials = "";
                                                for (String part : nameParts) {
                                                    if (!part.isEmpty()) {
                                                        initials += part.substring(0, 1).toUpperCase();
                                                    }
                                                }
                                                out.print(initials.length() > 2 ? initials.substring(0, 2) : initials);
                                            }
                                        %>
                                    </div>
                                    <label for="photoUpload" class="photo-upload-btn">
                                        <i class="fas fa-camera"></i>
                                        <input type="file" id="photoUpload" accept="image/*" style="display: none;">
                                    </label>
                                </div>
                                <h6><%= currentUser != null ? currentUser.getFullName() : "Admin Assistant" %></h6>
                                <small class="text-muted"><%= currentUser != null ? currentUser.getRole() : "Job Post Manager" %></small>
                            </div>

                            <form id="profileForm">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" value="<%= currentUser != null ? currentUser.getFullName() : "Admin Assistant" %>" id="fullName" readonly>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" value="<%= currentUser != null ? currentUser.getEmail() : "assistant@hireza.com" %>" id="email" readonly>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" value="<%= currentUser != null ? (currentUser.getPhone() != null ? currentUser.getPhone() : "Not provided") : "+94 77 123 4567" %>" id="phone" readonly>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Username</label>
                                    <input type="text" class="form-control" value="<%= currentUser != null ? currentUser.getUsername() : "admin_assistant" %>" id="username" readonly>
                                </div>

                                <button type="submit" class="btn btn-primary w-100" disabled>
                                    <i class="fas fa-save me-2"></i>Update Profile
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Security Settings Card -->
                <div class="col-lg-6">
                    <div class="settings-card">
                        <div class="card-header">
                            <h5><i class="fas fa-shield-alt me-2"></i>Security Settings</h5>
                        </div>
                        <div class="card-body">
                            <!-- Fixed form action path -->
                            <form id="passwordForm" action="${pageContext.request.contextPath}/ChangePasswordServlet" method="POST">
                                <input type="hidden" name="userId" value="<%= currentUser != null ? currentUser.getId() : "" %>">

                                <div class="form-group">
                                    <label class="form-label">Current Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">New Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <small class="text-danger" id="passwordMatchError" style="display: none;">Passwords do not match</small>
                                </div>

                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-lock me-2"></i>Update Password
                                </button>
                            </form>

                            <hr>

                            <div class="security-tip">
                                <i class="fas fa-lightbulb text-warning me-2"></i>
                                <strong>Security Tip:</strong> Use a strong password with at least 8 characters, including uppercase, lowercase, numbers, and special characters.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success Alert Modal -->
<div class="modal fade" id="successModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">
                    <i class="fas fa-check-circle me-2"></i>Success
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="successMessage">Settings updated successfully!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Error Alert Modal -->
<div class="modal fade" id="errorModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-circle me-2"></i>Error
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="errorMessage">An error occurred while updating settings.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        initializeSettings();
        setupSidebar();
        setupProfileDropdown();
        setupForms();

        // Show loading overlay briefly for better UX - Updated to match Pending-job-posts.jsp
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
            }, 800);
        }

        // Check for messages from servlet and show appropriate modal
        <% if (successMessage != null) { %>
        showSuccessMessage('<%= successMessage %>');
        <% } %>

        <% if (errorMessage != null) { %>
        showError('<%= errorMessage %>');
        <% } %>
    });

    function initializeSettings() {
        setActiveNavigation();
        console.log('Settings page initialized for user:', '<%= currentUser != null ? currentUser.getUsername() : "unknown" %>');
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

    function setupForms() {
        // Profile Form - Disabled as requested
        document.getElementById('profileForm').addEventListener('submit', (e) => {
            e.preventDefault();
            showSuccessMessage('Profile information cannot be modified.');
        });

        // Password Form
        document.getElementById('passwordForm').addEventListener('submit', (e) => {
            if (!validatePasswordForm()) {
                e.preventDefault();
            }
        });

        // Real-time password confirmation check
        document.getElementById('confirmPassword').addEventListener('keyup', checkPasswordMatch);
        document.getElementById('newPassword').addEventListener('keyup', checkPasswordMatch);

        // Photo Upload
        document.getElementById('photoUpload').addEventListener('change', (e) => {
            handlePhotoUpload(e);
        });
    }

    function validatePasswordForm() {
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (!currentPassword || !newPassword || !confirmPassword) {
            showError('Please fill in all password fields');
            return false;
        }

        if (newPassword !== confirmPassword) {
            showError('New passwords do not match');
            return false;
        }

        return true;
    }

    function checkPasswordMatch() {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const errorElement = document.getElementById('passwordMatchError');

        if (confirmPassword && newPassword !== confirmPassword) {
            errorElement.style.display = 'block';
        } else {
            errorElement.style.display = 'none';
        }
    }

    function setActiveNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === 'Settings.jsp') {
                link.classList.add('active');
            }
        });
    }

    function handlePhotoUpload(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const profilePhoto = document.getElementById('profilePhoto');
                profilePhoto.style.backgroundImage = `url(${e.target.result})`;
                profilePhoto.style.backgroundSize = 'cover';
                profilePhoto.style.backgroundPosition = 'center';
                profilePhoto.textContent = '';
            };
            reader.readAsDataURL(file);
        }
    }

    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        const button = field.nextElementSibling.querySelector('i');

        if (field.type === 'password') {
            field.type = 'text';
            button.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            field.type = 'password';
            button.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }

    function showSuccessMessage(message) {
        document.getElementById('successMessage').textContent = message;
        const modal = new bootstrap.Modal(document.getElementById('successModal'));
        modal.show();
    }

    function showError(message) {
        document.getElementById('errorMessage').textContent = message;
        const modal = new bootstrap.Modal(document.getElementById('errorModal'));
        modal.show();
    }

    // Loading functions - Updated to match Pending-job-posts.jsp
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

    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {
            showLoading();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
            }, 500);
        }
    }
</script>

</body>
</html>