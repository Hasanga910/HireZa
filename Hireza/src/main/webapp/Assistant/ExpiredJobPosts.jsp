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
    if (loggedInUser == null || !"AdminAssistant".equals(loggedInUser.getRole())) {
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

    // Redirect if accessed directly
    if (request.getAttribute("expiredJobs") == null) {
        response.sendRedirect(request.getContextPath() + "/ExpiredJobPostsServlet");
        return;
    }
    List<JobPost> expiredJobs = (List<JobPost>) request.getAttribute("expiredJobs");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    int totalExpired = expiredJobs != null ? expiredJobs.size() : 0;

    // Calculate statistics for the boxes
    int todayExpired = 0;
    int thisWeekExpired = 0;
    if (expiredJobs != null) {
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date weekStart = cal.getTime();

        String todayStr = dateFormat.format(today);

        for (JobPost job : expiredJobs) {
            if (job != null && job.getApplicationDeadline() != null) {
                try {
                    Date deadline = new Date(job.getApplicationDeadline().getTime());
                    String deadlineStr = dateFormat.format(deadline);

                    if (deadlineStr.equals(todayStr)) {
                        todayExpired++;
                    }

                    if (!deadline.before(weekStart)) {
                        thisWeekExpired++;
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
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expired Job Posts</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assistant.css">
    <style>
        .top-navbar, .sidebar, .content-area, .table {
            border: none !important;
            box-shadow: none !important;
        }
        .sidebar-brand {
            border-bottom: none !important;
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
        .loading-overlay.show {
            display: flex !important;
        }
        .loading-spinner {
            text-align: center;
        }
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
        .stats-card.expired {
            background: linear-gradient(135deg, #e2e8f0 0%, #edf2f7 100%);
            color: #1a202c;
        }
        .stats-card.today-expired {
            background: linear-gradient(135deg, #fef3c7 0%, #fef7cd 100%);
            color: #92400e;
        }
        .stats-card.week-expired {
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
        .stats-card.expired .stats-icon {
            background-color: #6b7280;
            color: #1a202c;
            box-shadow: 0 4px 8px rgba(107, 114, 128, 0.3);
        }
        .stats-card.today-expired .stats-icon {
            background-color: #fbbf24;
            color: #92400e;
            box-shadow: 0 4px 8px rgba(251, 191, 36, 0.3);
        }
        .stats-card.week-expired .stats-icon {
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
        .job-details {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 4px;
        }
        .job-details .separator {
            margin: 0 6px;
            color: #adb5bd;
        }
        .table td {
            vertical-align: middle;
        }
        .text-truncate {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 0.375rem;
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
            <a href="${pageContext.request.contextPath}/PendingJobPostsServlet" class="nav-link">
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
            <a href="${pageContext.request.contextPath}/ExpiredJobPostsServlet" class="nav-link active">
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
    <!-- Top Navbar -->
    <div class="top-navbar">
        <div class="navbar-left">
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1 class="page-title">Expired Job Posts</h1>
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
                <div class="profile-dropdown" id="profileDropdown">
                    <div class="dropdown-header">
                        <h6><%= loggedInUser.getFullName() != null ? loggedInUser.getFullName() : loggedInUser.getUsername() %></h6>
                        <small><%= loggedInUser.getEmail() %></small>
                    </div>
                    <div class="dropdown-menu-custom">
                        <a href="${pageContext.request.contextPath}/Assistant/Settings.jsp" class="dropdown-item-custom">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                        <div class="dropdown-divider-custom"></div>
                        <button class="dropdown-item-custom logout-item" onclick="handleLogout()">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <div class="welcome-section">
            <h2><i class="fas fa-calendar-times me-2"></i>Expired Job Posts</h2>
            <p>Review and manage job posts that have passed their application deadlines.</p>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stats-card expired">
                <div class="stats-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <div class="stats-number" id="totalExpired"><%= totalExpired %></div>
                <div class="stats-label">Total Expired</div>
                <div class="view-details">
                    View All <i class="fas fa-arrow-right"></i>
                </div>
            </div>
            <div class="stats-card today-expired">
                <div class="stats-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stats-number" id="todayExpired"><%= todayExpired %></div>
                <div class="stats-label">Expired Today</div>
                <div class="view-details">
                    View Today <i class="fas fa-arrow-right"></i>
                </div>
            </div>
            <div class="stats-card week-expired">
                <div class="stats-icon">
                    <i class="fas fa-calendar-week"></i>
                </div>
                <div class="stats-number" id="weekExpired"><%= thisWeekExpired %></div>
                <div class="stats-label">This Week</div>
                <div class="view-details">
                    View This Week <i class="fas fa-arrow-right"></i>
                </div>
            </div>
        </div>

        <!-- Expired Job Posts Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Expired Job Posts</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-container">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Location</th>
                            <th>Deadline</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="expiredJobsTable">
                        <%
                            if (expiredJobs != null && !expiredJobs.isEmpty()) {
                                for (JobPost job : expiredJobs) {
                                    String deadline = job.getApplicationDeadline() != null ?
                                            dateFormat.format(job.getApplicationDeadline()) : "N/A";
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
                            <td><%= deadline %></td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <button class="btn btn-outline-danger" onclick="deleteJobPost('<%= job.getJobId() %>')" title="Delete">
                                        <i class="fas fa-trash"></i>
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
                                <p class="text-muted">No expired job posts found.</p>
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
                    Showing <%= expiredJobs != null ? expiredJobs.size() : 0 %> expired job posts
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
                <h5 class="modal-title"><i class="fas fa-trash me-2"></i>Delete Job Post</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Deletion Confirmation:</strong> This action will permanently delete the job post. This cannot be undone.
                </div>
                <form id="deleteForm">
                    <div class="mb-3">
                        <label class="form-label">Deletion Notes (Optional)</label>
                        <textarea class="form-control" id="deletionNotes" rows="3" placeholder="Add any notes about the deletion..."></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmDeletion()">
                    <i class="fas fa-trash me-1"></i>Delete Job Post
                </button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    let currentJobId = null;

    document.addEventListener('DOMContentLoaded', () => {
        initializePage();
        setupSidebar();
        setupProfileDropdown();
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.add('show');
            setTimeout(() => {
                loadingOverlay.classList.remove('show');
                animateCounters();
            }, 800);
        }
    });

    function initializePage() {
        setActiveNavigation();
        console.log('Expired Job Posts page initialized for user:', '<%= loggedInUser.getUsername() %>');
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
            if (link.getAttribute('href').includes('ExpiredJobPostsServlet')) {
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
        if (confirm('Are you sure you want to log out?')) {
            showLoading();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
            }, 1000);
        }
    }

    function deleteJobPost(jobId) {
        currentJobId = jobId;
        console.log('Deleting job ID:', jobId);
        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        modal.show();
        document.getElementById('deleteForm').reset();
    }

    function confirmDeletion() {
        const notes = document.getElementById('deletionNotes').value;

        if (!currentJobId) {
            showAlert('Error: No job ID selected.', 'error');
            return;
        }

        if (confirm('Are you sure you want to permanently delete this job post?')) {
            showLoading();

            const deleteBtn = document.querySelector('#deleteModal .btn-danger');
            const originalText = deleteBtn.innerHTML;
            deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
            deleteBtn.disabled = true;

            const formData = new FormData();
            formData.append('jobId', currentJobId.toString());

            console.log('Sending deletion request for job ID:', currentJobId);

            fetch('${pageContext.request.contextPath}/DeleteRejectJobPostServlet', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);

                    if (data.success) {
                        showAlert(data.message, 'success');
                        const row = document.getElementById('jobRow-' + currentJobId);
                        if (row) {
                            row.remove();
                        }
                        updateJobCount();
                        updateStatistics();

                        const modal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
                        if (modal) {
                            modal.hide();
                        }
                    } else {
                        showAlert(data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Error deleting job post. Please try again.', 'error');
                })
                .finally(() => {
                    deleteBtn.innerHTML = originalText;
                    deleteBtn.disabled = false;
                    hideLoading();
                });
        }
    }

    function updateJobCount() {
        const table = document.getElementById('expiredJobsTable');
        const rows = table.querySelectorAll('tr');
        const countElement = document.querySelector('.card-footer .text-muted');

        let visibleCount = 0;
        rows.forEach(row => {
            if (row.cells.length > 1 && !row.querySelector('td.text-center')) {
                visibleCount++;
            }
        });

        if (countElement) {
            countElement.textContent = `Showing ${visibleCount} expired job posts`;
        }

        if (visibleCount === 0) {
            table.innerHTML = `
                <tr>
                    <td colspan="5" class="text-center py-4">
                        <i class="fas fa-inbox fa-2x text-muted mb-2"></i>
                        <p class="text-muted">No expired job posts found.</p>
                    </td>
                </tr>
            `;
        }
    }

    function updateStatistics() {
        const table = document.getElementById('expiredJobsTable');
        const rows = table.querySelectorAll('tr');

        const today = new Date();
        const todayStr = today.toISOString().split('T')[0];

        const weekStart = new Date(today);
        weekStart.setDate(today.getDate() - today.getDay() + (today.getDay() === 0 ? -6 : 1));
        weekStart.setHours(0, 0, 0, 0);

        let totalCount = 0;
        let todayCount = 0;
        let weekCount = 0;

        rows.forEach(row => {
            if (row.cells.length > 1 && !row.querySelector('td.text-center')) {
                totalCount++;

                const dateCell = row.cells[3];
                if (dateCell) {
                    const dateText = dateCell.textContent.trim();
                    if (dateText === todayStr) {
                        todayCount++;
                    }

                    const rowDate = new Date(dateText);
                    if (rowDate >= weekStart) {
                        weekCount++;
                    }
                }
            }
        });

        const totalElement = document.getElementById('totalExpired');
        const todayElement = document.getElementById('todayExpired');
        const weekElement = document.getElementById('weekExpired');

        if (totalElement) totalElement.textContent = totalCount;
        if (todayElement) todayElement.textContent = todayCount;
        if (weekElement) weekElement.textContent = weekCount;

        animateCounters();
    }
</script>
</body>
</html>