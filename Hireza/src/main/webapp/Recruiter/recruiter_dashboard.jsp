<%@ page import="model.User" %>
<%@ page import="dao.RecruiterDAO" %>
<%@ page import="model.JobPost" %>
<%@ page import="model.Recruiter" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.InterviewDAO" %>
<%@ page import="model.Interview" %>
<%@ page import="dao.JobNotificationDAO" %>
<%@ page import="model.Notification2" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    System.out.println("=== DEBUG RECRUITER DASHBOARD ===");
    System.out.println("User ID: " + user.getId());
    System.out.println("User Role: " + user.getRole());

    RecruiterDAO recruiterDAO = new RecruiterDAO();
    Recruiter recruiter = recruiterDAO.getRecruiterByUserId(user.getId());

    System.out.println("Recruiter object: " + (recruiter != null ? "Found" : "NULL"));
    if (recruiter != null) {
        System.out.println("Company ID: " + recruiter.getCompanyId());
        System.out.println("Recruiter ID: " + recruiter.getRecruiterId());
    }

    JobPostDAO jobPostDAO = new JobPostDAO();
    List<JobPost> posts = null;
    if (recruiter != null && recruiter.getCompanyId() != null) {
        posts = jobPostDAO.getAllJobPostsByCompanyId(recruiter.getCompanyId());
        System.out.println("Posts found: " + (posts != null ? posts.size() : "NULL"));
    } else {
        System.out.println("Cannot fetch posts - recruiter or companyId is null");
    }

    InterviewDAO interviewDAO = new InterviewDAO();
    List<Interview> interviews = null;
    if (recruiter != null && recruiter.getCompanyId() != null) {
        interviews = interviewDAO.getInterviewsByCompanyId(recruiter.getCompanyId());
        System.out.println("Interviews found: " + (interviews != null ? interviews.size() : "NULL"));
    } else {
        System.out.println("Cannot fetch interviews - recruiter or companyId is null");
    }

    // Fetch notifications
    JobNotificationDAO notificationDAO = new JobNotificationDAO();
    List<Notification2> notifications = null;
    int unreadCount = 0;

    if (recruiter != null && recruiter.getCompanyId() != null) {
        notifications = notificationDAO.getNotificationsByCompanyId(recruiter.getCompanyId());
        unreadCount = notificationDAO.getUnreadNotificationsCount(recruiter.getCompanyId());
        System.out.println("Notifications found: " + (notifications != null ? notifications.size() : "NULL"));
        System.out.println("Unread notifications: " + unreadCount);
    } else {
        System.out.println("Cannot fetch notifications - recruiter or companyId is null");
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
    System.out.println("=== END DEBUG ===");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Dashboard - Job Portal</title>
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

        /* Matching Dashboard UI - Notification Styles */
        .notification-container {
            position: relative;
        }

        .notification-btn {
            background: rgba(255, 255, 255, 0.15);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .notification-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }

        .notification-btn i {
            color: #ffffff;
            font-size: 1.2rem;
        }

        .notification-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff4757;
            color: white;
            border-radius: 10px;
            min-width: 20px;
            height: 20px;
            padding: 0 5px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            border: 2px solid #007bff;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        .notification-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            width: 400px;
            max-height: 500px;
            overflow: hidden;
            z-index: 1001;
            margin-top: 10px;
        }

        .notification-dropdown.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .notification-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, #007bff, #00c4b4);
        }

        .notification-header h3 {
            margin: 0;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .notification-actions {
            display: flex;
            gap: 8px;
        }

        .notification-action-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            cursor: pointer;
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.2s ease;
            font-weight: 600;
        }

        .notification-action-btn:hover:not(:disabled) {
            background: rgba(255, 255, 255, 0.3);
        }

        .notification-action-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .notification-list {
            padding: 0;
            margin: 0;
            list-style: none;
            max-height: 400px;
            overflow-y: auto;
        }

        .notification-list::-webkit-scrollbar {
            width: 6px;
        }

        .notification-list::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .notification-list::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }

        .notification-item {
            padding: 15px 20px;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.2s ease;
            position: relative;
        }

        .notification-item:hover {
            background-color: #f8f9fa;
        }

        .notification-item.unread {
            background: #e3f2fd;
            border-left: 3px solid #007bff;
        }

        .notification-item.read {
            background-color: white;
            opacity: 0.85;
        }

        .notification-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .notification-title {
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.9rem;
            line-height: 1.4;
            flex: 1;
            margin-right: 10px;
        }

        .notification-item-actions {
            display: flex;
            gap: 6px;
            flex-shrink: 0;
        }

        .notification-icon-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 4px;
            border-radius: 4px;
            transition: all 0.2s ease;
            color: #6c757d;
            font-size: 0.85rem;
        }

        .notification-icon-btn:hover {
            background: rgba(108, 117, 125, 0.1);
            color: #495057;
        }

        .notification-icon-btn.delete-btn:hover {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .notification-icon-btn.read-btn:hover {
            background: rgba(0, 123, 255, 0.1);
            color: #007bff;
        }

        .notification-message {
            color: #555;
            font-size: 0.85rem;
            line-height: 1.5;
            margin-bottom: 8px;
        }

        .notification-job {
            color: #007bff;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .notification-time {
            color: #95a5a6;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .notification-empty {
            padding: 60px 20px;
            text-align: center;
            color: #95a5a6;
        }

        .notification-empty i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #dfe6e9;
        }

        .notification-empty p {
            margin: 0;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .notification-empty small {
            display: block;
            margin-top: 8px;
            color: #b2bec3;
            font-size: 0.8rem;
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
        .welcome-card, .job-posts-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .welcome-card:hover, .job-posts-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .welcome-card h2 {
            font-size: 1.5rem;
            margin: 0 0 1rem;
            color: #007bff;
            font-weight: 600;
        }

        .company-info p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
            color: #444;
        }

        /* Table Styles */
        .job-posts-card table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        .job-posts-card th, .job-posts-card td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .job-posts-card th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }

        .job-posts-card td {
            font-size: 0.95rem;
            color: #444;
        }

        .job-posts-card .no-posts {
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

        /* Interviews Card Styles */
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
                justify-content: space-between;
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

            .btn {
                width: 100%;
                padding: 0.75rem;
            }

            .job-posts-card table {
                display: block;
                overflow-x: auto;
            }

            .notification-dropdown {
                width: 340px;
                right: -50px;
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

            .navbar .profile-box .profile-info span {
                font-size: 0.75rem;
            }

            .notification-btn {
                width: 36px;
                height: 36px;
            }

            .notification-btn i {
                font-size: 1.1rem;
            }

            .notification-badge {
                min-width: 18px;
                height: 18px;
                font-size: 0.65rem;
            }

            .notification-dropdown {
                width: 300px;
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
                <button class="notification-btn" id="notificationBtn" title="Notifications">
                    <i class="fas fa-bell"></i>
                    <% if (unreadCount > 0) { %>
                    <span class="notification-badge" id="notificationBadge"><%= unreadCount > 99 ? "99+" : unreadCount %></span>
                    <% } %>
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <div class="notification-header">
                        <h3><i class="fas fa-bell"></i> Notifications</h3>
                        <div class="notification-actions">
                            <% if (notifications != null && !notifications.isEmpty() && unreadCount > 0) { %>
                            <button class="notification-action-btn" id="markAllReadBtn" title="Mark all as read">
                                <i class="fas fa-check-double"></i> Mark All
                            </button>
                            <% } else { %>
                            <button class="notification-action-btn" id="markAllReadBtn" disabled title="No unread notifications">
                                <i class="fas fa-check-double"></i> Mark All
                            </button>
                            <% } %>
                        </div>
                    </div>
                    <ul class="notification-list" id="notificationList">
                        <% if (notifications == null || notifications.isEmpty()) { %>
                        <div class="notification-empty">
                            <i class="fas fa-bell-slash"></i>
                            <p>No notifications yet</p>
                            <small>You'll see updates about your job posts here</small>
                        </div>
                        <% } else {
                            for (Notification2 notification : notifications) {
                        %>
                        <li class="notification-item <%= notification.getIsRead() ? "read" : "unread" %>"
                            data-notification-id="<%= notification.getNotificationId() %>">
                            <div class="notification-item-header">
                                <div class="notification-title">
                                    <%= notification.getMessage() != null ? notification.getMessage() : "New Notification" %>
                                </div>
                                <div class="notification-item-actions">
                                    <% if (!notification.getIsRead()) { %>
                                    <button class="notification-icon-btn read-btn"
                                            onclick="markAsRead('<%= notification.getNotificationId() %>', this, event)"
                                            title="Mark as read">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <% } %>
                                    <button class="notification-icon-btn delete-btn"
                                            onclick="deleteNotification('<%= notification.getNotificationId() %>', this, event)"
                                            title="Delete notification">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
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
                <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="signOut()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="header">
            <h1>Recruiter Dashboard</h1>
        </div>
        <div class="welcome-card">
            <h2>Welcome, <%= user.getFullName() != null ? user.getFullName() : user.getUsername() %>!</h2>
            <div class="company-info">
                <p><strong>Full Name:</strong> <%= user.getFullName() != null ? user.getFullName() : "Not provided" %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <% if (recruiter != null) { %>
                <p><strong>Position:</strong> <%= recruiter.getPosition() != null ? recruiter.getPosition() : "Not provided" %></p>
                <% } %>
                <p><strong>Role:</strong> <%= user.getRole() %></p>
            </div>
        </div>
        <div class="job-posts-card">
            <h2>Job Posts</h2>
            <% if (posts == null || posts.isEmpty()) { %>
            <p class="no-posts">No job posts found.</p>
            <% } else { %>
            <table>
                <tr>
                    <th>Job Title</th>
                    <th>Work Mode</th>
                    <th>Location</th>
                    <th>Employment Type</th>
                    <th>Action</th>
                </tr>
                <% for (JobPost post : posts) { %>
                <tr>
                    <td><%= post.getJobTitle() %></td>
                    <td><%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></td>
                    <td><%= post.getLocation() != null ? post.getLocation() : "N/A" %></td>
                    <td><%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/company/applications?jobId=<%= post.getJobId() %>" class="btn">View Applications</a>
                    </td>
                </tr>
                <% } %>
            </table>
            <% } %>
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
        const markAllReadBtn = document.getElementById('markAllReadBtn');
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
        if (markAllReadBtn) {
            markAllReadBtn.addEventListener('click', function() {
                if (!markAllReadBtn.disabled) {
                    markAllAsRead();
                }
            });
        }

        // Update notification badge count
        function updateNotificationBadge() {
            const unreadItems = document.querySelectorAll('.notification-item.unread');
            const badge = document.getElementById('notificationBadge');

            if (unreadItems.length > 0) {
                if (!badge) {
                    const newBadge = document.createElement('span');
                    newBadge.className = 'notification-badge';
                    newBadge.id = 'notificationBadge';
                    newBadge.textContent = unreadItems.length > 99 ? '99+' : unreadItems.length;
                    notificationBtn.appendChild(newBadge);
                } else {
                    badge.textContent = unreadItems.length > 99 ? '99+' : unreadItems.length;
                    badge.style.display = 'flex';
                }
            } else {
                if (badge) {
                    badge.remove();
                }
                // Disable mark all button when no unread notifications
                if (markAllReadBtn) {
                    markAllReadBtn.disabled = true;
                }
            }
        }

        // Mark single notification as read
        window.markAsRead = function(notificationId, buttonElement, event) {
            if (event) {
                event.stopPropagation();
            }

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

                        // Remove the read button
                        buttonElement.remove();

                        // Update badge
                        updateNotificationBadge();
                    } else {
                        console.error('Failed to mark notification as read:', data);
                        alert('Failed to mark notification as read. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error marking notification as read:', error);
                    alert('An error occurred. Please try again.');
                });
        }

        // Delete notification
        window.deleteNotification = function(notificationId, buttonElement, event) {
            if (event) {
                event.stopPropagation();
            }

            if (!confirm('Are you sure you want to delete this notification?')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/DeleteNotificationServlet', {
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

                        // Add fade out animation
                        notificationItem.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                        notificationItem.style.opacity = '0';
                        notificationItem.style.transform = 'translateX(20px)';

                        setTimeout(() => {
                            notificationItem.remove();

                            // Update badge
                            updateNotificationBadge();

                            // Check if notification list is empty
                            const remainingNotifications = document.querySelectorAll('.notification-item');
                            if (remainingNotifications.length === 0) {
                                notificationList.innerHTML = `
                                <div class="notification-empty">
                                    <i class="fas fa-bell-slash"></i>
                                    <p>No notifications yet</p>
                                    <small>You'll see updates about your job posts here</small>
                                </div>
                            `;
                                if (markAllReadBtn) {
                                    markAllReadBtn.disabled = true;
                                }
                            }
                        }, 300);
                    } else {
                        console.error('Failed to delete notification:', data);
                        alert('Failed to delete notification. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error deleting notification:', error);
                    alert('An error occurred. Please try again.');
                });
        }

        // Mark all notifications as read - FIXED VERSION
        function markAllAsRead() {
            const companyId = '<%= recruiter != null && recruiter.getCompanyId() != null ? recruiter.getCompanyId() : "" %>';

            console.log('Attempting to mark all as read with companyId:', companyId);

            if (!companyId || companyId === '') {
                alert('Company ID not found. Please refresh the page and try again.');
                return;
            }

            // Show loading state
            if (markAllReadBtn) {
                markAllReadBtn.disabled = true;
                markAllReadBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
            }

            fetch('${pageContext.request.contextPath}/MarkAllNotificationsReadServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'companyId=' + encodeURIComponent(companyId)
            })
                .then(response => {
                    console.log('Response status:', response.status);
                    return response.text();
                })
                .then(data => {
                    console.log('Response data:', data);

                    if (data.trim() === 'SUCCESS') {
                        // Update UI
                        const unreadItems = document.querySelectorAll('.notification-item.unread');
                        unreadItems.forEach(item => {
                            item.classList.remove('unread');
                            item.classList.add('read');
                            const readBtn = item.querySelector('.read-btn');
                            if (readBtn) {
                                readBtn.remove();
                            }
                        });

                        // Update badge
                        updateNotificationBadge();

                        // Keep button disabled
                        if (markAllReadBtn) {
                            markAllReadBtn.innerHTML = '<i class="fas fa-check-double"></i> Mark All';
                        }
                    } else {
                        console.error('Server returned non-SUCCESS response:', data);
                        alert('Failed to mark all notifications as read. Server response: ' + data);
                        // Reset button
                        if (markAllReadBtn) {
                            markAllReadBtn.disabled = false;
                            markAllReadBtn.innerHTML = '<i class="fas fa-check-double"></i> Mark All';
                        }
                    }
                })
                .catch(error => {
                    console.error('Error marking all notifications as read:', error);
                    alert('An error occurred while marking notifications as read. Please check the console and try again.');
                    // Reset button
                    if (markAllReadBtn) {
                        markAllReadBtn.disabled = false;
                        markAllReadBtn.innerHTML = '<i class="fas fa-check-double"></i> Mark All';
                    }
                });
        }

        // Initialize badge count
        updateNotificationBadge();
    });
</script>
</body>
</html>