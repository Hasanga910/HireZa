<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.RecruiterDAO, model.Recruiter, dao.InterviewDAO, model.Interview, dao.JobPostDAO, model.JobPost, java.util.List, dao.JobNotificationDAO, model.Notification2, java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    Recruiter recruiter = recruiterDAO.getRecruiterByUserId(user.getId());
    InterviewDAO interviewDAO = new InterviewDAO();
    JobPostDAO jobPostDAO = new JobPostDAO();
    List<Interview> interviews = recruiter != null ? interviewDAO.getInterviewsByCompanyId(recruiter.getCompanyId()) : null;

    // Fetch notifications
    JobNotificationDAO notificationDAO = new JobNotificationDAO();
    List<Notification2> notifications = null;
    int unreadCount = 0;

    if (recruiter != null && recruiter.getCompanyId() != null) {
        notifications = notificationDAO.getNotificationsByCompanyId(recruiter.getCompanyId());
        unreadCount = notificationDAO.getUnreadNotificationsCount(recruiter.getCompanyId());
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interviews - Job Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/jpeg" href="/HireZa/images/recruiter/2.jpg">
    <style>
        /* Global Styles */
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

        /* Navbar Styles */
        .navbar {
            background: linear-gradient(90deg, #007bff, #00c4b4);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            height: 60px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffffff;
            white-space: nowrap;
            display: flex;
            align-items: center;
            transition: opacity 0.3s ease;
        }

        .navbar .logo:hover {
            opacity: 0.9;
        }

        .navbar .logo img {
            height: 2.2rem;
            width: auto;
            margin-right: 0.5rem;
            object-fit: contain;
            vertical-align: middle;
        }

        /* Right side container for notification and profile */
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* Notification Styles */
        .notification-container {
            position: relative;
        }

        .notification-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            position: relative;
        }

        .notification-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .notification-btn i {
            color: white;
            font-size: 1.2rem;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff4757;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .notification-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            width: 400px;
            max-height: 500px;
            overflow-y: auto;
            z-index: 1001;
            margin-top: 10px;
        }

        .notification-dropdown.show {
            display: block;
        }

        .notification-header {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8f9fa;
            border-radius: 8px 8px 0 0;
        }

        .notification-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .notification-clear {
            background: none;
            border: none;
            color: #007bff;
            cursor: pointer;
            font-size: 0.9rem;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.2s ease;
        }

        .notification-clear:hover {
            background-color: #e6f0fa;
        }

        .notification-clear:disabled {
            color: #6c757d;
            cursor: not-allowed;
        }

        .notification-list {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        .notification-item {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .notification-item:hover {
            background-color: #f8f9fa;
        }

        .notification-item.unread {
            background-color: #e6f2ff;
            border-left: 3px solid #007bff;
        }

        .notification-item.read {
            background-color: white;
            opacity: 0.8;
        }

        .notification-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            font-size: 0.95rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .notification-message {
            color: #666;
            font-size: 0.85rem;
            line-height: 1.4;
            margin-bottom: 5px;
        }

        .notification-job {
            color: #007bff;
            font-size: 0.8rem;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .notification-time {
            color: #999;
            font-size: 0.75rem;
        }

        .notification-empty {
            padding: 40px 20px;
            text-align: center;
            color: #999;
        }

        .notification-empty i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #ddd;
        }

        .notification-empty p {
            margin: 0;
            font-size: 0.9rem;
        }

        .mark-read-btn {
            background: none;
            border: none;
            color: #007bff;
            cursor: pointer;
            font-size: 0.8rem;
            padding: 2px 8px;
            border-radius: 3px;
        }

        .mark-read-btn:hover {
            background-color: #e6f0fa;
        }

        /* Profile Box Styles */
        .navbar .profile-box {
            position: relative;
            cursor: pointer;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }

        .navbar .profile-box:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .navbar .profile-box img {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 0.5rem;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .navbar .profile-box .profile-image-placeholder {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.5rem;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .navbar .profile-box .profile-image-placeholder i {
            color: #ffffff;
            font-size: 1.2rem;
        }

        .navbar .profile-box .profile-info span {
            font-size: 0.9rem;
            font-weight: 500;
            color: #ffffff;
            white-space: nowrap;
        }

        .navbar .profile-box .dropdown-content {
            display: none;
            position: absolute;
            background-color: #ffffff;
            min-width: 180px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            border-radius: 6px;
            right: 0;
            z-index: 1;
            top: 100%;
            font-size: 0.9rem;
            margin-top: 0.5rem;
            overflow: hidden;
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
            transition: background-color 0.2s ease;
        }

        .navbar .profile-box .dropdown-content a:hover {
            background-color: #e6f0fa;
            color: #007bff;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: #2d3436;
            color: #dfe6e9;
            padding: 1.5rem;
            box-shadow: 2px 0 12px rgba(0, 0, 0, 0.2);
            position: fixed;
            top: 60px;
            height: calc(100vh - 60px);
            z-index: 900;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            font-size: 1rem;
            border-right: 1px solid #636e72;
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar.collapsed {
            width: 60px;
            padding: 1rem;
        }

        .sidebar.collapsed .group-title,
        .sidebar.collapsed a span {
            display: none;
        }

        .sidebar.collapsed .header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .sidebar.collapsed a {
            padding: 0.75rem;
            justify-content: center;
        }

        .sidebar.collapsed a i {
            margin: 0;
            font-size: 1.5rem;
        }

        .sidebar .header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 1.5rem;
            background: none;
            min-height: 2rem;
        }

        .sidebar .toggle-icon {
            cursor: pointer;
            color: #dfe6e9;
            font-size: 1.4rem;
            transition: transform 0.3s ease, color 0.3s ease;
            line-height: 1.3;
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

        .sidebar a {
            color: #dfe6e9;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            border-radius: 6px;
            transition: background-color 0.3s ease, color 0.3s ease;
            font-size: 0.95rem;
            white-space: nowrap;
            background-color: #353b48;
        }

        .sidebar a i {
            margin-right: 0.5rem;
            color: #00c4b4;
        }

        .sidebar a:hover {
            background-color: #00c4b4;
            color: #ffffff;
        }

        .sidebar a:hover i {
            color: #ffffff;
        }

        .sidebar .group-title {
            font-size: 0.85rem;
            color: #b2bec3;
            margin: 1rem 0 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            line-height: 1.3;
        }

        .sidebar .sign-out {
            margin-top: 0.5rem;
            border-top: 1px solid #636e72;
            padding-top: 0.5rem;
        }

        /* Toggle Button for Sidebar (Mobile) */
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
            transition: background-color 0.3s ease;
        }

        .mobile-toggle-btn:hover {
            background-color: #0056b3;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 250px;
            padding: 6rem 2rem 2rem 4rem;
            width: calc(100% - 250px);
            box-sizing: border-box;
            min-height: calc(100vh - 60px);
            transition: margin-left 0.3s ease, width 0.3s ease, padding-right 0.3s ease;
        }

        .main-content.collapsed {
            margin-left: 0;
            padding: 6rem 2rem 2rem 4rem;
            width: 100%;
        }

        .main-content.expanded {
            margin-left: 60px;
            width: calc(100% - 60px);
            padding-right: 2rem;
            padding-left: 4rem;
        }

        .header {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 1.8rem;
            margin: 0 0 1rem;
            color: #007bff;
            font-weight: 600;
        }

        /* Card Styles */
        .interviews-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .interviews-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .interviews-card h2 {
            font-size: 1.5rem;
            margin: 0 0 1rem;
            color: #007bff;
            font-weight: 600;
        }

        .interviews-card table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        .interviews-card th, .interviews-card td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .interviews-card th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }

        .interviews-card td {
            font-size: 0.95rem;
            color: #444;
        }

        .interviews-card .no-posts {
            text-align: center;
            padding: 20px;
            color: #6c757d;
            font-size: 1rem;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: inline-block;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 6rem 2rem 2rem 4rem;
            }

            .main-content.expanded {
                margin-left: 60px;
                width: calc(100% - 60px);
                padding-right: 2rem;
                padding-left: 4rem;
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

            .navbar-right {
                gap: 10px;
            }

            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                height: auto;
                padding: 1rem;
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
                padding: 6rem 2rem 2rem 4rem;
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
                width: 100%;
                padding: 6rem 2rem 2rem 4rem;
            }

            .interviews-card table {
                display: block;
                overflow-x: auto;
            }

            .notification-dropdown {
                width: 300px;
                right: -50px;
            }

            .btn {
                width: 100%;
                padding: 0.75rem;
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
                margin-bottom: 0;
            }

            .navbar .logo img {
                height: 1.7rem;
                width: auto;
            }

            .navbar-right {
                gap: 8px;
            }

            .navbar .profile-box {
                padding: 0.3rem 0.8rem;
                height: 35px;
            }

            .navbar .profile-box img,
            .navbar .profile-box .profile-image-placeholder {
                width: 30px;
                height: 30px;
            }

            .navbar .profile-box .profile-image-placeholder i {
                font-size: 1rem;
            }

            .navbar .profile-box .profile-info span {
                font-size: 0.75rem;
            }

            .notification-btn {
                width: 35px;
                height: 35px;
            }

            .notification-btn i {
                font-size: 1rem;
            }

            .notification-badge {
                width: 18px;
                height: 18px;
                font-size: 0.6rem;
            }

            .notification-dropdown {
                width: 280px;
                right: -80px;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .btn {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Navbar -->
    <nav class="navbar" id="navbar">
        <div class="logo">
            <img src="/HireZa/images/employer/1.jpg" alt="HireZa Logo">
            HireZa
        </div>
        <div class="navbar-right">
            <!-- Notification Button -->
            <div class="notification-container">
                <button class="notification-btn" id="notificationBtn">
                    <i class="fas fa-bell"></i>
                    <% if (unreadCount > 0) { %>
                    <span class="notification-badge" id="notificationBadge"><%= unreadCount > 99 ? "99+" : unreadCount %></span>
                    <% } %>
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <div class="notification-header">
                        <h3>Notifications</h3>
                        <% if (notifications != null && !notifications.isEmpty()) { %>
                        <button class="notification-clear" id="clearNotifications">Mark All Read</button>
                        <% } else { %>
                        <button class="notification-clear" id="clearNotifications" disabled>Mark All Read</button>
                        <% } %>
                    </div>
                    <ul class="notification-list" id="notificationList">
                        <% if (notifications == null || notifications.isEmpty()) { %>
                        <div class="notification-empty">
                            <i class="fas fa-bell-slash"></i>
                            <p>No notifications yet</p>
                        </div>
                        <% } else {
                            for (Notification2 notification : notifications) {
                        %>
                        <li class="notification-item <%= notification.getIsRead() ? "read" : "unread" %>"
                            data-notification-id="<%= notification.getNotificationId() %>">
                            <div class="notification-title">
                                <span><%= notification.getMessage() != null ? notification.getMessage() : "New Notification" %></span>
                                <% if (!notification.getIsRead()) { %>
                                <button class="mark-read-btn" onclick="markAsRead('<%= notification.getNotificationId() %>', this)">Mark Read</button>
                                <% } %>
                            </div>
                            <% if (notification.getJobTitle() != null && !notification.getJobTitle().isEmpty()) { %>
                            <div class="notification-job">
                                <i class="fas fa-briefcase"></i> <%= notification.getJobTitle() %>
                            </div>
                            <% } %>
                            <div class="notification-time">
                                <i class="far fa-clock"></i>
                                <%= notification.getCreatedAt() != null ?
                                        dateFormat.format(notification.getCreatedAt()) : "Recently" %>
                            </div>
                        </li>
                        <% }
                        } %>
                    </ul>
                </div>
            </div>
            <!-- Profile Box -->
            <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">
                <% if (recruiter != null && recruiter.getProfileImage() != null && !recruiter.getProfileImage().isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/Recruiter/images/<%= recruiter.getProfileImage() %>"
                     alt="Profile"
                     title="<%= user.getFullName() != null ? user.getFullName() : user.getUsername() %>">
                <% } else { %>
                <div class="profile-image-placeholder">
                    <i class="fas fa-user"></i>
                </div>
                <% } %>
                <div class="profile-info">
                    <span><%= user.getFullName() != null ? user.getFullName() : user.getUsername() %></span>
                </div>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/recruiter/profile">Edit Profile</a>
                    <a href="#" onclick="signOut()">Sign Out</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Toggle Button for Sidebar (Mobile) -->
    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>

    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="header">
            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>
        </div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/Recruiter/recruiter_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
            <li class="group-title">Jobs</li>
            <li><a href="${pageContext.request.contextPath}/Recruiter/select_job.jsp"><i class="fas fa-briefcase"></i> <span>Select Job</span></a></li>
            <li><a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp"><i class="fas fa-calendar-alt"></i> <span>Interviews</span></a></li>
            <li class="group-title">Profile</li>
            <li><a href="${pageContext.request.contextPath}/recruiter/profile"><i class="fas fa-user-edit"></i> <span>Edit Profile</span></a></li>
            <li class="sign-out">
                <a href="#" onclick="signOut()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="header">
            <h1>Interviews</h1>
        </div>
        <div class="interviews-card">
            <h2>Scheduled Interviews</h2>
            <% if (interviews == null || interviews.isEmpty()) { %>
            <p class="no-posts">No interviews scheduled.</p>
            <% } else { %>
            <table>
                <tr>
                    <th>Interview ID</th>
                    <th>Job Title</th>
                    <th>Interviewer</th>
                    <th>Mode</th>
                    <th>Scheduled At</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% for (Interview interview : interviews) {
                    JobPost job = jobPostDAO.getJobPostById(interview.getJobId());
                %>
                <tr>
                    <td><%= interview.getInterviewId() %></td>
                    <td><%= job != null ? job.getJobTitle() : "N/A" %></td>
                    <td><%= interview.getInterviewer() %></td>
                    <td><%= interview.getMode() %></td>
                    <td><%= interview.getScheduledAt() %></td>
                    <td><%= interview.getStatus() %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/Recruiter/interview_details.jsp?interviewId=<%= interview.getInterviewId() %>" class="btn">View Details</a>
                    </td>
                </tr>
                <% } %>
            </table>
            <% } %>
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
        window.location.href = '${pageContext.request.contextPath}/logout';
    }

    // Notification functionality
    document.addEventListener('DOMContentLoaded', function() {
        const notificationBtn = document.getElementById('notificationBtn');
        const notificationDropdown = document.getElementById('notificationDropdown');
        const clearNotificationsBtn = document.getElementById('clearNotifications');
        const notificationList = document.getElementById('notificationList');

        // Toggle notification dropdown
        notificationBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            notificationDropdown.classList.toggle('show');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function() {
            notificationDropdown.classList.remove('show');
        });

        // Prevent dropdown from closing when clicking inside
        notificationDropdown.addEventListener('click', function(e) {
            e.stopPropagation();
        });

        // Mark all as read
        clearNotificationsBtn.addEventListener('click', function() {
            if (!clearNotificationsBtn.disabled) {
                markAllAsRead();
            }
        });

        // Mark notification as read when clicked
        notificationList.addEventListener('click', function(e) {
            const notificationItem = e.target.closest('.notification-item');
            if (notificationItem && !e.target.classList.contains('mark-read-btn')) {
                const notificationId = notificationItem.getAttribute('data-notification-id');
                markAsRead(notificationId, notificationItem.querySelector('.mark-read-btn'));
            }
        });

        // Update notification badge count
        function updateNotificationBadge() {
            const unreadItems = document.querySelectorAll('.notification-item.unread');
            const badge = document.getElementById('notificationBadge');

            if (unreadItems.length > 0) {
                if (badge) {
                    badge.textContent = unreadItems.length > 99 ? '99+' : unreadItems.length;
                    badge.style.display = 'flex';
                }
            } else {
                if (badge) {
                    badge.style.display = 'none';
                }
            }
        }

        // Mark single notification as read
        window.markAsRead = function(notificationId, buttonElement) {
            fetch('${pageContext.request.contextPath}/MarkNotificationReadServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'notificationId=' + encodeURIComponent(notificationId)
            })
                .then(response => response.text())
                .then(data => {
                    if (data === 'SUCCESS') {
                        const notificationItem = buttonElement.closest('.notification-item');
                        notificationItem.classList.remove('unread');
                        notificationItem.classList.add('read');
                        buttonElement.remove();
                        updateNotificationBadge();

                        // Update clear button if no more unread notifications
                        if (document.querySelectorAll('.notification-item.unread').length === 0) {
                            document.getElementById('clearNotifications').disabled = true;
                        }
                    } else {
                        console.error('Failed to mark notification as read');
                    }
                })
                .catch(error => {
                    console.error('Error marking notification as read:', error);
                });
        }

        // Mark all notifications as read
        function markAllAsRead() {
            const companyId = '<%= recruiter != null ? recruiter.getCompanyId() : "" %>';
            if (!companyId) {
                alert('Company ID not found. Please refresh the page.');
                return;
            }

            fetch('${pageContext.request.contextPath}/MarkAllNotificationsReadServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'companyId=' + encodeURIComponent(companyId)
            })
                .then(response => response.text())
                .then(data => {
                    if (data === 'SUCCESS') {
                        // Update UI
                        const unreadItems = document.querySelectorAll('.notification-item.unread');
                        unreadItems.forEach(item => {
                            item.classList.remove('unread');
                            item.classList.add('read');
                            const markReadBtn = item.querySelector('.mark-read-btn');
                            if (markReadBtn) {
                                markReadBtn.remove();
                            }
                        });

                        // Update badge and clear button
                        updateNotificationBadge();
                        const clearNotificationsBtn = document.getElementById('clearNotifications');
                        if (clearNotificationsBtn) {
                            clearNotificationsBtn.disabled = true;
                        }
                    } else {
                        console.error('Failed to mark all notifications as read');
                    }
                })
                .catch(error => {
                    console.error('Error marking all notifications as read:', error);
                });
        }

        // Initialize badge count
        updateNotificationBadge();
    });
</script>
</body>
</html>