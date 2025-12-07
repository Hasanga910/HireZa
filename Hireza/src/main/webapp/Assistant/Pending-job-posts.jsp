<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobPost" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.User" %>
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

    // Redirect if accessed directly - prevents empty data
    if (request.getAttribute("pendingJobs") == null) {
        response.sendRedirect(request.getContextPath() + "/PendingJobPostsServlet");
        return;
    }
    List<JobPost> pendingJobs = (List<JobPost>) request.getAttribute("pendingJobs");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    System.out.println("Pending jobs : " + (pendingJobs != null ? pendingJobs.size() : "null"));

    // Calculate statistics for the boxes
    int totalPending = 0;
    int todayPending = 0;
    int thisWeekPending = 0;

    if (pendingJobs != null) {
        totalPending = pendingJobs.size();

        // Calculate today's and this week's pending posts
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date weekStart = cal.getTime();

        String todayStr = dateFormat.format(today);

        for (JobPost job : pendingJobs) {
            if (job != null && job.getCreatedAt() != null) {
                try {
                    Date postDate = new Date(job.getCreatedAt().getTime());
                    String postDateStr = dateFormat.format(postDate);

                    if (postDateStr.equals(todayStr)) {
                        todayPending++;
                    }

                    if (!postDate.before(weekStart)) {
                        thisWeekPending++;
                    }
                } catch (Exception e) {
                    System.err.println("Error processing date for job: " + e.getMessage());
                }
            }
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <img src="../images/index/favicon.png" alt="HireZa Logo">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Job Posts</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assistant.css">

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

        /* Loading Overlay Styles - Updated to match Dashboard */
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

        /* Statistics Cards Styles - Updated to match Dashboard */
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

        .stats-card.today {
            background: linear-gradient(135deg, #d1fae5 0%, #d5fae9 100%);
            color: #065f46;
        }

        .stats-card.week {
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

        .stats-card.today .stats-icon {
            background-color: #10b981;
            color: #065f46;
            box-shadow: 0 4px 8px rgba(16, 185, 129, 0.3);
        }

        .stats-card.week .stats-icon {
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

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
            border-radius: 0.375rem;
        }

        .alert-warning .fas {
            color: #ffc107;
        }

        /* Job details styling - Updated to match Approved job posts */
        .job-details {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 4px;
        }

        .job-details .separator {
            margin: 0 6px;
            color: #adb5bd;
        }

        /* Additional styling to match Approved job posts */
        .table td {
            vertical-align: middle;
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
<!-- Loading Overlay - Updated to match Dashboard -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner">
        <i class="fas fa-spinner fa-spin fa-3x text-primary mb-3"></i>
        <p class="h5">Loading...</p>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="#" class="sidebar-brand">
        <img src="${pageContext.request.contextPath}/images/index/favicon.png" alt="HireZa Logo">
        <span class="brand-text">HireZa</span>
    </a>

    <ul class="sidebar-nav">
        <li class="nav-header">Dashboard</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/Assistant/Dashboard.jsp" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                <span class="nav-text">Overview</span>
            </a>
        </li>

        <li class="nav-header">Job Post Management</li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/PendingJobPostsServlet" class="nav-link active">
                <i class="fas fa-clock"></i>
                <span class="nav-text">Pending Posts</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/Assistant/Approved-job-posts.jsp" class="nav-link">
                <i class="fas fa-check-circle"></i>
                <span class="nav-text">Approved Posts</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/Assistant/Rejected-job-posts.jsp" class="nav-link">
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
            <a href="${pageContext.request.contextPath}/Assistant/Settings.jsp" class="nav-link">
                <i class="fas fa-cog"></i>
                <span class="nav-text">Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content" id="mainContent">
    <!-- Top Navbar - Title remains "Pending Job Post" as requested -->
    <div class="top-navbar">
        <div class="navbar-left">
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1 class="page-title" id="pageTitle">Pending Job Post</h1>
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
            <h2><i class="fas fa-clock me-2"></i>Pending Job Posts</h2>
            <p>Review and approve or reject job posts submitted by employers. Ensure all posts meet quality standards.</p>
        </div>

        <!-- Statistics Cards - Updated to match Dashboard -->
        <div class="stats-grid">
            <div class="stats-card pending">
                <div class="stats-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stats-number" id="totalPending"><%= totalPending %></div>
                <div class="stats-label">Total Pending</div>
                <div class="view-details">
                    View All <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card today">
                <div class="stats-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stats-number" id="todayPending"><%= todayPending %></div>
                <div class="stats-label">Pending Today</div>
                <div class="view-details">
                    View Today <i class="fas fa-arrow-right"></i>
                </div>
            </div>

            <div class="stats-card week">
                <div class="stats-icon">
                    <i class="fas fa-calendar-week"></i>
                </div>
                <div class="stats-number" id="weekPending"><%= thisWeekPending %></div>
                <div class="stats-label">This Week</div>
                <div class="view-details">
                    View This Week <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <!-- Pending Job Posts Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Pending Job Posts</h5>
                <div class="d-flex gap-2">
                    <!-- Optional buttons can be added here -->
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-container">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Location</th>
                            <th>Submitted Date</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="pendingJobsTable">
                        <%
                            if (pendingJobs != null && !pendingJobs.isEmpty()) {
                                for (JobPost job : pendingJobs) {
                                    String submittedDate = job.getCreatedAt() != null ?
                                            dateFormat.format(job.getCreatedAt()) : "N/A";
                        %>
                        <tr id="jobRow-<%= job.getJobId() %>">
                            <td class="text-truncate" title="<%= job.getJobTitle() %>">
                                <strong><%= job.getJobTitle() %></strong>
                                <div class="job-details">
                                    <small class="text-muted">
                                        <%= job.getEmploymentType() != null ? job.getEmploymentType() : "Not specified" %>
                                        <span class="separator">•</span>
                                        <%= job.getWorkMode() != null ? job.getWorkMode() : "Not specified" %>
                                        <span class="separator">•</span>
                                        <%= job.getSalaryRange() != null ? job.getSalaryRange() : "Salary not specified" %>
                                    </small>
                                </div>
                            </td>
                            <td><%= job.getCompanyName() %></td>
                            <td><%= job.getLocation() %></td>
                            <td><%= submittedDate %></td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <button class="btn btn-outline-success" onclick="approveJobPost('<%= job.getJobId() %>')" title="Approve">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button class="btn btn-outline-danger" onclick="rejectJobPost('<%= job.getJobId() %>')" title="Reject">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-4">
                                <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No pending job posts found.</p>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer d-flex justify-content-between align-items-center">
                <div class="text-muted">
                    Showing <%= pendingJobs != null ? pendingJobs.size() : 0 %> pending job posts
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Approval Modal -->
<div class="modal fade" id="approvalModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-check me-2"></i>Approve Job Post</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-success">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Approval Confirmation:</strong> This job post will be published and visible to job seekers.
                </div>
                <form id="approvalForm">
                    <div class="mb-3">
                        <label class="form-label">Approval Notes</label>
                        <textarea class="form-control" id="approvalNotes" rows="3" placeholder="Add any notes about the approval..."></textarea>
                    </div>
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Approval notification will be sent to employer automatically.
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success" onclick="confirmApproval()">
                    <i class="fas fa-check me-1"></i>Approve Job Post
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Rejection Modal -->
<div class="modal fade" id="rejectionModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-times me-2"></i>Reject Job Post</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Rejection Confirmation:</strong> This job post will be rejected and the employer will be notified.
                </div>
                <form id="rejectionForm">
                    <div class="mb-3">
                        <label class="form-label">Rejection Details *</label>
                        <textarea class="form-control" id="rejectionDetails" rows="3" required placeholder="Provide detailed explanation for the rejection..."></textarea>
                    </div>
                    <div class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i>
                        Rejection notification will be sent to employer automatically.
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmRejection()">
                    <i class="fas fa-times me-1"></i>Reject Job Post
                </button>
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

    let currentJobId = null;

    document.addEventListener('DOMContentLoaded', () => {
        initializePage();
        setupSidebar();
        setupProfileDropdown();

        // Show loading overlay briefly for better UX - Updated to match Dashboard
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
            }, 800);
        }

        // Animate counters - New function to match Dashboard
        animateCounters();
    });

    function initializePage() {
        setActiveNavigation();
        console.log('Pending Job Posts page initialized for user:', currentUser.username);
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
            if (link.getAttribute('href').includes('PendingJobPostsServlet')) {
                link.classList.add('active');
            }
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

    // New function to animate counters - matches Dashboard
    function animateCounters() {
        const counters = document.querySelectorAll('.stats-number');
        counters.forEach(counter => {
            counter.style.opacity = '0.7';
            setTimeout(() => {
                counter.style.opacity = '1';
            }, Math.random() * 1000 + 500);
        });
    }

    function approveJobPost(jobId) {
        currentJobId = jobId;
        console.log('Approving job ID:', jobId);
        const modal = new bootstrap.Modal(document.getElementById('approvalModal'));
        modal.show();
        document.getElementById('approvalForm').reset();
    }

    function confirmApproval() {
        const notes = document.getElementById('approvalNotes').value;

        if (!currentJobId) {
            showAlert('Error: No job ID selected.', 'error');
            return;
        }

        if (confirm('Are you sure you want to approve this job post?')) {
            showLoading();

            // Show loading state on button
            const approveBtn = document.querySelector('#approvalModal .btn-success');
            const originalText = approveBtn.innerHTML;
            approveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Approving...';
            approveBtn.disabled = true;

            // Create FormData for the request
            const formData = new FormData();
            formData.append('action', 'approve');
            formData.append('jobId', currentJobId.toString());
            formData.append('notes', notes);

            console.log('Sending approval request for job ID:', currentJobId);

            fetch('${pageContext.request.contextPath}/PendingJobPostsServlet', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);

                    if (data.success) {
                        showAlert(data.message, 'success');
                        // Remove the row from the table
                        const row = document.getElementById('jobRow-' + currentJobId);
                        if (row) {
                            row.remove();
                        }
                        // Update the counter and statistics
                        updateJobCount();
                        updateStatistics();

                        // Close the modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('approvalModal'));
                        if (modal) {
                            modal.hide();
                        }
                    } else {
                        showAlert(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Error approving job post. Please try again.', 'error');
                })
                .finally(() => {
                    // Restore button state
                    approveBtn.innerHTML = originalText;
                    approveBtn.disabled = false;
                    hideLoading();
                });
        }
    }

    function rejectJobPost(jobId) {
        currentJobId = jobId;
        console.log('Rejecting job ID:', jobId);
        const modal = new bootstrap.Modal(document.getElementById('rejectionModal'));
        modal.show();
        document.getElementById('rejectionForm').reset();
    }

    function confirmRejection() {
        const details = document.getElementById('rejectionDetails').value;

        if (!currentJobId) {
            showAlert('Error: No job ID selected.', 'error');
            return;
        }

        if (!details.trim()) {
            showAlert('Please provide rejection details.', 'warning');
            document.getElementById('rejectionDetails').focus();
            return;
        }

        if (confirm('Are you sure you want to reject this job post?')) {
            showLoading();

            // Show loading state
            const rejectBtn = document.querySelector('#rejectionModal .btn-danger');
            const originalText = rejectBtn.innerHTML;
            rejectBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Rejecting...';
            rejectBtn.disabled = true;

            // Create FormData for the request
            const formData = new FormData();
            formData.append('action', 'reject');
            formData.append('jobId', currentJobId.toString());
            formData.append('rejectionDetails', details);

            console.log('Sending rejection request for job ID:', currentJobId);

            fetch('${pageContext.request.contextPath}/PendingJobPostsServlet', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);

                    if (data.success) {
                        showAlert(data.message, 'success');
                        // Remove the row from the table
                        const row = document.getElementById('jobRow-' + currentJobId);
                        if (row) {
                            row.remove();
                        }
                        // Update the counter and statistics
                        updateJobCount();
                        updateStatistics();

                        // Close the modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('rejectionModal'));
                        if (modal) {
                            modal.hide();
                        }
                    } else {
                        showAlert(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Error rejecting job post. Please try again.', 'error');
                })
                .finally(() => {
                    // Restore button state
                    rejectBtn.innerHTML = originalText;
                    rejectBtn.disabled = false;
                    hideLoading();
                });
        }
    }

    function updateJobCount() {
        const table = document.getElementById('pendingJobsTable');
        const rows = table.querySelectorAll('tr');
        const countElement = document.querySelector('.card-footer .text-muted');

        let visibleCount = 0;
        rows.forEach(row => {
            if (row.cells.length > 1 && !row.querySelector('td.text-center')) {
                visibleCount++;
            }
        });

        if (countElement) {
            countElement.textContent = `Showing ${visibleCount} pending job posts`;
        }

        // If no rows left, show empty message
        if (visibleCount === 0) {
            table.innerHTML = `
                <tr>
                    <td colspan="5" class="text-center py-4">
                        <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                        <p class="text-muted">No pending job posts found.</p>
                    </td>
                </tr>
            `;
        }
    }

    function updateStatistics() {
        const table = document.getElementById('pendingJobsTable');
        const rows = table.querySelectorAll('tr');

        // Calculate today's date for comparison
        const today = new Date();
        const todayStr = today.toISOString().split('T')[0];

        // Calculate start of week (Monday)
        const weekStart = new Date(today);
        weekStart.setDate(today.getDate() - today.getDay() + (today.getDay() === 0 ? -6 : 1));
        weekStart.setHours(0, 0, 0, 0);

        let totalCount = 0;
        let todayCount = 0;
        let weekCount = 0;

        rows.forEach(row => {
            if (row.cells.length > 1 && !row.querySelector('td.text-center')) {
                totalCount++;

                // Get the date from the fourth column (index 3)
                const dateCell = row.cells[3];
                if (dateCell) {
                    const dateText = dateCell.textContent.trim();
                    if (dateText === todayStr) {
                        todayCount++;
                    }

                    // Check if date is within this week
                    const rowDate = new Date(dateText);
                    if (rowDate >= weekStart) {
                        weekCount++;
                    }
                }
            }
        });

        // Update statistics boxes
        const totalElement = document.getElementById('totalPending');
        const todayElement = document.getElementById('todayPending');
        const weekElement = document.getElementById('weekPending');

        if (totalElement) totalElement.textContent = totalCount;
        if (todayElement) todayElement.textContent = todayCount;
        if (weekElement) weekElement.textContent = weekCount;

        // Animate the updated counters
        animateCounters();
    }

    function showAlert(message, type) {
        // Remove existing alerts
        const existingAlerts = document.querySelectorAll('.custom-alert');
        existingAlerts.forEach(alert => alert.remove());

        // Create alert element
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

        // Add to page
        document.body.appendChild(alertDiv);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (alertDiv.parentElement) {
                alertDiv.remove();
            }
        }, 5000);
    }

    function handleLogout() {
        if (confirm('Are you sure you want to log out?')) {
            showLoading();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
            }, 1000);
        }
    }
</script>
</body>
</html>