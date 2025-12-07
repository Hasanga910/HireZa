<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company" %>
<%!
    private String companyId;
%><%
    User employer = (User) session.getAttribute("user");
    if (employer == null || !"Employer".equals(employer.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(employer.getId());
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company" %>
<%@ page import="dao.NotificationDAO, model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Employer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    companyDAO = new CompanyDAO();
    company = companyDAO.getCompanyByUserId(user.getId());
    String companyId = (company != null) ? company.getCompanyId() : "0";
    session.setAttribute("companyId", companyId);
    String companyLogo = (company != null && company.getLogo() != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/150?text=Logo";
    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";

    // Fetch notifications and unread count
    NotificationDAO notifDAO = new NotificationDAO();
    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);
    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Recruiter - Job Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/jpeg" href="${pageContext.request.contextPath}/images/employer/2.jpg">
    <style>
        /* Existing styles remain unchanged */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            transition: top 0.3s ease;
            height: 60px;
        }

        .navbar.hidden {
            top: -60px;
        }

        .navbar .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #007bff;
            white-space: nowrap;
            display: flex;
            align-items: center;
        }

        .navbar .logo img {
            height: 2.2rem;
            width: auto;
            margin-right: 0.5rem;
            object-fit: contain;
            vertical-align: middle;
        }

        .navbar .profile-box {
            position: relative;
            cursor: pointer;
            background-color: #f9fbfc;
            padding: 0.3rem 0.8rem;
            border-radius: 5px;
            border: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            height: 40px;
        }

        .navbar .profile-box img {
            width: 30px;
            height: 30px;
            margin-right: 0.5rem;
            object-fit: cover;
        }

        .navbar .profile-box .profile-info {
            display: flex;
            flex-direction: column;
        }

        .navbar .profile-box .profile-info span {
            font-size: 0.85rem;
            white-space: nowrap;
        }

        .navbar .profile-box .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            right: 0;
            z-index: 1;
            top: 100%;
            font-size: 0.95rem;
        }

        .navbar .profile-box:hover .dropdown-content {
            display: block;
        }

        .navbar .profile-box .dropdown-content a {
            color: #333;
            padding: 0.75rem 1rem;
            text-decoration: none;
            display: block;
            white-space: nowrap;
        }

        .navbar .profile-box .dropdown-content a:hover {
            background-color: #f4f7fa;
        }

        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, #1e3a8a, #172554);
            color: white;
            padding: 1.5rem;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 60px;
            height: calc(100vh - 60px);
            z-index: 900;
            transition: top 0.3s ease;
            display: flex;
            flex-direction: column;
            font-size: 1rem;
        }

        .sidebar.adjusted {
            top: 0;
            height: 100vh;
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar.collapsed {
            width: 60px;
            padding: 1rem;
        }

        .sidebar.collapsed .header h2,
        .sidebar.collapsed .group-title,
        .sidebar.collapsed a span {
            display: none;
        }

        .sidebar.collapsed a {
            padding: 0.5rem;
            justify-content: center;
        }

        .sidebar.collapsed a i {
            margin: 0;
            font-size: 1.5rem;
        }

        .sidebar .header {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            background: none;
            min-height: 1.2rem;
            line-height: 1.3;
        }

        .sidebar h2 {
            font-size: 1.2rem;
            margin: 0;
            color: #ffffff;
            border-bottom: 1px solid #334455;
            padding-bottom: 0.5rem;
            flex-grow: 1;
            background: none;
            line-height: 1.3;
        }

        .sidebar .toggle-icon {
            cursor: pointer;
            color: #aabbcc;
            font-size: 1.2rem;
            transition: transform 0.3s ease;
            padding: 0 0.5rem;
            line-height: 1.3;
            vertical-align: middle;
        }

        .sidebar .toggle-icon:hover {
            color: #ffffff;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .sidebar li {
            margin-bottom: 0.5rem;
        }

        .sidebar li:first-child {
            margin-bottom: 0.3rem;
        }

        .sidebar a {
            color: #aabbcc;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            font-size: 0.95rem;
            white-space: nowrap;
            line-height: 1.3;
        }

        .sidebar a i {
            margin-right: 0.5rem;
        }

        .sidebar a:hover {
            background-color: #007bff;
            color: white;
        }

        .sidebar .group-title {
            font-size: 0.85rem;
            color: #ccddee;
            margin: 1rem 0 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            line-height: 1.3;
        }

        .sidebar .sign-out {
            margin-top: 0.5rem;
            border-top: 1px solid #334455;
            padding-top: 0.5rem;
        }

        .mobile-toggle-btn {
            display: none;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 950;
        }

        .mobile-toggle-btn:hover {
            background-color: #0056b3;
        }

        .main-content {
            margin-left: 250px;
            padding: 6rem 2rem 2rem 5rem;
            width: calc(100% - 250px);
            box-sizing: border-box;
            min-height: calc(100vh - 60px);
            transition: margin-left 0.3s ease, width 0.3s ease, padding-right 0.3s ease;
        }

        .main-content.collapsed {
            margin-left: 0;
            padding: 6rem 2rem 2rem 2rem;
            width: 100%;
        }

        .main-content.expanded {
            margin-left: 60px;
            width: calc(100% - 60px);
            padding-right: 2rem;
            padding-left: 2rem;
        }

        .header {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 1.8rem;
            margin: 0 0 1rem;
            color: #007bff;
            text-align: left;
        }

        .form-container {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            max-width: 500px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #555;
            font-size: 0.95rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            font-size: 0.95rem;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        .error-message {
            color: red;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .field-error {
            color: red;
            font-size: 0.85rem;
            margin-top: 0.3rem;
            display: none;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 0.95rem;
            transition: background-color 0.3s;
            display: inline-block;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .back-btn {
            margin-top: 1rem;
            display: inline-block;
        }

        @media (max-width: 1024px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 6rem 2rem 2rem 2rem;
            }

            .main-content.expanded {
                margin-left: 60px;
                width: calc(100% - 60px);
                padding-right: 2rem;
                padding-left: 2rem;
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .navbar {
                flex-direction: row;
                padding: 1rem;
            }

            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                height: auto;
                padding: 1rem;
            }

            .sidebar.adjusted {
                top: 0;
                height: auto;
            }

            .sidebar.hidden {
                display: none;
            }

            .sidebar.collapsed {
                width: 100%;
            }

            .mobile-toggle-btn {
                display: block;
            }

            .main-content {
                margin-left: 0;
                padding: 6rem 2rem 2rem 2rem;
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
                width: 100%;
                padding: 6rem 2rem 2rem 2rem;
            }
        }

        @media (max-width: 480px) {
            .navbar {
                flex-direction: row;
                align-items: center;
                padding: 0.5rem 1rem;
            }

            .navbar .logo {
                font-size: 1.4rem;
            }

            .navbar .logo img {
                height: 1.7rem;
                width: auto;
            }

            .navbar .right-section {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .notification-container {
                margin-right: 0.3rem;
            }

            .notification-bell {
                font-size: 1rem;
                padding: 0.3rem;
            }

            .notification-badge {
                font-size: 0.65rem;
                padding: 1px 4px;
            }

            .notification-dropdown {
                width: 200px;
                max-height: 250px;
            }

            .navbar .profile-box {
                padding: 0.2rem 0.6rem;
                height: 35px;
            }

            .navbar .profile-box img {
                width: 25px;
                height: 25px;
            }

            .navbar .profile-box .profile-info span {
                font-size: 0.75rem;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .form-group .logo-preview img {
                max-width: 100px;
                max-height: 100px;
            }
        }

        .navbar .right-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .notification-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .notification-bell {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
            color: #555;
            position: relative;
            padding: 0.5rem;
            transition: color 0.3s;
        }

        .notification-bell:hover {
            color: #007bff;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #dc2626;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .notification-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            width: 300px;
            max-height: 400px;
            overflow-y: auto;
            z-index: 1000;
        }

        .notification-dropdown.show {
            display: block;
        }

        .notification-header {
            padding: 0.75rem;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9fbfc;
        }

        .notification-header h3 {
            margin: 0;
            font-size: 1rem;
            color: #333;
        }

        .notification-actions .clear-btn {
            background: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .notification-actions .clear-btn:hover {
            background: #0056b3;
        }

        .notification-list {
            max-height: 300px;
            overflow-y: auto;
        }

        .no-notifications {
            padding: 0.75rem;
            text-align: center;
            color: #666;
            font-size: 0.9rem;
        }

        .notification-item {
            padding: 0.75rem;
            border-bottom: 1px solid #e0e0e0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .notification-item:hover {
            background-color: #f4f7fa;
        }

        .notification-item.unread {
            background-color: #e6f3ff;
        }

        .notification-item.job_posting {
            border-left: 3px solid #007bff;
        }

        .notification-item.application {
            border-left: 3px solid #28a745;
        }

        .notification-item.message {
            border-left: 3px solid #ffc107;
        }

        .notification-content {
            display: flex;
            flex-direction: column;
        }

        .notification-message {
            font-size: 0.9rem;
            color: #333;
            margin-bottom: 0.25rem;
        }

        .notification-job-title {
            font-size: 0.85rem;
            color: #555;
            margin-bottom: 0.25rem;
        }

        .notification-notes {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.25rem;
        }

        .notification-time {
            font-size: 0.8rem;
            color: #999;
        }

        .notification-mark-read-btn {
            background: #28a745;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
            cursor: pointer;
            margin-top: 0.5rem;
            transition: background-color 0.3s;
        }

        .notification-mark-read-btn:hover {
            background: #218838;
        }

        .notification-footer {
            padding: 0.75rem;
            text-align: center;
            border-top: 1px solid #e0e0e0;
        }

        .notification-footer a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .notification-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Navbar -->
    <nav class="navbar" id="navbar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/employer/1.jpg" alt="HireZa Logo">
            HireZa
        </div>
        <div class="right-section">
            <div class="notification-container">
                <button class="notification-bell" onclick="toggleNotifications()">
                    <i class="fas fa-bell"></i>
                    <% if (unreadCount > 0) { %>
                    <span class="notification-badge" id="notificationBadge"><%= unreadCount %></span>
                    <% } %>
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <div class="notification-header">
                        <h3>Notifications</h3>
                        <div class="notification-actions">
                            <% if (unreadCount > 0) { %>
                            <button class="clear-btn" onclick="markAllAsRead()" style="font-size: 0.8rem; padding: 0.25rem 0.5rem;">
                                <i class="fas fa-check-double"></i> Mark all read
                            </button>
                            <% } %>
                        </div>
                    </div>
                    <div class="notification-list">
                        <% if (notifications.isEmpty()) { %>
                        <div class="no-notifications">No notifications</div>
                        <% } else {
                            for (Notification notification : notifications) {
                                String itemClass = "notification-item";
                                if (!notification.getIsRead()) itemClass += " unread";
                                itemClass += " " + notification.getType();
                        %>
                        <div class="<%= itemClass %>"
                             data-notification-id="<%= notification.getNotificationId() %>"
                             onclick="showDetails('<%= notification.getMessage().replace("\"", "\\\"").replace("'", "\\'") %>', '<%= notification.getJobTitle() != null ? notification.getJobTitle().replace("\"", "\\\"").replace("'", "\\'") : "" %>', '<%= notification.getAdminNotes() != null ? notification.getAdminNotes().replace("\"", "\\\"").replace("'", "\\'") : "" %>', '<%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>')">
                            <div class="notification-content">
                                <div class="notification-message"><%= notification.getMessage() %></div>
                                <div class="notification-job-title"><strong>Job:</strong> <%= notification.getJobTitle() %></div>
                                <% if (notification.getAdminNotes() != null && !notification.getAdminNotes().trim().isEmpty()) { %>
                                <div class="notification-notes"><strong>Notes:</strong> <%= notification.getAdminNotes() %></div>
                                <% } %>
                                <div class="notification-time">
                                    <%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>
                                </div>
                                <% if (!notification.getIsRead()) { %>
                                <button class="notification-mark-read-btn"
                                        onclick="event.stopPropagation(); markAsReadWithButton('<%= notification.getNotificationId() %>', this)">
                                    <i class="fas fa-check"></i> Mark as Read
                                </button>
                                <% } %>
                            </div>
                        </div>
                        <% } } %>
                    </div>
                    <div class="notification-footer">
                        <a href="#" onclick="showAllNotificationsModal()">View All Notifications</a>
                    </div>
                </div>
            </div>
            <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">
                <img src="<%= companyLogo %>" alt="Company Logo">
                <div class="profile-info">
                    <span><%= companyName %></span>
                </div>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp">Edit User Profile</a>
                    <a href="${pageContext.request.contextPath}/company/profile">Edit Company Profile</a>
                    <a href="#" onclick="showSignOutModal()">Sign Out</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Toggle Button for Sidebar (Mobile) -->
    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>

    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="header">
            <h2>Navigation</h2>
            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>
        </div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
            <li class="group-title">Jobs</li>
            <li><a href="${pageContext.request.contextPath}/company/jobs/post"><i class="fas fa-plus"></i> <span>Post New Job</span></a></li>
            <li><a href="${pageContext.request.contextPath}/company/jobs"><i class="fas fa-tasks"></i> <span>Manage Jobs</span></a></li>
            <li class="group-title">Team</li>
            <li><a href="${pageContext.request.contextPath}/Employer/manage_recruiters.jsp"><i class="fas fa-users"></i> <span>Manage Recruiters</span></a></li>
            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity"><i class="fas fa-chart-line"></i> <span>Recruiter Activity</span></a></li>
            <li class="group-title">Profile</li>
            <li><a href="${pageContext.request.contextPath}/company/profile"><i class="fas fa-building"></i> <span>Company Profile</span></a></li>
            <li><a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp"><i class="fas fa-user-edit"></i> <span>Edit User Profile</span></a></li>
            <li class="group-title">Applications</li>
            <li><a href="${pageContext.request.contextPath}/company/employer/applications"><i class="fas fa-file-alt"></i> <span>Employer View Applications</span></a></li>
            <li><a href="${pageContext.request.contextPath}/company/dashboard/charts"><i class="fas fa-chart-bar"></i> <span>Dashboard Charts</span></a></li>
            <li class="sign-out">
                <a href="#" onclick="showSignOutModal()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="header">
            <h1>Create New Recruiter</h1>
        </div>
        <div class="form-container">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div class="error-message"><%= error %></div>
            <%
                }
            %>
            <form action="${pageContext.request.contextPath}/company/create-recruiter" method="post" onsubmit="return validatePassword()">
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="username">Username *</label>
                    <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password" required>
                    <span id="passwordError" class="field-error"></span>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                    <span id="confirmPasswordError" class="field-error"></span>
                </div>
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
                </div>
                <button type="submit" class="btn"><i class="fas fa-plus"></i> Create Recruiter</button>
            </form>
            <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </main>
</div>


<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        sidebar.classList.toggle('hidden');
        mainContent.classList.toggle('collapsed');
    }

    function toggleSidebarCollapse() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleIcon = document.querySelector('.toggle-icon');
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('expanded');
        toggleIcon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';
    }

    function signOut() {
        window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
    }

    // Password Validation
    function validatePassword() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const passwordError = document.getElementById('passwordError');
        const confirmPasswordError = document.getElementById('confirmPasswordError');

        // Reset error messages
        passwordError.style.display = 'none';
        confirmPasswordError.style.display = 'none';
        passwordError.textContent = '';
        confirmPasswordError.textContent = '';

        let isValid = true;

        // Validate password length (minimum 6 characters)
        if (password.length < 6) {
            passwordError.textContent = 'Password must be at least 6 characters long.';
            passwordError.style.display = 'block';
            isValid = false;
        }

        // Validate confirm password
        if (password !== confirmPassword) {
            confirmPasswordError.textContent = 'Passwords do not match.';
            confirmPasswordError.style.display = 'block';
            isValid = false;
        }

        return isValid;
    }

    // Navbar and Sidebar scroll behavior
    let lastScrollTop = 0;
    const navbar = document.getElementById('navbar');
    const sidebar = document.getElementById('sidebar');
    const navbarHeight = navbar.offsetHeight;

    window.addEventListener('scroll', () => {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        if (scrollTop > lastScrollTop && scrollTop > navbarHeight) {
            navbar.classList.add('hidden');
            sidebar.classList.add('adjusted');
        } else if (scrollTop < lastScrollTop) {
            navbar.classList.remove('hidden');
            sidebar.classList.remove('adjusted');
        }

        lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
    });

    // Ensure sidebar adjusts on resize
    window.addEventListener('resize', () => {
        const sidebar = document.getElementById('sidebar');
        if (sidebar.classList.contains('adjusted')) {
            sidebar.style.top = '0';
            sidebar.style.height = '100vh';
        } else {
            sidebar.style.top = '60px';
            sidebar.style.height = `calc(100vh - ${navbarHeight}px)`;
        }
    });

    // Enhanced notification functions
    function toggleNotifications() {
        const dropdown = document.getElementById('notificationDropdown');
        const isShowing = dropdown.classList.contains('show');

        if (!isShowing) {
            // Refresh notifications when opening dropdown
            refreshNotifications();

            // Ensure scrolling works after dropdown opens
            setTimeout(() => {
                ensureNotificationListScroll();
            }, 100);
        }

        dropdown.classList.toggle('show');

        // Close dropdown when clicking outside
        if (dropdown.classList.contains('show')) {
            document.addEventListener('click', closeNotificationsOnClickOutside);
        } else {
            document.removeEventListener('click', closeNotificationsOnClickOutside);
        }
    }

    function ensureNotificationListScroll() {
        const notificationList = document.querySelector('.notification-dropdown .notification-list');
        if (notificationList) {
            const scrollHeight = notificationList.scrollHeight;
            const clientHeight = notificationList.clientHeight;

            if (scrollHeight > clientHeight) {
                console.log('Notification list is scrollable');
            }
        }
    }

    function closeNotificationsOnClickOutside(event) {
        const dropdown = document.getElementById('notificationDropdown');
        const bell = document.querySelector('.notification-bell');

        if (!dropdown.contains(event.target) && !bell.contains(event.target)) {
            dropdown.classList.remove('show');
            document.removeEventListener('click', closeNotificationsOnClickOutside);
        }
    }

    function refreshNotifications() {
        console.log('Refreshing notifications...');
        // Implement AJAX call here to refresh notifications if needed
    }

    function markAsReadWithButton(notificationId, button) {
        console.log('Marking notification as read via button:', notificationId);

        // Disable button immediately to prevent double clicks
        button.disabled = true;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Reading...';

        const notificationElement = button.closest('.notification-item');

        // Send AJAX request
        fetch('${pageContext.request.contextPath}/company/mark-notification-read', {
            method: 'POST',
            body: new URLSearchParams({
                notificationId: notificationId
            }),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    console.log('Notification marked as read successfully');
                    // Update UI
                    if (notificationElement) {
                        notificationElement.classList.remove('unread');
                        // Remove button with fade effect
                        button.style.transition = 'opacity 0.3s';
                        button.style.opacity = '0';
                        setTimeout(() => button.remove(), 300);
                    }
                    updateNotificationBadge();
                    showNotification('Notification marked as read', 'success');
                } else {
                    console.error('Failed to mark notification as read:', data.error);
                    button.disabled = false;
                    button.innerHTML = '<i class="fas fa-check"></i> Mark as Read';
                    showNotification('Failed to mark notification as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking notification as read:', error);
                button.disabled = false;
                button.innerHTML = '<i class="fas fa-check"></i> Mark as Read';
                showNotification('Error marking notification as read', 'error');
            });
    }

    function markAllAsRead() {
        // Update UI immediately
        document.querySelectorAll('.notification-item.unread').forEach(item => {
            item.classList.remove('unread');
        });

        // Update badge count
        updateNotificationBadge();

        // Send AJAX request to mark all as read
        const formData = new FormData();
        formData.append('companyId', '<%= companyId %>');

        fetch('${pageContext.request.contextPath}/company/mark-all-notifications-read', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('All notifications marked as read successfully');
                    showNotification('All notifications marked as read', 'success');

                    // Close dropdown
                    document.getElementById('notificationDropdown').classList.remove('show');
                } else {
                    console.error('Failed to mark all notifications as read:', data.error);
                    showNotification('Failed to mark all notifications as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking all notifications as read:', error);
                showNotification('Error marking notifications as read', 'error');
            });
    }

    function updateNotificationBadge() {
        const badge = document.getElementById('notificationBadge');
        const unreadItems = document.querySelectorAll('.notification-item.unread');
        const unreadCount = unreadItems.length;

        console.log('Updating badge, unread count:', unreadCount);

        if (unreadCount > 0) {
            if (badge) {
                badge.textContent = unreadCount;
            } else {
                createNotificationBadge(unreadCount);
            }
        } else {
            if (badge) {
                badge.remove();
            }
        }

        // Also update the server-side count via AJAX
        refreshNotificationCount();
    }

    function refreshNotificationCount() {
        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))
            .then(response => response.json())
            .then(data => {
                console.log('Server unread count:', data.unreadCount);
                const badge = document.getElementById('notificationBadge');
                const clientUnreadCount = document.querySelectorAll('.notification-item.unread').length;

                // If there's a discrepancy, use server count
                if (data.unreadCount !== clientUnreadCount) {
                    if (data.unreadCount > 0) {
                        if (badge) {
                            badge.textContent = data.unreadCount;
                        } else {
                            createNotificationBadge(data.unreadCount);
                        }
                    } else {
                        if (badge) {
                            badge.remove();
                        }
                    }
                }
            })
            .catch(error => console.error('Error refreshing notification count:', error));
    }

    function createNotificationBadge(count) {
        const bell = document.querySelector('.notification-bell');
        const badge = document.createElement('span');
        badge.className = 'notification-badge';
        badge.id = 'notificationBadge';
        badge.textContent = count;
        bell.appendChild(badge);
    }

    function checkNewNotifications() {
        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))
            .then(response => response.json())
            .then(data => {
                if (data.unreadCount > 0) {
                    const currentBadge = document.getElementById('notificationBadge');
                    if (currentBadge) {
                        const currentCount = parseInt(currentBadge.textContent);
                        if (data.unreadCount > currentCount) {
                            // New notifications arrived
                            currentBadge.textContent = data.unreadCount;
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    } else {
                        // Create new badge if it doesn't exist
                        createNotificationBadge(data.unreadCount);
                        if (data.unreadCount > 0) {
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    }
                }
            })
            .catch(error => console.error('Error checking notifications:', error));
    }

    // Notification Modal Functions
    function showAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'block';
    }

    function closeAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'none';
    }

    function showDetails(message, jobTitle, adminNotes, time) {
        document.getElementById('details-message').textContent = message;
        document.getElementById('details-job').textContent = jobTitle;
        document.getElementById('details-notes').textContent = adminNotes;
        document.getElementById('details-time').textContent = time;
        document.getElementById('notification-details-modal').style.display = 'block';
    }

    function closeDetailsModal() {
        document.getElementById('notification-details-modal').style.display = 'none';
    }

    // Check for new notifications every 30 seconds
    setInterval(() => {
        checkNewNotifications();
    }, 30000);
</script>
</body>
</html>