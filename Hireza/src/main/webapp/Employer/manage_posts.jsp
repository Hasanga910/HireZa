<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="model.User, dao.CompanyDAO, model.Company, model.JobPost, java.util.List, java.text.SimpleDateFormat" %>--%>
<%--<%@ page import="controller.DeadlineCheckServlet.DeadlineInfo" %>--%>
<%--<%@ page import="dao.NotificationDAO, model.Notification" %>--%>
<%--<%@ page import="java.util.ArrayList" %>--%>
<%--<%@ page import="controller.DeadlineCheckServlet" %>--%>
<%--<%@ page import="java.util.Date" %>--%>
<%--<%@ page import="java.util.concurrent.TimeUnit" %>--%>
<%--<%@ page import="dao.JobPostDAO" %>--%>
<%--<%--%>
<%--    User employer = (User) session.getAttribute("user");--%>
<%--    if (employer == null || !"Employer".equals(employer.getRole())) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--    CompanyDAO companyDAO = new CompanyDAO();--%>
<%--    Company company = companyDAO.getCompanyByUserId(employer.getId());--%>
<%--    String companyId = (company != null) ? company.getCompanyId() : "0";--%>
<%--    session.setAttribute("companyId", companyId);--%>
<%--    String companyLogo = (company != null && company.getLogo() != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/150?text=Logo";--%>
<%--    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";--%>

<%--    // Fetch notifications and unread count--%>
<%--    NotificationDAO notifDAO = new NotificationDAO();--%>
<%--    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);--%>
<%--    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);--%>

<%--    // Get all job posts for stats--%>
<%--    JobPostDAO jobPostDAO = new JobPostDAO();--%>
<%--    List<JobPost> allPosts = jobPostDAO.getAllJobPostsByCompanyId(companyId);--%>
<%--    List<JobPost> expiredPosts = new ArrayList<>();--%>
<%--    Date today = new Date();--%>
<%--    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Updated for full datetime format where applicable--%>

<%--    for (JobPost post : allPosts) {--%>
<%--        Date deadline = post.getApplicationDeadline();--%>
<%--        if (deadline != null && deadline.compareTo(today) <= 0) {--%>
<%--            expiredPosts.add(post);--%>
<%--        }--%>
<%--    }--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Manage Job Posts - Job Portal</title>--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">--%>
<%--    <link rel="icon" type="image/jpeg" href="${pageContext.request.contextPath}/images/employer/2.jpg">--%>
<%--    <style>--%>
<%--        /* Global Styles */--%>
<%--        body {--%>
<%--            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;--%>
<%--            margin: 0;--%>
<%--            padding: 0;--%>
<%--            background-color: #f4f7fa;--%>
<%--            color: #333;--%>
<%--            line-height: 1.6;--%>
<%--            overflow-x: hidden;--%>
<%--        }--%>

<%--        .container {--%>
<%--            display: flex;--%>
<%--            min-height: 100vh;--%>
<%--        }--%>

<%--        /* Navbar Styles */--%>
<%--        .navbar {--%>
<%--            background-color: #ffffff;--%>
<%--            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);--%>
<%--            padding: 1rem 2rem;--%>
<%--            position: fixed;--%>
<%--            width: 100%;--%>
<%--            top: 0;--%>
<%--            z-index: 1000;--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            align-items: center;--%>
<%--            box-sizing: border-box;--%>
<%--            transition: top 0.3s ease;--%>
<%--            height: 60px;--%>
<%--        }--%>

<%--        .navbar.hidden {--%>
<%--            top: -60px;--%>
<%--        }--%>

<%--        .navbar .logo {--%>
<%--            font-size: 1.8rem;--%>
<%--            font-weight: bold;--%>
<%--            color: #007bff;--%>
<%--            white-space: nowrap;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--        }--%>

<%--        .navbar .logo img {--%>
<%--            height: 2.2rem;--%>
<%--            width: auto;--%>
<%--            margin-right: 0.5rem;--%>
<%--            object-fit: contain;--%>
<%--            vertical-align: middle;--%>
<%--        }--%>

<%--        .navbar .right-section {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 1rem;--%>
<%--        }--%>

<%--        .navbar .profile-box {--%>
<%--            position: relative;--%>
<%--            cursor: pointer;--%>
<%--            background-color: #f9fbfc;--%>
<%--            padding: 0.3rem 0.8rem;--%>
<%--            border-radius: 5px;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            height: 40px;--%>
<%--        }--%>

<%--        .navbar .profile-box img {--%>
<%--            width: 30px;--%>
<%--            height: 30px;--%>
<%--            margin-right: 0.5rem;--%>
<%--            object-fit: cover;--%>
<%--        }--%>

<%--        .navbar .profile-box .profile-info {--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--        }--%>

<%--        .navbar .profile-box .profile-info span {--%>
<%--            font-size: 0.85rem;--%>
<%--            white-space: nowrap;--%>
<%--        }--%>

<%--        .navbar .profile-box .dropdown-content {--%>
<%--            display: none;--%>
<%--            position: absolute;--%>
<%--            background-color: white;--%>
<%--            min-width: 200px;--%>
<%--            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);--%>
<%--            border-radius: 5px;--%>
<%--            right: 0;--%>
<%--            z-index: 1;--%>
<%--            top: 100%;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        .navbar .profile-box:hover .dropdown-content {--%>
<%--            display: block;--%>
<%--        }--%>

<%--        .navbar .profile-box .dropdown-content a {--%>
<%--            color: #333;--%>
<%--            padding: 0.75rem 1rem;--%>
<%--            text-decoration: none;--%>
<%--            display: block;--%>
<%--            white-space: nowrap;--%>
<%--        }--%>

<%--        .navbar .profile-box .dropdown-content a:hover {--%>
<%--            background-color: #f4f7fa;--%>
<%--        }--%>

<%--        /* Notification Styles */--%>
<%--        .notification-container {--%>
<%--            position: relative;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--        }--%>

<%--        .notification-bell {--%>
<%--            position: relative;--%>
<%--            background: none;--%>
<%--            border: none;--%>
<%--            font-size: 1.5rem;--%>
<%--            color: #007bff;--%>
<%--            cursor: pointer;--%>
<%--            padding: 0.5rem;--%>
<%--            border-radius: 50%;--%>
<%--            transition: background-color 0.3s;--%>
<%--        }--%>

<%--        .notification-bell:hover {--%>
<%--            background-color: #f8f9fa;--%>
<%--        }--%>

<%--        .notification-badge {--%>
<%--            position: absolute;--%>
<%--            top: 0;--%>
<%--            right: 0;--%>
<%--            background-color: #dc3545;--%>
<%--            color: white;--%>
<%--            border-radius: 50%;--%>
<%--            width: 18px;--%>
<%--            height: 18px;--%>
<%--            font-size: 0.7rem;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            font-weight: bold;--%>
<%--        }--%>

<%--        .notification-dropdown {--%>
<%--            display: none;--%>
<%--            position: absolute;--%>
<%--            top: 100%;--%>
<%--            right: 0;--%>
<%--            width: 400px;--%>
<%--            max-height: 500px;--%>
<%--            background: white;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--            border-radius: 8px;--%>
<%--            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);--%>
<%--            z-index: 1000;--%>
<%--            overflow: hidden;--%>
<%--            flex-direction: column;--%>
<%--        }--%>

<%--        .notification-list {--%>
<%--            max-height: 350px;--%>
<%--            overflow-y: auto;--%>
<%--            overflow-x: hidden;--%>
<%--            flex: 1;--%>
<%--            min-height: 0;--%>
<%--        }--%>

<%--        .notification-actions {--%>
<%--            display: flex;--%>
<%--            gap: 0.5rem;--%>
<%--            flex-wrap: wrap;--%>
<%--        }--%>

<%--        .clear-btn, .mark-read-btn {--%>
<%--            background: none;--%>
<%--            border: none;--%>
<%--            padding: 0.4rem 0.8rem;--%>
<%--            border-radius: 6px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.75rem;--%>
<%--            font-weight: 500;--%>
<%--            transition: all 0.3s ease;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.3rem;--%>
<%--            white-space: nowrap;--%>
<%--        }--%>

<%--        .clear-btn {--%>
<%--            background-color: #dc3545;--%>
<%--            color: white;--%>
<%--            border: 1px solid #dc3545;--%>
<%--        }--%>

<%--        .clear-btn:hover {--%>
<%--            background-color: #c82333;--%>
<%--            border-color: #bd2130;--%>
<%--            transform: translateY(-1px);--%>
<%--            box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);--%>
<%--        }--%>

<%--        .mark-read-btn {--%>
<%--            background-color: #28a745;--%>
<%--            color: white;--%>
<%--            border: 1px solid #28a745;--%>
<%--        }--%>

<%--        .mark-read-btn:hover {--%>
<%--            background-color: #218838;--%>
<%--            border-color: #1e7e34;--%>
<%--            transform: translateY(-1px);--%>
<%--            box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3);--%>
<%--        }--%>

<%--        .clear-btn:disabled, .mark-read-btn:disabled {--%>
<%--            background-color: #6c757d;--%>
<%--            border-color: #6c757d;--%>
<%--            cursor: not-allowed;--%>
<%--            opacity: 0.6;--%>
<%--            transform: none;--%>
<%--            box-shadow: none;--%>
<%--        }--%>

<%--        .notification-mark-read-btn {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            padding: 0.3rem 0.6rem;--%>
<%--            border-radius: 4px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.75rem;--%>
<%--            margin-top: 0.5rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--        }--%>

<%--        .notification-mark-read-btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .notification-mark-read-btn:disabled {--%>
<%--            background-color: #6c757d;--%>
<%--            cursor: not-allowed;--%>
<%--            opacity: 0.6;--%>
<%--        }--%>

<%--        .notification-dropdown.show {--%>
<%--            display: flex;--%>
<%--        }--%>

<%--        .notification-header {--%>
<%--            padding: 1rem;--%>
<%--            border-bottom: 1px solid #e0e0e0;--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            align-items: center;--%>
<%--            flex-shrink: 0;--%>
<%--            background-color: white;--%>
<%--        }--%>

<%--        .notification-header h3 {--%>
<%--            margin: 0;--%>
<%--            color: #333;--%>
<%--            font-size: 1.1rem;--%>
<%--        }--%>

<%--        .notification-item {--%>
<%--            padding: 1rem;--%>
<%--            border-bottom: 1px solid #f0f0f0;--%>
<%--            cursor: pointer;--%>
<%--            transition: background-color 0.2s;--%>
<%--        }--%>

<%--        .notification-item:hover {--%>
<%--            background-color: #f8f9fa;--%>
<%--        }--%>

<%--        .notification-item.unread {--%>
<%--            background-color: #f0f7ff;--%>
<%--            border-left: 3px solid #007bff;--%>
<%--        }--%>

<%--        .notification-item.approved {--%>
<%--            border-left: 3px solid #28a745;--%>
<%--        }--%>

<%--        .notification-item.rejected {--%>
<%--            border-left: 3px solid #dc3545;--%>
<%--        }--%>

<%--        .notification-item.pending {--%>
<%--            border-left: 3px solid #ffc107;--%>
<%--        }--%>

<%--        .notification-item.info {--%>
<%--            border-left: 3px solid #17a2b8;--%>
<%--        }--%>

<%--        .notification-content {--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--        }--%>

<%--        .notification-message {--%>
<%--            font-weight: 500;--%>
<%--            margin-bottom: 0.25rem;--%>
<%--            color: #333;--%>
<%--        }--%>

<%--        .notification-job-title {--%>
<%--            font-size: 0.9rem;--%>
<%--            color: #666;--%>
<%--            margin-bottom: 0.25rem;--%>
<%--        }--%>

<%--        .notification-notes {--%>
<%--            font-size: 0.85rem;--%>
<%--            color: #888;--%>
<%--            font-style: italic;--%>
<%--            margin-bottom: 0.25rem;--%>
<%--        }--%>

<%--        .notification-time {--%>
<%--            font-size: 0.8rem;--%>
<%--            color: #999;--%>
<%--        }--%>

<%--        .notification-footer {--%>
<%--            padding: 1rem;--%>
<%--            border-top: 1px solid #e0e0e0;--%>
<%--            text-align: center;--%>
<%--            flex-shrink: 0;--%>
<%--            background-color: white;--%>
<%--        }--%>

<%--        .notification-footer a {--%>
<%--            color: #007bff;--%>
<%--            text-decoration: none;--%>
<%--            font-size: 0.9rem;--%>
<%--        }--%>

<%--        .notification-footer a:hover {--%>
<%--            text-decoration: underline;--%>
<%--        }--%>

<%--        .no-notifications {--%>
<%--            padding: 2rem 1rem;--%>
<%--            text-align: center;--%>
<%--            color: #999;--%>
<%--            font-style: italic;--%>
<%--        }--%>

<%--        /* Sidebar Styles */--%>
<%--        .sidebar {--%>
<%--            width: 250px;--%>
<%--            background: linear-gradient(135deg, #1e3a8a, #172554);--%>
<%--            color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);--%>
<%--            position: fixed;--%>
<%--            top: 60px;--%>
<%--            height: calc(100vh - 60px);--%>
<%--            z-index: 900;--%>
<%--            transition: top 0.3s ease;--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            font-size: 1rem;--%>
<%--        }--%>

<%--        .sidebar.adjusted {--%>
<%--            top: 0;--%>
<%--            height: 100vh;--%>
<%--        }--%>

<%--        .sidebar.hidden {--%>
<%--            transform: translateX(-100%);--%>
<%--        }--%>

<%--        .sidebar.collapsed {--%>
<%--            width: 60px;--%>
<%--            padding: 1rem;--%>
<%--        }--%>

<%--        .sidebar.collapsed .header h2,--%>
<%--        .sidebar.collapsed .group-title,--%>
<%--        .sidebar.collapsed a span {--%>
<%--            display: none;--%>
<%--        }--%>

<%--        .sidebar.collapsed a {--%>
<%--            padding: 0.5rem;--%>
<%--            justify-content: center;--%>
<%--        }--%>

<%--        .sidebar.collapsed a i {--%>
<%--            margin: 0;--%>
<%--            font-size: 1.5rem;--%>
<%--        }--%>

<%--        .sidebar .header {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            margin-bottom: 0.5rem;--%>
<%--            background: none;--%>
<%--            min-height: 1.2rem;--%>
<%--            line-height: 1.3;--%>
<%--        }--%>

<%--        .sidebar h2 {--%>
<%--            font-size: 1.2rem;--%>
<%--            margin: 0;--%>
<%--            color: #ffffff;--%>
<%--            border-bottom: 1px solid #334455;--%>
<%--            padding-bottom: 0.5rem;--%>
<%--            flex-grow: 1;--%>
<%--            background: none;--%>
<%--            line-height: 1.3;--%>
<%--        }--%>

<%--        .sidebar .toggle-icon {--%>
<%--            cursor: pointer;--%>
<%--            color: #aabbcc;--%>
<%--            font-size: 1.2rem;--%>
<%--            transition: transform 0.3s ease;--%>
<%--            padding: 0 0.5rem;--%>
<%--            line-height: 1.3;--%>
<%--            vertical-align: middle;--%>
<%--        }--%>

<%--        .sidebar .toggle-icon:hover {--%>
<%--            color: #ffffff;--%>
<%--        }--%>

<%--        .sidebar ul {--%>
<%--            list-style: none;--%>
<%--            padding: 0;--%>
<%--            margin: 0;--%>
<%--            flex-grow: 1;--%>
<%--        }--%>

<%--        .sidebar li {--%>
<%--            margin-bottom: 0.5rem;--%>
<%--        }--%>

<%--        .sidebar li:first-child {--%>
<%--            margin-bottom: 0.3rem;--%>
<%--        }--%>

<%--        .sidebar a {--%>
<%--            color: #aabbcc;--%>
<%--            text-decoration: none;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--            border-radius: 5px;--%>
<%--            transition: background-color 0.3s, color 0.3s;--%>
<%--            font-size: 0.95rem;--%>
<%--            white-space: nowrap;--%>
<%--            line-height: 1.3;--%>
<%--        }--%>

<%--        .sidebar a i {--%>
<%--            margin-right: 0.5rem;--%>
<%--        }--%>

<%--        .sidebar a:hover {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .sidebar .group-title {--%>
<%--            font-size: 0.85rem;--%>
<%--            color: #ccddee;--%>
<%--            margin: 1rem 0 0.5rem;--%>
<%--            text-transform: uppercase;--%>
<%--            letter-spacing: 1px;--%>
<%--            line-height: 1.3;--%>
<%--        }--%>

<%--        .sidebar .sign-out {--%>
<%--            margin-top: 0.5rem;--%>
<%--            border-top: 1px solid #334455;--%>
<%--            padding-top: 0.5rem;--%>
<%--        }--%>

<%--        /* Toggle Button for Sidebar (Mobile) */--%>
<%--        .mobile-toggle-btn {--%>
<%--            display: none;--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--            border-radius: 5px;--%>
<%--            cursor: pointer;--%>
<%--            position: fixed;--%>
<%--            top: 10px;--%>
<%--            left: 10px;--%>
<%--            z-index: 950;--%>
<%--        }--%>

<%--        .mobile-toggle-btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        /* Main Content Styles */--%>
<%--        .main-content {--%>
<%--            margin-left: 250px;--%>
<%--            padding: 6rem 2rem 2rem 5rem;--%>
<%--            width: calc(100% - 250px);--%>
<%--            box-sizing: border-box;--%>
<%--            min-height: calc(100vh - 60px);--%>
<%--            transition: margin-left 0.3s ease, width 0.3s ease, padding-right 0.3s ease;--%>
<%--        }--%>

<%--        .main-content.collapsed {--%>
<%--            margin-left: 0;--%>
<%--            padding: 6rem 2rem 2rem 2rem;--%>
<%--            width: 100%;--%>
<%--        }--%>

<%--        .main-content.expanded {--%>
<%--            margin-left: 60px;--%>
<%--            width: calc(100% - 60px);--%>
<%--            padding-right: 2rem;--%>
<%--            padding-left: 2rem;--%>
<%--        }--%>

<%--        .header {--%>
<%--            background-color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>

<%--        .header h1 {--%>
<%--            font-size: 1.8rem;--%>
<%--            margin: 0 0 1rem;--%>
<%--            color: #007bff;--%>
<%--            text-align: left;--%>
<%--        }--%>

<%--        .post-job-btn {--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>

<%--        .stats-box {--%>
<%--            background: linear-gradient(135deg, #007bff, #0056b3);--%>
<%--            color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            border-radius: 8px;--%>
<%--            margin-bottom: 2rem;--%>
<%--            display: flex;--%>
<%--            justify-content: space-around;--%>
<%--            align-items: center;--%>
<%--        }--%>

<%--        .stat-item {--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        .stat-item .number {--%>
<%--            font-size: 2.5rem;--%>
<%--            font-weight: bold;--%>
<%--        }--%>

<%--        .stat-item .label {--%>
<%--            font-size: 0.9rem;--%>
<%--            opacity: 0.9;--%>
<%--        }--%>

<%--        table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            background-color: white;--%>
<%--            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);--%>
<%--            border-radius: 10px;--%>
<%--            overflow: hidden;--%>
<%--        }--%>

<%--        th, td {--%>
<%--            padding: 1rem;--%>
<%--            text-align: left;--%>
<%--            border-bottom: 1px solid #e0e0e0;--%>
<%--        }--%>

<%--        th {--%>
<%--            background-color: #f9fbfc;--%>
<%--            font-weight: bold;--%>
<%--            color: #333;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        td {--%>
<%--            font-size: 0.9rem;--%>
<%--            color: #555;--%>
<%--        }--%>

<%--        tr:hover {--%>
<%--            background-color: #f4f7fa;--%>
<%--        }--%>

<%--        .btn {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--            text-decoration: none;--%>
<%--            border-radius: 5px;--%>
<%--            border: none;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.9rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--            display: inline-block;--%>
<%--            margin-right: 0.5rem;--%>
<%--        }--%>

<%--        .btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .btn-danger {--%>
<%--            background-color: #dc3545;--%>
<%--        }--%>

<%--        .btn-danger:hover {--%>
<%--            background-color: #c82333;--%>
<%--        }--%>

<%--        .btn-secondary {--%>
<%--            background-color: #6c757d;--%>
<%--            margin-top: 1.5rem;--%>
<%--        }--%>

<%--        .btn-secondary:hover {--%>
<%--            background-color: #545b62;--%>
<%--        }--%>

<%--        .no-posts {--%>
<%--            text-align: center;--%>
<%--            padding: 2rem;--%>
<%--            color: #6c757d;--%>
<%--            font-size: 1rem;--%>
<%--            background-color: white;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>

<%--        /* Toast Notification */--%>
<%--        .toast-notification {--%>
<%--            position: fixed;--%>
<%--            top: 20px;--%>
<%--            right: 20px;--%>
<%--            background: #007bff;--%>
<%--            color: white;--%>
<%--            padding: 12px 20px;--%>
<%--            border-radius: 5px;--%>
<%--            z-index: 10000;--%>
<%--            font-size: 14px;--%>
<%--            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);--%>
<%--            animation: slideIn 0.3s ease, fadeOut 0.3s ease 2.7s forwards;--%>
<%--        }--%>

<%--        .toast-notification.error {--%>
<%--            background: #dc3545;--%>
<%--        }--%>

<%--        .toast-notification.success {--%>
<%--            background: #28a745;--%>
<%--        }--%>

<%--        .toast-notification.info {--%>
<%--            background: #17a2b8;--%>
<%--        }--%>

<%--        @keyframes slideIn {--%>
<%--            from { transform: translateX(100%); opacity: 0; }--%>
<%--            to { transform: translateX(0); opacity: 1; }--%>
<%--        }--%>

<%--        @keyframes fadeOut {--%>
<%--            from { opacity: 1; }--%>
<%--            to { opacity: 0; }--%>
<%--        }--%>

<%--        /* Sign-out Popup */--%>
<%--        .signout-modal {--%>
<%--            display: none;--%>
<%--            position: fixed;--%>
<%--            z-index: 1000;--%>
<%--            left: 0;--%>
<%--            top: 0;--%>
<%--            width: 100%;--%>
<%--            height: 100%;--%>
<%--            background-color: rgba(0, 0, 0, 0.5);--%>
<%--        }--%>

<%--        .signout-modal-content {--%>
<%--            background-color: white;--%>
<%--            margin: 15% auto;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 5px;--%>
<%--            width: 90%;--%>
<%--            max-width: 400px;--%>
<%--            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        .signout-modal-content h2 {--%>
<%--            font-size: 1.4rem;--%>
<%--            margin: 0 0 1rem;--%>
<%--            color: #333;--%>
<%--        }--%>

<%--        .signout-modal-content p {--%>
<%--            font-size: 1rem;--%>
<%--            color: #666;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--        }--%>

<%--        .signout-modal-content button {--%>
<%--            padding: 0.5rem 1.5rem;--%>
<%--            margin: 0 0.5rem;--%>
<%--            border: none;--%>
<%--            border-radius: 5px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.9rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--        }--%>

<%--        .signout-modal-content .confirm-btn {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .signout-modal-content .confirm-btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .signout-modal-content .cancel-btn {--%>
<%--            background-color: #6c757d;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .signout-modal-content .cancel-btn:hover {--%>
<%--            background-color: #545b62;--%>
<%--        }--%>

<%--        /* Delete Confirmation Modal */--%>
<%--        .delete-modal {--%>
<%--            display: none;--%>
<%--            position: fixed;--%>
<%--            z-index: 1000;--%>
<%--            left: 0;--%>
<%--            top: 0;--%>
<%--            width: 100%;--%>
<%--            height: 100%;--%>
<%--            background-color: rgba(0, 0, 0, 0.5);--%>
<%--        }--%>

<%--        .delete-modal-content {--%>
<%--            background-color: white;--%>
<%--            margin: 15% auto;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 5px;--%>
<%--            width: 90%;--%>
<%--            max-width: 400px;--%>
<%--            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        .delete-modal-content h2 {--%>
<%--            font-size: 1.4rem;--%>
<%--            margin: 0 0 1rem;--%>
<%--            color: #333;--%>
<%--        }--%>

<%--        .delete-modal-content p {--%>
<%--            font-size: 1rem;--%>
<%--            color: #666;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--        }--%>

<%--        .delete-modal-content button {--%>
<%--            padding: 0.5rem 1.5rem;--%>
<%--            margin: 0 0.5rem;--%>
<%--            border: none;--%>
<%--            border-radius: 5px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.9rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--        }--%>

<%--        .delete-modal-content .confirm-btn {--%>
<%--            background-color: #dc3545;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .delete-modal-content .confirm-btn:hover {--%>
<%--            background-color: #c82333;--%>
<%--        }--%>

<%--        .delete-modal-content .cancel-btn {--%>
<%--            background-color: #6c757d;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .delete-modal-content .cancel-btn:hover {--%>
<%--            background-color: #545b62;--%>
<%--        }--%>

<%--        /* All Notifications Modal */--%>
<%--        .all-notifications-modal {--%>
<%--            display: none;--%>
<%--            position: fixed;--%>
<%--            z-index: 1100;--%>
<%--            left: 0;--%>
<%--            top: 0;--%>
<%--            width: 100%;--%>
<%--            height: 100%;--%>
<%--            background-color: rgba(0, 0, 0, 0.5);--%>
<%--            overflow: auto;--%>
<%--        }--%>

<%--        .all-notifications-modal-content {--%>
<%--            background-color: white;--%>
<%--            margin: 5% auto;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 8px;--%>
<%--            width: 90%;--%>
<%--            max-width: 700px;--%>
<%--            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);--%>
<%--            position: relative;--%>
<%--        }--%>

<%--        .close {--%>
<%--            position: absolute;--%>
<%--            top: 15px;--%>
<%--            right: 20px;--%>
<%--            font-size: 1.5rem;--%>
<%--            cursor: pointer;--%>
<%--            color: #aaa;--%>
<%--        }--%>

<%--        .close:hover {--%>
<%--            color: #000;--%>
<%--        }--%>

<%--        .modal-actions {--%>
<%--            display: flex;--%>
<%--            gap: 1rem;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            flex-wrap: wrap;--%>
<%--        }--%>

<%--        .modal-action-btn {--%>
<%--            padding: 0.6rem 1.2rem;--%>
<%--            border: none;--%>
<%--            border-radius: 5px;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.9rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 0.5rem;--%>
<%--        }--%>

<%--        .modal-action-btn.mark-read {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .modal-action-btn.mark-read:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .modal-action-btn.delete-all {--%>
<%--            background-color: #dc3545;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .modal-action-btn.delete-all:hover {--%>
<%--            background-color: #c82333;--%>
<%--        }--%>

<%--        .modal-action-btn:disabled {--%>
<%--            background-color: #6c757d;--%>
<%--            cursor: not-allowed;--%>
<%--        }--%>

<%--        /* Job Card Styles */--%>
<%--        .job-cards-section {--%>
<%--            margin-top: 3rem;--%>
<%--            margin-bottom: 3rem;--%>
<%--        }--%>

<%--        .job-card {--%>
<%--            background-color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);--%>
<%--        }--%>

<%--        .job-card h3 {--%>
<%--            margin: 0 0 1rem;--%>
<%--            color: #007bff;--%>
<%--            font-size: 1.4rem;--%>
<%--        }--%>

<%--        .job-card p {--%>
<%--            margin: 0.5rem 0;--%>
<%--            font-size: 0.95rem;--%>
<%--            color: #555;--%>
<%--        }--%>

<%--        .job-card p strong {--%>
<%--            color: #333;--%>
<%--        }--%>

<%--        .job-card .long-text {--%>
<%--            white-space: pre-wrap;--%>
<%--            word-break: break-word;--%>
<%--            max-height: 200px;--%>
<%--            overflow-y: auto;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--            padding: 0.5rem;--%>
<%--            border-radius: 5px;--%>
<%--            background-color: #f9fbfc;--%>
<%--        }--%>

<%--        /* Responsive Design */--%>
<%--        @media (max-width: 1024px) {--%>
<%--            .sidebar {--%>
<%--                width: 200px;--%>
<%--            }--%>

<%--            .main-content {--%>
<%--                margin-left: 200px;--%>
<%--                width: calc(100% - 200px);--%>
<%--                padding: 6rem 2rem 2rem 2rem;--%>
<%--            }--%>

<%--            .main-content.expanded {--%>
<%--                margin-left: 60px;--%>
<%--                width: calc(100% - 60px);--%>
<%--                padding-right: 2rem;--%>
<%--                padding-left: 2rem;--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 768px) {--%>
<%--            .container {--%>
<%--                flex-direction: column;--%>
<%--            }--%>

<%--            .navbar {--%>
<%--                flex-direction: row;--%>
<%--                padding: 1rem;--%>
<%--            }--%>

<%--            .sidebar {--%>
<%--                width: 100%;--%>
<%--                position: relative;--%>
<%--                top: 0;--%>
<%--                height: auto;--%>
<%--                padding: 1rem;--%>
<%--            }--%>

<%--            .sidebar.adjusted {--%>
<%--                top: 0;--%>
<%--                height: auto;--%>
<%--            }--%>

<%--            .sidebar.hidden {--%>
<%--                display: none;--%>
<%--            }--%>

<%--            .sidebar.collapsed {--%>
<%--                width: 100%;--%>
<%--            }--%>

<%--            .mobile-toggle-btn {--%>
<%--                display: block;--%>
<%--            }--%>

<%--            .main-content {--%>
<%--                margin-left: 0;--%>
<%--                padding: 6rem 2rem 2rem 2rem;--%>
<%--                width: 100%;--%>
<%--            }--%>

<%--            .main-content.collapsed {--%>
<%--                margin-left: 0;--%>
<%--                width: 100%;--%>
<%--                padding: 6rem 2rem 2rem 2rem;--%>
<%--            }--%>

<%--            table {--%>
<%--                font-size: 0.85rem;--%>
<%--            }--%>

<%--            th, td {--%>
<%--                padding: 0.75rem;--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 480px) {--%>
<%--            .navbar {--%>
<%--                flex-direction: row;--%>
<%--                align-items: center;--%>
<%--                padding: 0.5rem 1rem;--%>
<%--            }--%>

<%--            .navbar .profile-box img {--%>
<%--                width: 25px;--%>
<%--                height: 25px;--%>
<%--            }--%>

<%--            .navbar .profile-box .profile-info span {--%>
<%--                font-size: 0.75rem;--%>
<%--            }--%>

<%--            .header h1 {--%>
<%--                font-size: 1.5rem;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <!-- Navbar -->--%>
<%--    <nav class="navbar" id="navbar">--%>
<%--        <div class="logo">--%>
<%--            <img src="${pageContext.request.contextPath}/images/employer/1.jpg" alt="HireZa Logo">--%>
<%--            HireZa--%>
<%--        </div>--%>
<%--        <div class="right-section">--%>
<%--            <div class="notification-container">--%>
<%--                <button class="notification-bell" onclick="toggleNotifications()">--%>
<%--                    <i class="fas fa-bell"></i>--%>
<%--                    <% if (unreadCount > 0) { %>--%>
<%--                    <span class="notification-badge" id="notificationBadge"><%= unreadCount %></span>--%>
<%--                    <% } %>--%>
<%--                </button>--%>
<%--                <div class="notification-dropdown" id="notificationDropdown">--%>
<%--                    <div class="notification-header">--%>
<%--                        <h3>Notifications</h3>--%>
<%--                        <div class="notification-actions">--%>
<%--                            <% if (!notifications.isEmpty()) { %>--%>
<%--                            <button class="clear-btn" onclick="deleteAllNotifications()">--%>
<%--                                <i class="fas fa-trash"></i> Clear All--%>
<%--                            </button>--%>
<%--                            <% } %>--%>
<%--                            <% if (unreadCount > 0) { %>--%>
<%--                            <button class="mark-read-btn" onclick="markAllAsRead()">--%>
<%--                                <i class="fas fa-check-double"></i> Mark all read--%>
<%--                            </button>--%>
<%--                            <% } %>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="notification-list">--%>
<%--                        <% if (notifications.isEmpty()) { %>--%>
<%--                        <div class="no-notifications">No notifications</div>--%>
<%--                        <% } else {--%>
<%--                            for (int i = 0; i < Math.min(5, notifications.size()); i++) {--%>
<%--                                Notification notification = notifications.get(i);--%>
<%--                                String itemClass = "notification-item";--%>
<%--                                if (!notification.getIsRead()) itemClass += " unread";--%>
<%--                                itemClass += " " + notification.getType();--%>
<%--                        %>--%>
<%--                        <div class="<%= itemClass %>"--%>
<%--                             data-notification-id="<%= notification.getNotificationId() %>">--%>
<%--                            <div class="notification-content">--%>
<%--                                <div class="notification-message"><%= notification.getMessage() %></div>--%>
<%--                                <div class="notification-job-title"><strong>Job:</strong> <%= notification.getJobTitle() %></div>--%>
<%--                                <% if (notification.getAdminNotes() != null && !notification.getAdminNotes().trim().isEmpty()) { %>--%>
<%--                                <div class="notification-notes"><strong>Notes:</strong> <%= notification.getAdminNotes() %></div>--%>
<%--                                <% } %>--%>
<%--                                <div class="notification-time">--%>
<%--                                    <%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>--%>
<%--                                </div>--%>
<%--                                <% if (!notification.getIsRead()) { %>--%>
<%--                                <button class="notification-mark-read-btn"--%>
<%--                                        onclick="event.stopPropagation(); markAsRead('<%= notification.getNotificationId() %>', this)">--%>
<%--                                    <i class="fas fa-check"></i> Mark as Read--%>
<%--                                </button>--%>
<%--                                <% } %>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <% } } %>--%>
<%--                    </div>--%>
<%--                    <div class="notification-footer">--%>
<%--                        <a href="#" onclick="showAllNotificationsModal()">View All Notifications</a>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">--%>
<%--                <img src="<%= companyLogo %>" alt="Company Logo">--%>
<%--                <div class="profile-info">--%>
<%--                    <span><%= companyName %></span>--%>
<%--                </div>--%>
<%--                <div class="dropdown-content">--%>
<%--                    <a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp">Edit User Profile</a>--%>
<%--                    <a href="${pageContext.request.contextPath}/company/profile">Edit Company Profile</a>--%>
<%--                    <a href="#" onclick="showSignOutModal()">Sign Out</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </nav>--%>

<%--    <!-- Toggle Button for Sidebar (Mobile) -->--%>
<%--    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>--%>

<%--    <!-- Sidebar -->--%>
<%--    <nav class="sidebar" id="sidebar">--%>
<%--        <div class="header">--%>
<%--            <h2>Navigation</h2>--%>
<%--            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>--%>
<%--        </div>--%>
<%--        <ul>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>--%>
<%--            <li class="group-title">Jobs</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/jobs/post"><i class="fas fa-plus"></i> <span>Post New Job</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/jobs"><i class="fas fa-tasks"></i> <span>Manage Jobs</span></a></li>--%>
<%--            <li class="group-title">Team</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Employer/manage_recruiters.jsp"><i class="fas fa-users"></i> <span>Manage Recruiters</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity"><i class="fas fa-chart-line"></i> <span>Recruiter Activity</span></a></li>--%>
<%--            <li class="group-title">Profile</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/profile"><i class="fas fa-building"></i> <span>Company Profile</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp"><i class="fas fa-user-edit"></i> <span>Edit User Profile</span></a></li>--%>
<%--            <li class="group-title">Applications</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/employer/applications"><i class="fas fa-file-alt"></i> <span>Employer View Applications</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/dashboard/charts"><i class="fas fa-chart-bar"></i> <span>Dashboard Charts</span></a></li>--%>
<%--            <li class="sign-out">--%>
<%--                <a href="#" onclick="showSignOutModal()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </nav>--%>

<%--    <!-- Sign-out Modal -->--%>
<%--    <div id="signout-modal" class="signout-modal">--%>
<%--        <div class="signout-modal-content">--%>
<%--            <h2>Confirm Sign Out</h2>--%>
<%--            <p>Are you sure you want to sign out?</p>--%>
<%--            <button class="confirm-btn" onclick="signOut()">Yes, Sign Out</button>--%>
<%--            <button class="cancel-btn" onclick="closeSignOutModal()">Cancel</button>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Delete Confirmation Modal -->--%>
<%--    <div id="delete-modal" class="delete-modal">--%>
<%--        <div class="delete-modal-content">--%>
<%--            <h2>Confirm Delete Job Post</h2>--%>
<%--            <p id="delete-modal-text">Are you sure you want to delete this job post?</p>--%>
<%--            <input type="hidden" id="delete-job-id">--%>
<%--            <button class="confirm-btn" onclick="confirmDeleteAction()">Yes, Delete</button>--%>
<%--            <button class="cancel-btn" onclick="closeDeleteModal()">Cancel</button>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- All Notifications Modal -->--%>
<%--    <div id="all-notifications-modal" class="all-notifications-modal">--%>
<%--        <div class="all-notifications-modal-content">--%>
<%--            <span class="close" onclick="closeAllNotificationsModal()">&times;</span>--%>
<%--            <h2>All Notifications</h2>--%>

<%--            <div class="modal-actions">--%>
<%--                <% if (unreadCount > 0) { %>--%>
<%--                <button class="modal-action-btn mark-read" onclick="markAllAsReadInModal()">--%>
<%--                    <i class="fas fa-check-double"></i> Mark All as Read--%>
<%--                </button>--%>
<%--                <% } %>--%>
<%--                <% if (!notifications.isEmpty()) { %>--%>
<%--                <button class="modal-action-btn delete-all" onclick="deleteAllNotificationsInModal()">--%>
<%--                    <i class="fas fa-trash"></i> Delete All Notifications--%>
<%--                </button>--%>
<%--                <% } %>--%>
<%--            </div>--%>

<%--            <div class="notification-list" id="allNotificationsList">--%>
<%--                <% if (notifications.isEmpty()) { %>--%>
<%--                <div class="no-notifications">No notifications available</div>--%>
<%--                <% } else {--%>
<%--                    for (Notification notification : notifications) {--%>
<%--                        String itemClass = "notification-item";--%>
<%--                        if (!notification.getIsRead()) itemClass += " unread";--%>
<%--                        itemClass += " " + notification.getType();--%>
<%--                %>--%>
<%--                <div class="<%= itemClass %>"--%>
<%--                     data-notification-id="<%= notification.getNotificationId() %>"--%>
<%--                     onclick="showNotificationDetails('<%= notification.getNotificationId() %>')">--%>
<%--                    <div class="notification-content">--%>
<%--                        <div class="notification-message"><%= notification.getMessage() %></div>--%>
<%--                        <div class="notification-job-title"><strong>Job:</strong> <%= notification.getJobTitle() %></div>--%>
<%--                        <% if (notification.getAdminNotes() != null && !notification.getAdminNotes().trim().isEmpty()) { %>--%>
<%--                        <div class="notification-notes"><strong>Notes:</strong> <%= notification.getAdminNotes() %></div>--%>
<%--                        <% } %>--%>
<%--                        <div class="notification-time">--%>
<%--                            <%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>--%>
<%--                        </div>--%>
<%--                        <% if (!notification.getIsRead()) { %>--%>
<%--                        <button class="notification-mark-read-btn"--%>
<%--                                onclick="event.stopPropagation(); markAsReadInModal('<%= notification.getNotificationId() %>', this)">--%>
<%--                            <i class="fas fa-check"></i> Mark as Read--%>
<%--                        </button>--%>
<%--                        <% } %>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <% } } %>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Main Content -->--%>
<%--    <main class="main-content" id="mainContent">--%>
<%--        <div class="header">--%>
<%--            <h1>Manage Job Posts</h1>--%>
<%--        </div>--%>

<%--        <!-- Stats Box -->--%>
<%--        <div class="stats-box">--%>
<%--            <div class="stat-item">--%>
<%--                <div class="number"><%= expiredPosts.size() %></div>--%>
<%--                <div class="label">Expired Posts</div>--%>
<%--            </div>--%>
<%--            <div class="stat-item">--%>
<%--                <div class="number"><%= allPosts.size() - expiredPosts.size() %></div>--%>
<%--                <div class="label">Active Posts</div>--%>
<%--            </div>--%>
<%--            <div class="stat-item">--%>
<%--                <div class="number"><%= allPosts.size() %></div>--%>
<%--                <div class="label">Total Posts</div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <a href="${pageContext.request.contextPath}/company/jobs/post" class="btn post-job-btn" onclick="showNotification('Navigating to Post New Job')"><i class="fas fa-plus"></i> Post New Job</a>--%>
<%--        <a href="${pageContext.request.contextPath}/Employer/expired_jobs.jsp" class="btn" onclick="showNotification('Navigating to Expired Jobs')"><i class="fas fa-calendar-times"></i> View Expired Jobs</a>--%>

<%--        <%--%>
<%--            // Get active posts from servlet--%>
<%--            List<JobPost> activePosts = (List<JobPost>) request.getAttribute("activePosts");--%>
<%--            if (activePosts == null) {--%>
<%--                activePosts = (List<JobPost>) request.getAttribute("posts");--%>
<%--                if (activePosts == null) {--%>
<%--                    activePosts = new ArrayList<>();--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>

<%--        <!-- Active Jobs Table -->--%>
<%--        <div style="margin-bottom: 3rem;">--%>
<%--            <h2 style="color: #007bff; margin-bottom: 1rem; font-size: 1.4rem;">Active Job Posts</h2>--%>
<%--            <%--%>
<%--                if (activePosts == null || activePosts.isEmpty()) {--%>
<%--            %>--%>
<%--            <p class="no-posts">No active job posts found. Post a new one!</p>--%>
<%--            <% } else { %>--%>
<%--            <table>--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <th>Job ID</th>--%>
<%--                    <th>Job Title</th>--%>
<%--                    <th>Work Mode</th>--%>
<%--                    <th>Location</th>--%>
<%--                    <th>Employment Type</th>--%>
<%--                    <th>Status</th>--%>
<%--                    <th>Actions</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <% for (JobPost post : activePosts) { %>--%>
<%--                <tr>--%>
<%--                    <td><%= post.getJobId() %></td>--%>
<%--                    <td><%= post.getJobTitle() != null ? post.getJobTitle() : "N/A" %></td>--%>
<%--                    <td><%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></td>--%>
<%--                    <td><%= post.getLocation() != null ? post.getLocation() : "N/A" %></td>--%>
<%--                    <td><%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></td>--%>
<%--                    <td><%= post.getStatus() != null ? post.getStatus() : "N/A" %></td>--%>
<%--                    <td>--%>
<%--                        <a href="${pageContext.request.contextPath}/company/jobs/edit?id=<%= post.getJobId() %>" class="btn" onclick="showNotification('Navigating to Edit Job Post')"><i class="fas fa-edit"></i> Edit</a>--%>
<%--                        <a href="#" class="btn btn-danger" onclick="showDeleteModal('<%= post.getJobId() %>')"><i class="fas fa-trash"></i> Delete</a>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <% } %>--%>
<%--                </tbody>--%>
<%--            </table>--%>
<%--            <% } %>--%>
<%--        </div>--%>

<%--        <!-- All Job Posts Details in Cards (New Section) -->--%>
<%--        <div class="job-cards-section">--%>
<%--            <h2 style="color: #007bff; margin-bottom: 1rem; font-size: 1.4rem;">All Job Posts Details</h2>--%>
<%--            <% if (allPosts.isEmpty()) { %>--%>
<%--            <p class="no-posts">No job posts found for this company.</p>--%>
<%--            <% } else { %>--%>
<%--            <% for (JobPost post : allPosts) { %>--%>
<%--            <div class="job-card">--%>
<%--                <h3><%= post.getJobTitle() != null ? post.getJobTitle() : "N/A" %></h3>--%>
<%--                <p><strong>Job ID:</strong> <%= post.getJobId() != null ? post.getJobId() : "N/A" %></p>--%>
<%--                <p><strong>Company ID:</strong> <%= post.getCompanyId() != null ? post.getCompanyId() : "N/A" %></p>--%>
<%--                <p><strong>Company Name:</strong> <%= post.getCompanyName() != null ? post.getCompanyName() : "N/A" %></p>--%>
<%--                <p><strong>Work Mode:</strong> <%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></p>--%>
<%--                <p><strong>Location:</strong> <%= post.getLocation() != null ? post.getLocation() : "N/A" %></p>--%>
<%--                <p><strong>Employment Type:</strong> <%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></p>--%>
<%--                <p class="long-text"><strong>Job Description:</strong> <%= post.getJobDescription() != null ? post.getJobDescription() : "N/A" %></p>--%>
<%--                <p class="long-text"><strong>Required Skills:</strong> <%= post.getRequiredSkills() != null ? post.getRequiredSkills() : "N/A" %></p>--%>
<%--                <p><strong>Experience Level:</strong> <%= post.getExperienceLevel() != null ? post.getExperienceLevel() : "N/A" %></p>--%>
<%--                <p><strong>Application Deadline:</strong> <%= post.getApplicationDeadline() != null ? sdf.format(post.getApplicationDeadline()) : "N/A" %></p>--%>
<%--                <p><strong>Salary Range:</strong> <%= post.getSalaryRange() != null ? post.getSalaryRange() : "N/A" %></p>--%>
<%--                <p><strong>Working Hours/Shifts:</strong> <%= post.getWorkingHoursShifts() != null ? post.getWorkingHoursShifts() : "N/A" %></p>--%>
<%--                <p><strong>Status:</strong> <%= post.getStatus() != null ? post.getStatus() : "N/A" %></p>--%>
<%--                <p class="long-text"><strong>Admin Notes:</strong> <%= post.getAdminNotes() != null ? post.getAdminNotes() : "N/A" %></p>--%>
<%--                <p><strong>Created At:</strong> <%= post.getCreatedAt() != null ? sdf.format(post.getCreatedAt()) : "N/A" %></p>--%>
<%--                <p><strong>Updated At:</strong> <%= post.getUpdatedAt() != null ? sdf.format(post.getUpdatedAt()) : "N/A" %></p>--%>
<%--            </div>--%>
<%--            <% } %>--%>
<%--            <% } %>--%>
<%--        </div>--%>

<%--        <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn btn-secondary" onclick="showNotification('Returning to Dashboard')"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>--%>
<%--    </main>--%>
<%--</div>--%>

<%--<script>--%>
<%--    // Enhanced notification functions--%>
<%--    function toggleNotifications() {--%>
<%--        const dropdown = document.getElementById('notificationDropdown');--%>
<%--        const isShowing = dropdown.classList.contains('show');--%>

<%--        if (!isShowing) {--%>
<%--            refreshNotifications();--%>
<%--        }--%>

<%--        dropdown.classList.toggle('show');--%>

<%--        if (dropdown.classList.contains('show')) {--%>
<%--            document.addEventListener('click', closeNotificationsOnClickOutside);--%>
<%--        } else {--%>
<%--            document.removeEventListener('click', closeNotificationsOnClickOutside);--%>
<%--        }--%>
<%--    }--%>

<%--    function closeNotificationsOnClickOutside(event) {--%>
<%--        const dropdown = document.getElementById('notificationDropdown');--%>
<%--        const bell = document.querySelector('.notification-bell');--%>

<%--        if (!dropdown.contains(event.target) && !bell.contains(event.target)) {--%>
<%--            dropdown.classList.remove('show');--%>
<%--            document.removeEventListener('click', closeNotificationsOnClickOutside);--%>
<%--        }--%>
<%--    }--%>

<%--    function refreshNotifications() {--%>
<%--        console.log('Refreshing notifications...');--%>
<%--    }--%>

<%--    function markAsRead(notificationId, button) {--%>
<%--        markNotificationAsRead(notificationId, button, false);--%>
<%--    }--%>

<%--    function markAsReadInModal(notificationId, button) {--%>
<%--        markNotificationAsRead(notificationId, button, true);--%>
<%--    }--%>

<%--    function markNotificationAsRead(notificationId, button, isInModal = false) {--%>
<%--        console.log('Marking notification as read:', notificationId);--%>

<%--        // Update UI immediately--%>
<%--        const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);--%>
<%--        if (notificationElement) {--%>
<%--            notificationElement.classList.remove('unread');--%>
<%--            if (button) {--%>
<%--                button.style.display = 'none';--%>
<%--            }--%>
<%--        }--%>

<%--        // Update badge count--%>
<%--        updateNotificationBadge();--%>

<%--        // Send AJAX request--%>
<%--        fetch('${pageContext.request.contextPath}/company/mark-notification-read', {--%>
<%--            method: 'POST',--%>
<%--            body: new URLSearchParams({--%>
<%--                notificationId: notificationId--%>
<%--            }),--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/x-www-form-urlencoded',--%>
<%--            }--%>
<%--        })--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                if (data.success) {--%>
<%--                    console.log('Notification marked as read successfully');--%>
<%--                    if (!isInModal) {--%>
<%--                        showNotification('Notification marked as read', 'success');--%>
<%--                    }--%>
<%--                } else {--%>
<%--                    console.error('Failed to mark notification as read:', data.error);--%>
<%--                    // Revert UI changes--%>
<%--                    if (notificationElement) {--%>
<%--                        notificationElement.classList.add('unread');--%>
<%--                        if (button) {--%>
<%--                            button.style.display = 'block';--%>
<%--                        }--%>
<%--                    }--%>
<%--                    updateNotificationBadge();--%>
<%--                    showNotification('Failed to mark notification as read', 'error');--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error marking notification as read:', error);--%>
<%--                // Revert UI changes--%>
<%--                if (notificationElement) {--%>
<%--                    notificationElement.classList.add('unread');--%>
<%--                    if (button) {--%>
<%--                        button.style.display = 'block';--%>
<%--                    }--%>
<%--                }--%>
<%--                updateNotificationBadge();--%>
<%--                showNotification('Error marking notification as read', 'error');--%>
<%--            });--%>
<%--    }--%>

<%--    function markAllAsRead() {--%>
<%--        console.log('Marking ALL notifications as read');--%>

<%--        const unreadItems = document.querySelectorAll('.notification-item.unread');--%>
<%--        if (unreadItems.length === 0) {--%>
<%--            showNotification('All notifications are already marked as read', 'info');--%>
<%--            return;--%>
<%--        }--%>

<%--        showNotification('Marking all notifications as read...', 'info');--%>

<%--        // Update UI immediately--%>
<%--        unreadItems.forEach(item => {--%>
<%--            item.classList.remove('unread');--%>
<%--            const markReadBtn = item.querySelector('.notification-mark-read-btn');--%>
<%--            if (markReadBtn) {--%>
<%--                markReadBtn.style.display = 'none';--%>
<%--            }--%>
<%--        });--%>

<%--        // Update badge count immediately--%>
<%--        updateNotificationBadge();--%>

<%--        // Send AJAX request to mark all as read--%>
<%--        fetch('${pageContext.request.contextPath}/company/mark-all-notifications-read', {--%>
<%--            method: 'POST',--%>
<%--            body: new URLSearchParams({--%>
<%--                companyId: '<%= companyId %>'--%>
<%--            }),--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/x-www-form-urlencoded',--%>
<%--            }--%>
<%--        })--%>
<%--            .then(response => {--%>
<%--                if (!response.ok) {--%>
<%--                    throw new Error('Network response was not ok');--%>
<%--                }--%>
<%--                return response.json();--%>
<%--            })--%>
<%--            .then(data => {--%>
<%--                if (data.success) {--%>
<%--                    console.log('All notifications marked as read successfully');--%>
<%--                    forceClearNotificationBadge();--%>
<%--                    showNotification('All notifications marked as read successfully!', 'success');--%>

<%--                    setTimeout(() => {--%>
<%--                        document.getElementById('notificationDropdown').classList.remove('show');--%>
<%--                    }, 1000);--%>
<%--                } else {--%>
<%--                    console.error('Server returned error:', data.error);--%>
<%--                    showNotification('Failed to mark notifications as read: ' + (data.error || 'Unknown error'), 'error');--%>
<%--                    unreadItems.forEach(item => {--%>
<%--                        item.classList.add('unread');--%>
<%--                    });--%>
<%--                    updateNotificationBadge();--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error marking all notifications as read:', error);--%>
<%--                showNotification('Error marking notifications as read. Please try again.', 'error');--%>
<%--                unreadItems.forEach(item => {--%>
<%--                    item.classList.add('unread');--%>
<%--                });--%>
<%--                updateNotificationBadge();--%>
<%--            });--%>
<%--    }--%>

<%--    function markAllAsReadInModal() {--%>
<%--        markAllAsRead();--%>
<%--        // Don't close modal immediately, let user see the changes--%>
<%--        setTimeout(() => {--%>
<%--            closeAllNotificationsModal();--%>
<%--        }, 1500);--%>
<%--    }--%>

<%--    function deleteAllNotifications() {--%>
<%--        if (!confirm('Are you sure you want to delete all notifications? This action cannot be undone.')) {--%>
<%--            return;--%>
<%--        }--%>

<%--        showNotification('Deleting all notifications...', 'info');--%>

<%--        fetch('${pageContext.request.contextPath}/company/delete-all-notifications', {--%>
<%--            method: 'POST',--%>
<%--            body: new URLSearchParams({--%>
<%--                companyId: '<%= companyId %>'--%>
<%--            }),--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/x-www-form-urlencoded',--%>
<%--            }--%>
<%--        })--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                if (data.success) {--%>
<%--                    const notificationList = document.querySelector('.notification-list');--%>
<%--                    notificationList.innerHTML = '<div class="no-notifications">No notifications</div>';--%>

<%--                    const badge = document.getElementById('notificationBadge');--%>
<%--                    if (badge) {--%>
<%--                        badge.remove();--%>
<%--                    }--%>

<%--                    const clearBtn = document.querySelector('.clear-btn');--%>
<%--                    if (clearBtn) {--%>
<%--                        clearBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    const markReadBtn = document.querySelector('.mark-read-btn');--%>
<%--                    if (markReadBtn) {--%>
<%--                        markReadBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    document.getElementById('notificationDropdown').classList.remove('show');--%>
<%--                    showNotification('All notifications deleted successfully', 'success');--%>
<%--                } else {--%>
<%--                    console.error('Failed to delete all notifications:', data.error);--%>
<%--                    showNotification('Failed to delete notifications: ' + data.error, 'error');--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error deleting all notifications:', error);--%>
<%--                showNotification('Error deleting notifications', 'error');--%>
<%--            });--%>
<%--    }--%>

<%--    function deleteAllNotificationsInModal() {--%>
<%--        if (!confirm('Are you sure you want to delete ALL notifications? This action cannot be undone and will remove all notification history.')) {--%>
<%--            return;--%>
<%--        }--%>

<%--        showNotification('Deleting all notifications...', 'info');--%>

<%--        fetch('${pageContext.request.contextPath}/company/delete-all-notifications', {--%>
<%--            method: 'POST',--%>
<%--            body: new URLSearchParams({--%>
<%--                companyId: '<%= companyId %>'--%>
<%--            }),--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/x-www-form-urlencoded',--%>
<%--            }--%>
<%--        })--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                if (data.success) {--%>
<%--                    const notificationList = document.getElementById('allNotificationsList');--%>
<%--                    notificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';--%>

<%--                    const badge = document.getElementById('notificationBadge');--%>
<%--                    if (badge) {--%>
<%--                        badge.remove();--%>
<%--                    }--%>

<%--                    // Update dropdown notifications--%>
<%--                    const dropdownList = document.querySelector('.notification-dropdown .notification-list');--%>
<%--                    if (dropdownList) {--%>
<%--                        dropdownList.innerHTML = '<div class="no-notifications">No notifications</div>';--%>
<%--                    }--%>

<%--                    showNotification('All notifications deleted successfully', 'success');--%>

<%--                    setTimeout(() => {--%>
<%--                        closeAllNotificationsModal();--%>
<%--                    }, 1500);--%>
<%--                } else {--%>
<%--                    console.error('Failed to delete all notifications:', data.error);--%>
<%--                    showNotification('Failed to delete notifications: ' + data.error, 'error');--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error deleting all notifications:', error);--%>
<%--                showNotification('Error deleting notifications', 'error');--%>
<%--            });--%>
<%--    }--%>

<%--    function updateNotificationBadge() {--%>
<%--        const badge = document.getElementById('notificationBadge');--%>
<%--        const unreadItems = document.querySelectorAll('.notification-item.unread');--%>
<%--        const unreadCount = unreadItems.length;--%>

<%--        console.log('Updating badge, unread count:', unreadCount);--%>

<%--        if (unreadCount > 0) {--%>
<%--            if (badge) {--%>
<%--                badge.textContent = unreadCount;--%>
<%--            } else {--%>
<%--                createNotificationBadge(unreadCount);--%>
<%--            }--%>
<%--        } else {--%>
<%--            if (badge) {--%>
<%--                badge.remove();--%>
<%--            }--%>
<%--        }--%>

<%--        updateMarkReadButtonVisibility();--%>
<%--        refreshNotificationCount();--%>
<%--    }--%>

<%--    function forceClearNotificationBadge() {--%>
<%--        const badge = document.getElementById('notificationBadge');--%>
<%--        if (badge) {--%>
<%--            badge.remove();--%>
<%--        }--%>
<%--        updateMarkReadButtonVisibility();--%>
<%--    }--%>

<%--    function updateMarkReadButtonVisibility() {--%>
<%--        const unreadItems = document.querySelectorAll('.notification-item.unread');--%>
<%--        const markReadBtn = document.querySelector('.mark-read-btn');--%>

<%--        if (markReadBtn) {--%>
<%--            if (unreadItems.length === 0) {--%>
<%--                markReadBtn.style.display = 'none';--%>
<%--            } else {--%>
<%--                markReadBtn.style.display = 'block';--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    function refreshNotificationCount() {--%>
<%--        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                console.log('Server unread count:', data.unreadCount);--%>
<%--                const badge = document.getElementById('notificationBadge');--%>
<%--                const clientUnreadCount = document.querySelectorAll('.notification-item.unread').length;--%>

<%--                if (data.unreadCount !== clientUnreadCount) {--%>
<%--                    if (data.unreadCount > 0) {--%>
<%--                        if (badge) {--%>
<%--                            badge.textContent = data.unreadCount;--%>
<%--                        } else {--%>
<%--                            createNotificationBadge(data.unreadCount);--%>
<%--                        }--%>
<%--                    } else {--%>
<%--                        if (badge) {--%>
<%--                            badge.remove();--%>
<%--                        }--%>
<%--                    }--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => console.error('Error refreshing notification count:', error));--%>
<%--    }--%>

<%--    function createNotificationBadge(count) {--%>
<%--        const bell = document.querySelector('.notification-bell');--%>
<%--        const badge = document.createElement('span');--%>
<%--        badge.className = 'notification-badge';--%>
<%--        badge.id = 'notificationBadge';--%>
<%--        badge.textContent = count;--%>
<%--        bell.appendChild(badge);--%>
<%--    }--%>

<%--    function checkNewNotifications() {--%>
<%--        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--                if (data.unreadCount > 0) {--%>
<%--                    const currentBadge = document.getElementById('notificationBadge');--%>
<%--                    if (currentBadge) {--%>
<%--                        const currentCount = parseInt(currentBadge.textContent);--%>
<%--                        if (data.unreadCount > currentCount) {--%>
<%--                            currentBadge.textContent = data.unreadCount;--%>
<%--                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');--%>
<%--                        }--%>
<%--                    } else {--%>
<%--                        createNotificationBadge(data.unreadCount);--%>
<%--                        if (data.unreadCount > 0) {--%>
<%--                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');--%>
<%--                        }--%>
<%--                    }--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => console.error('Error checking notifications:', error));--%>
<%--    }--%>

<%--    // Show All Notifications Modal--%>
<%--    function showAllNotificationsModal() {--%>
<%--        const modal = document.getElementById('all-notifications-modal');--%>
<%--        modal.style.display = 'block';--%>
<%--        document.getElementById('notificationDropdown').classList.remove('show');--%>
<%--        showNotification('Opening all notifications');--%>
<%--    }--%>

<%--    // Close All Notifications Modal--%>
<%--    function closeAllNotificationsModal() {--%>
<%--        document.getElementById('all-notifications-modal').style.display = 'none';--%>
<%--        showNotification('Closed notifications view');--%>
<%--    }--%>

<%--    // Show notification details--%>
<%--    function showNotificationDetails(notificationId) {--%>
<%--        console.log('Showing details for notification:', notificationId);--%>
<%--        const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);--%>
<%--        if (notificationElement && notificationElement.classList.contains('unread')) {--%>
<%--            markAsReadInModal(notificationId, notificationElement.querySelector('.notification-mark-read-btn'));--%>
<%--        }--%>
<%--    }--%>

<%--    // Close modal when clicking outside--%>
<%--    window.addEventListener('click', function(event) {--%>
<%--        const modal = document.getElementById('all-notifications-modal');--%>
<%--        if (event.target === modal) {--%>
<%--            closeAllNotificationsModal();--%>
<%--        }--%>
<%--    });--%>

<%--    // Notification Function--%>
<%--    function showNotification(message, type = 'info') {--%>
<%--        const toast = document.createElement('div');--%>
<%--        toast.className = 'toast-notification' + (type !== 'info' ? ' ' + type : '');--%>
<%--        toast.textContent = message;--%>
<%--        document.body.appendChild(toast);--%>

<%--        setTimeout(() => {--%>
<%--            toast.remove();--%>
<%--        }, 3000);--%>

<%--        if ('Notification' in window && Notification.permission === 'granted') {--%>
<%--            new Notification('HireZa Dashboard', { body: message });--%>
<%--        } else if ('Notification' in window && Notification.permission === 'default') {--%>
<%--            Notification.requestPermission().then(permission => {--%>
<%--                if (permission === 'granted') {--%>
<%--                    new Notification('HireZa Dashboard', { body: message });--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    }--%>

<%--    // Sign-out Modal Functions--%>
<%--    function showSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'block';--%>
<%--        showNotification('Sign out confirmation prompted');--%>
<%--    }--%>

<%--    function closeSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'none';--%>
<%--        showNotification('Sign out cancelled');--%>
<%--    }--%>

<%--    // Delete Modal Functions--%>
<%--    function showDeleteModal(jobId) {--%>
<%--        document.getElementById('delete-modal').style.display = 'block';--%>
<%--        document.getElementById('delete-job-id').value = jobId;--%>
<%--        const modalText = document.getElementById('delete-modal-text');--%>
<%--        modalText.textContent = 'Are you sure you want to delete this job post?';--%>
<%--        showNotification('Delete confirmation prompted for Job ID: ' + jobId);--%>
<%--    }--%>

<%--    function closeDeleteModal() {--%>
<%--        document.getElementById('delete-modal').style.display = 'none';--%>
<%--        showNotification('Delete cancelled');--%>
<%--    }--%>

<%--    function confirmDeleteAction() {--%>
<%--        const jobId = document.getElementById('delete-job-id').value;--%>
<%--        showNotification('Deleting job post ID: ' + jobId);--%>
<%--        window.location.href = '${pageContext.request.contextPath}/company/jobs/delete?id=' + jobId;--%>
<%--    }--%>

<%--    function toggleSidebar() {--%>
<%--        const sidebar = document.getElementById('sidebar');--%>
<%--        const mainContent = document.getElementById('mainContent');--%>
<%--        sidebar.classList.toggle('hidden');--%>
<%--        mainContent.classList.toggle('collapsed');--%>
<%--        showNotification(sidebar.classList.contains('hidden') ? 'Sidebar hidden' : 'Sidebar shown');--%>
<%--    }--%>

<%--    function toggleSidebarCollapse() {--%>
<%--        const sidebar = document.getElementById('sidebar');--%>
<%--        const mainContent = document.getElementById('mainContent');--%>
<%--        const toggleIcon = document.querySelector('.toggle-icon');--%>
<%--        sidebar.classList.toggle('collapsed');--%>
<%--        mainContent.classList.toggle('expanded');--%>
<%--        toggleIcon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';--%>
<%--        showNotification(sidebar.classList.contains('collapsed') ? 'Sidebar collapsed' : 'Sidebar expanded');--%>
<%--    }--%>

<%--    function signOut() {--%>
<%--        showNotification('Signing out...');--%>
<%--        setTimeout(() => {--%>
<%--            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';--%>
<%--        }, 500);--%>
<%--    }--%>

<%--    // Navbar and Sidebar scroll behavior--%>
<%--    let lastScrollTop = 0;--%>
<%--    const navbar = document.getElementById('navbar');--%>
<%--    const sidebar = document.getElementById('sidebar');--%>
<%--    const navbarHeight = navbar.offsetHeight;--%>

<%--    window.addEventListener('scroll', () => {--%>
<%--        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;--%>

<%--        if (scrollTop > lastScrollTop && scrollTop > navbarHeight) {--%>
<%--            navbar.classList.add('hidden');--%>
<%--            sidebar.classList.add('adjusted');--%>
<%--        } else if (scrollTop < lastScrollTop) {--%>
<%--            navbar.classList.remove('hidden');--%>
<%--            sidebar.classList.remove('adjusted');--%>
<%--        }--%>

<%--        lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;--%>
<%--    });--%>

<%--    // Ensure sidebar adjusts on resize--%>
<%--    window.addEventListener('resize', () => {--%>
<%--        const sidebar = document.getElementById('sidebar');--%>
<%--        if (sidebar.classList.contains('adjusted')) {--%>
<%--            sidebar.style.top = '0';--%>
<%--            sidebar.style.height = '100vh';--%>
<%--        } else {--%>
<%--            sidebar.style.top = '60px';--%>
<%--            sidebar.style.height = `calc(100vh - ${navbarHeight}px)`;--%>
<%--        }--%>
<%--    });--%>

<%--    // Request notification permission on page load--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        if ('Notification' in window && Notification.permission === 'default') {--%>
<%--            Notification.requestPermission();--%>
<%--        }--%>

<%--        // Check for new notifications every 30 seconds--%>
<%--        setInterval(() => {--%>
<%--            checkNewNotifications();--%>
<%--        }, 30000);--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company, model.JobPost, java.util.List, java.text.SimpleDateFormat" %>
<%@ page import="controller.DeadlineCheckServlet.DeadlineInfo" %>
<%@ page import="dao.NotificationDAO, model.Notification" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.DeadlineCheckServlet" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="dao.JobPostDAO" %>
<%
    User employer = (User) session.getAttribute("user");
    if (employer == null || !"Employer".equals(employer.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(employer.getId());
    String companyId = (company != null) ? company.getCompanyId() : "0";
    session.setAttribute("companyId", companyId);
    String companyLogo = (company != null && company.getLogo() != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/150?text=Logo";
    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";

    // Fetch notifications and unread count
    NotificationDAO notifDAO = new NotificationDAO();
    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);
    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);

    // Get all job posts for stats
    JobPostDAO jobPostDAO = new JobPostDAO();
    List<JobPost> allPosts = jobPostDAO.getAllJobPostsByCompanyId(companyId);
    List<JobPost> expiredPosts = new ArrayList<>();
    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    for (JobPost post : allPosts) {
        Date deadline = post.getApplicationDeadline();
        if (deadline != null && deadline.compareTo(today) <= 0) {
            expiredPosts.add(post);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Job Posts - Job Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/jpeg" href="${pageContext.request.contextPath}/images/employer/2.jpg">
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

        .navbar .right-section {
            display: flex;
            align-items: center;
            gap: 1rem;
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

        /* Notification Styles */
        .notification-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .notification-bell {
            position: relative;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #007bff;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: background-color 0.3s;
        }

        .notification-bell:hover {
            background-color: #f8f9fa;
        }

        .notification-badge {
            position: absolute;
            top: 0;
            right: 0;
            background-color: #dc3545;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
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
            width: 400px;
            max-height: 500px;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            overflow: hidden;
            flex-direction: column;
        }

        .notification-list {
            max-height: 350px;
            overflow-y: auto;
            overflow-x: hidden;
            flex: 1;
            min-height: 0;
        }

        .notification-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .clear-btn, .mark-read-btn {
            background: none;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.75rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            white-space: nowrap;
        }

        .clear-btn {
            background-color: #dc3545;
            color: white;
            border: 1px solid #dc3545;
        }

        .clear-btn:hover {
            background-color: #c82333;
            border-color: #bd2130;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
        }

        .mark-read-btn {
            background-color: #28a745;
            color: white;
            border: 1px solid #28a745;
        }

        .mark-read-btn:hover {
            background-color: #218838;
            border-color: #1e7e34;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3);
        }

        .clear-btn:disabled, .mark-read-btn:disabled {
            background-color: #6c757d;
            border-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
            transform: none;
            box-shadow: none;
        }

        .notification-mark-read-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.3rem 0.6rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.75rem;
            margin-top: 0.5rem;
            transition: background-color 0.3s;
        }

        .notification-mark-read-btn:hover {
            background-color: #0056b3;
        }

        .notification-mark-read-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .notification-dropdown.show {
            display: flex;
        }

        .notification-header {
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
            background-color: white;
        }

        .notification-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.1rem;
        }

        .notification-item {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .notification-item:hover {
            background-color: #f8f9fa;
        }

        .notification-item.unread {
            background-color: #f0f7ff;
            border-left: 3px solid #007bff;
        }

        .notification-item.approved {
            border-left: 3px solid #28a745;
        }

        .notification-item.rejected {
            border-left: 3px solid #dc3545;
        }

        .notification-item.pending {
            border-left: 3px solid #ffc107;
        }

        .notification-item.info {
            border-left: 3px solid #17a2b8;
        }

        .notification-content {
            display: flex;
            flex-direction: column;
        }

        .notification-message {
            font-weight: 500;
            margin-bottom: 0.25rem;
            color: #333;
        }

        .notification-job-title {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.25rem;
        }

        .notification-notes {
            font-size: 0.85rem;
            color: #888;
            font-style: italic;
            margin-bottom: 0.25rem;
        }

        .notification-time {
            font-size: 0.8rem;
            color: #999;
        }

        .notification-footer {
            padding: 1rem;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            flex-shrink: 0;
            background-color: white;
        }

        .notification-footer a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .notification-footer a:hover {
            text-decoration: underline;
        }

        .no-notifications {
            padding: 2rem 1rem;
            text-align: center;
            color: #999;
            font-style: italic;
        }

        /* Sidebar Styles */
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
        }

        .mobile-toggle-btn:hover {
            background-color: #0056b3;
        }

        /* Main Content Styles */
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

        .post-job-btn {
            margin-bottom: 2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .stat-card h4 {
            margin: 0 0 0.5rem;
            font-size: 1rem;
        }

        .stat-card p {
            font-size: 1.5rem;
            font-weight: bold;
            margin: 0;
        }

        .search-box {
            margin-bottom: 2rem;
        }

        .search-box input {
            width: 100%;
            max-width: 400px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            font-size: 0.95rem;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #f9fbfc;
            font-weight: bold;
            color: #333;
            font-size: 0.95rem;
        }

        td {
            font-size: 0.9rem;
            color: #555;
        }

        tr:hover {
            background-color: #f4f7fa;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 0.5rem 1rem;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
            display: inline-block;
            margin-right: 0.5rem;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-secondary {
            background-color: #6c757d;
            margin-top: 1.5rem;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .no-posts {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
            font-size: 1rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        /* Toast Notification */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #007bff;
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            z-index: 10000;
            font-size: 14px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.3s ease, fadeOut 0.3s ease 2.7s forwards;
        }

        .toast-notification.error {
            background: #dc3545;
        }

        .toast-notification.success {
            background: #28a745;
        }

        .toast-notification.info {
            background: #17a2b8;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }

        /* Sign-out Popup */
        .signout-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .signout-modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border-radius: 5px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .signout-modal-content h2 {
            font-size: 1.4rem;
            margin: 0 0 1rem;
            color: #333;
        }

        .signout-modal-content p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1.5rem;
        }

        .signout-modal-content button {
            padding: 0.5rem 1.5rem;
            margin: 0 0.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .signout-modal-content .confirm-btn {
            background-color: #007bff;
            color: white;
        }

        .signout-modal-content .confirm-btn:hover {
            background-color: #0056b3;
        }

        .signout-modal-content .cancel-btn {
            background-color: #6c757d;
            color: white;
        }

        .signout-modal-content .cancel-btn:hover {
            background-color: #545b62;
        }

        /* Delete Confirmation Modal */
        .delete-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .delete-modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border-radius: 5px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .delete-modal-content h2 {
            font-size: 1.4rem;
            margin: 0 0 1rem;
            color: #333;
        }

        .delete-modal-content p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1.5rem;
        }

        .delete-modal-content button {
            padding: 0.5rem 1.5rem;
            margin: 0 0.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .delete-modal-content .confirm-btn {
            background-color: #dc3545;
            color: white;
        }

        .delete-modal-content .confirm-btn:hover {
            background-color: #c82333;
        }

        .delete-modal-content .cancel-btn {
            background-color: #6c757d;
            color: white;
        }

        .delete-modal-content .cancel-btn:hover {
            background-color: #545b62;
        }

        /* All Notifications Modal */
        .all-notifications-modal {
            display: none;
            position: fixed;
            z-index: 1100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            overflow: auto;
        }

        .all-notifications-modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 700px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 1.5rem;
            cursor: pointer;
            color: #aaa;
        }

        .close:hover {
            color: #000;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .modal-action-btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-action-btn.mark-read {
            background-color: #007bff;
            color: white;
        }

        .modal-action-btn.mark-read:hover {
            background-color: #0056b3;
        }

        .modal-action-btn.delete-all {
            background-color: #dc3545;
            color: white;
        }

        .modal-action-btn.delete-all:hover {
            background-color: #c82333;
        }

        .modal-action-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }

        /* Job Card Styles */
        .job-cards-section {
            margin-top: 3rem;
            margin-bottom: 3rem;
            transition: max-height 0.3s ease, opacity 0.3s ease;
            overflow: hidden;
        }

        .job-cards-section.hidden {
            max-height: 0;
            opacity: 0;
            margin-top: 0;
            margin-bottom: 0;
        }

        .job-card {
            background-color: white;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .job-card h3 {
            margin: 0 0 1rem;
            color: #007bff;
            font-size: 1.4rem;
        }

        .job-card p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
            color: #555;
        }

        .job-card p strong {
            color: #333;
        }

        .job-card .long-text {
            white-space: pre-wrap;
            word-break: break-word;
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #e0e0e0;
            padding: 0.5rem;
            border-radius: 5px;
            background-color: #f9fbfc;
        }

        /* Toggle Button for Job Cards Section */
        .toggle-job-details-btn {
            background-color: #007bff;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            transition: background-color 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .toggle-job-details-btn:hover {
            background-color: #0056b3;
        }

        /* Responsive Design */
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

            .stats-grid {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.85rem;
            }

            th, td {
                padding: 0.75rem;
            }

            .search-box input {
                max-width: 100%;
            }
        }

        @media (max-width: 480px) {
            .navbar {
                flex-direction: row;
                align-items: center;
                padding: 0.5rem 1rem;
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

            .stat-card h4 {
                font-size: 0.9rem;
            }

            .stat-card p {
                font-size: 1.2rem;
            }
        }

        /* Active sidebar menu item styling */
        .sidebar a.active {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
            border-left: 4px solid #ffffff;
        }

        .sidebar a.active i {
            color: white;
        }

        .sidebar a.active:hover {
            background-color: #0056b3;
            color: white;
        }

        /* Specific styling for Dashboard when active */
        .sidebar li:first-child a.active {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border-left: 4px solid #ffd700; /* Gold accent for dashboard */
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
                            <% if (!notifications.isEmpty()) { %>
                            <button class="clear-btn" onclick="deleteAllNotifications()">
                                <i class="fas fa-trash"></i> Clear All
                            </button>
                            <% } %>
                            <% if (unreadCount > 0) { %>
                            <button class="mark-read-btn" onclick="markAllAsRead()">
                                <i class="fas fa-check-double"></i> Mark all read
                            </button>
                            <% } %>
                        </div>
                    </div>
                    <div class="notification-list">
                        <% if (notifications.isEmpty()) { %>
                        <div class="no-notifications">No notifications</div>
                        <% } else {
                            for (int i = 0; i < Math.min(5, notifications.size()); i++) {
                                Notification notification = notifications.get(i);
                                String itemClass = "notification-item";
                                if (!notification.getIsRead()) itemClass += " unread";
                                itemClass += " " + notification.getType();
                        %>
                        <div class="<%= itemClass %>"
                             data-notification-id="<%= notification.getNotificationId() %>">
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
                                        onclick="event.stopPropagation(); markAsRead('<%= notification.getNotificationId() %>', this)">
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

<%--            <li><a href="${pageContext.request.contextPath}/company/jobs class="active"><i class="fas fa-tachometer-alt"></i> <span>Manage Jobs</span></a></li>--%>

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

    <!-- Sign-out Modal -->
    <div id="signout-modal" class="signout-modal">
        <div class="signout-modal-content">
            <h2>Confirm Sign Out</h2>
            <p>Are you sure you want to sign out?</p>
            <button class="confirm-btn" onclick="signOut()">Yes, Sign Out</button>
            <button class="cancel-btn" onclick="closeSignOutModal()">Cancel</button>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="delete-modal" class="delete-modal">
        <div class="delete-modal-content">
            <h2>Confirm Delete Job Post</h2>
            <p id="delete-modal-text">Are you sure you want to delete this job post?</p>
            <input type="hidden" id="delete-job-id">
            <button class="confirm-btn" onclick="confirmDeleteAction()">Yes, Delete</button>
            <button class="cancel-btn" onclick="closeDeleteModal()">Cancel</button>
        </div>
    </div>

    <!-- All Notifications Modal -->
    <div id="all-notifications-modal" class="all-notifications-modal">
        <div class="all-notifications-modal-content">
            <span class="close" onclick="closeAllNotificationsModal()">&times;</span>
            <h2>All Notifications</h2>

            <div class="modal-actions">
                <% if (unreadCount > 0) { %>
                <button class="modal-action-btn mark-read" onclick="markAllAsReadInModal()">
                    <i class="fas fa-check-double"></i> Mark All as Read
                </button>
                <% } %>
                <% if (!notifications.isEmpty()) { %>
                <button class="modal-action-btn delete-all" onclick="deleteAllNotificationsInModal()">
                    <i class="fas fa-trash"></i> Delete All Notifications
                </button>
                <% } %>
            </div>

            <div class="notification-list" id="allNotificationsList">
                <% if (notifications.isEmpty()) { %>
                <div class="no-notifications">No notifications available</div>
                <% } else {
                    for (Notification notification : notifications) {
                        String itemClass = "notification-item";
                        if (!notification.getIsRead()) itemClass += " unread";
                        itemClass += " " + notification.getType();
                %>
                <div class="<%= itemClass %>"
                     data-notification-id="<%= notification.getNotificationId() %>"
                     onclick="showNotificationDetails('<%= notification.getNotificationId() %>')">
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
                                onclick="event.stopPropagation(); markAsReadInModal('<%= notification.getNotificationId() %>', this)">
                            <i class="fas fa-check"></i> Mark as Read
                        </button>
                        <% } %>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="header">
            <h1>Manage Job Posts</h1>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h4>Expired Posts</h4>
                <p><%= expiredPosts.size() %></p>
            </div>
            <div class="stat-card">
                <h4>Active Posts</h4>
                <p><%= allPosts.size() - expiredPosts.size() %></p>
            </div>
            <div class="stat-card">
                <h4>Total Posts</h4>
                <p><%= allPosts.size() %></p>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/company/jobs/post" class="btn post-job-btn" onclick="showNotification('Navigating to Post New Job')"><i class="fas fa-plus"></i> Post New Job</a>
        <a href="${pageContext.request.contextPath}/Employer/expired_jobs.jsp" class="btn" onclick="showNotification('Navigating to Expired Jobs')"><i class="fas fa-calendar-times"></i> View Expired Jobs</a>

        <%
            // Get active posts from servlet
            List<JobPost> activePosts = (List<JobPost>) request.getAttribute("activePosts");
            if (activePosts == null) {
                activePosts = (List<JobPost>) request.getAttribute("posts");
                if (activePosts == null) {
                    activePosts = new ArrayList<>();
                }
            }
        %>

        <!-- Active Jobs Table -->
        <div style="margin-bottom: 3rem;">
            <h2 style="color: #007bff; margin-bottom: 1rem; font-size: 1.4rem;">Active Job Posts</h2>
            <div class="search-box">
                <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search by job title, work mode, or location...">
            </div>
            <%
                if (activePosts == null || activePosts.isEmpty()) {
            %>
            <p class="no-posts">No active job posts found. Post a new one!</p>
            <% } else { %>
            <table id="jobTable">
                <thead>
                <tr>
                    <th>Job ID</th>
                    <th>Job Title</th>
                    <th>Work Mode</th>
                    <th>Location</th>
                    <th>Employment Type</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (JobPost post : activePosts) { %>
                <tr>
                    <td><%= post.getJobId() %></td>
                    <td><%= post.getJobTitle() != null ? post.getJobTitle() : "N/A" %></td>
                    <td><%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></td>
                    <td><%= post.getLocation() != null ? post.getLocation() : "N/A" %></td>
                    <td><%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></td>
                    <td><%= post.getStatus() != null ? post.getStatus() : "N/A" %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/company/jobs/edit?id=<%= post.getJobId() %>" class="btn" onclick="showNotification('Navigating to Edit Job Post')"><i class="fas fa-edit"></i> Edit</a>
                        <a href="#" class="btn btn-danger" onclick="showDeleteModal('<%= post.getJobId() %>')"><i class="fas fa-trash"></i> Delete</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
        </div>

        <!-- All Job Posts Details in Cards -->
        <button class="toggle-job-details-btn" onclick="toggleJobDetails()">
            <i class="fas fa-eye"></i> <span id="toggleJobDetailsText">Hide Job Details</span>
        </button>
        <div class="job-cards-section" id="jobCardsSection">
            <h2 style="color: #007bff; margin-bottom: 1rem; font-size: 1.4rem;">All Job Posts Details</h2>
            <% if (allPosts.isEmpty()) { %>
            <p class="no-posts">No job posts found for this company.</p>
            <% } else { %>
            <% for (JobPost post : allPosts) { %>
            <div class="job-card">
                <h3><%= post.getJobTitle() != null ? post.getJobTitle() : "N/A" %></h3>
                <p><strong>Job ID:</strong> <%= post.getJobId() != null ? post.getJobId() : "N/A" %></p>
                <p><strong>Company ID:</strong> <%= post.getCompanyId() != null ? post.getCompanyId() : "N/A" %></p>
                <p><strong>Company Name:</strong> <%= post.getCompanyName() != null ? post.getCompanyName() : "N/A" %></p>
                <p><strong>Work Mode:</strong> <%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></p>
                <p><strong>Location:</strong> <%= post.getLocation() != null ? post.getLocation() : "N/A" %></p>
                <p><strong>Employment Type:</strong> <%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></p>
                <p class="long-text"><strong>Job Description:</strong> <%= post.getJobDescription() != null ? post.getJobDescription() : "N/A" %></p>
                <p class="long-text"><strong>Required Skills:</strong> <%= post.getRequiredSkills() != null ? post.getRequiredSkills() : "N/A" %></p>
                <p><strong>Experience Level:</strong> <%= post.getExperienceLevel() != null ? post.getExperienceLevel() : "N/A" %></p>
                <p><strong>Application Deadline:</strong> <%= post.getApplicationDeadline() != null ? sdf.format(post.getApplicationDeadline()) : "N/A" %></p>
                <p><strong>Salary Range:</strong> <%= post.getSalaryRange() != null ? post.getSalaryRange() : "N/A" %></p>
                <p><strong>Working Hours/Shifts:</strong> <%= post.getWorkingHoursShifts() != null ? post.getWorkingHoursShifts() : "N/A" %></p>
                <p><strong>Status:</strong> <%= post.getStatus() != null ? post.getStatus() : "N/A" %></p>
                <p class="long-text"><strong>Admin Notes:</strong> <%= post.getAdminNotes() != null ? post.getAdminNotes() : "N/A" %></p>
                <p><strong>Created At:</strong> <%= post.getCreatedAt() != null ? sdf.format(post.getCreatedAt()) : "N/A" %></p>
                <p><strong>Updated At:</strong> <%= post.getUpdatedAt() != null ? sdf.format(post.getUpdatedAt()) : "N/A" %></p>
            </div>
            <% } %>
            <% } %>
        </div>

        <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn btn-secondary" onclick="showNotification('Returning to Dashboard')"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </main>
</div>

<script>
    // Toggle Job Details Section
    function toggleJobDetails() {
        const section = document.getElementById('jobCardsSection');
        const toggleText = document.getElementById('toggleJobDetailsText');
        const isHidden = section.classList.contains('hidden');

        if (isHidden) {
            section.classList.remove('hidden');
            toggleText.textContent = 'Hide Job Details';
            showNotification('Job details section shown', 'info');
        } else {
            section.classList.add('hidden');
            toggleText.textContent = 'Show Job Details';
            showNotification('Job details section hidden', 'info');
        }
    }

    // Filter Table Function
    function filterTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.getElementById('jobTable');
        if (table) {
            const tr = table.getElementsByTagName('tr');
            for (let i = 1; i < tr.length; i++) {
                const tdTitle = tr[i].getElementsByTagName('td')[1]; // Job Title
                const tdWorkMode = tr[i].getElementsByTagName('td')[2]; // Work Mode
                const tdLocation = tr[i].getElementsByTagName('td')[3]; // Location
                if (tdTitle || tdWorkMode || tdLocation) {
                    const titleText = tdTitle ? tdTitle.textContent.toLowerCase() : '';
                    const workModeText = tdWorkMode ? tdWorkMode.textContent.toLowerCase() : '';
                    const locationText = tdLocation ? tdLocation.textContent.toLowerCase() : '';
                    tr[i].style.display = (titleText.indexOf(filter) > -1 || workModeText.indexOf(filter) > -1 || locationText.indexOf(filter) > -1) ? '' : 'none';
                }
            }
        }
        showNotification('Filtering table by: ' + (filter || 'empty search'), 'info');
    }

    // Enhanced notification functions
    function toggleNotifications() {
        const dropdown = document.getElementById('notificationDropdown');
        const isShowing = dropdown.classList.contains('show');

        if (!isShowing) {
            refreshNotifications();
        }

        dropdown.classList.toggle('show');

        if (dropdown.classList.contains('show')) {
            document.addEventListener('click', closeNotificationsOnClickOutside);
        } else {
            document.removeEventListener('click', closeNotificationsOnClickOutside);
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
    }

    function markAsRead(notificationId, button) {
        markNotificationAsRead(notificationId, button, false);
    }

    function markAsReadInModal(notificationId, button) {
        markNotificationAsRead(notificationId, button, true);
    }

    function markNotificationAsRead(notificationId, button, isInModal = false) {
        console.log('Marking notification as read:', notificationId);

        // Update UI immediately
        const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);
        if (notificationElement) {
            notificationElement.classList.remove('unread');
            if (button) {
                button.style.display = 'none';
            }
        }

        // Update badge count
        updateNotificationBadge();

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
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('Notification marked as read successfully');
                    if (!isInModal) {
                        showNotification('Notification marked as read', 'success');
                    }
                } else {
                    console.error('Failed to mark notification as read:', data.error);
                    // Revert UI changes
                    if (notificationElement) {
                        notificationElement.classList.add('unread');
                        if (button) {
                            button.style.display = 'block';
                        }
                    }
                    updateNotificationBadge();
                    showNotification('Failed to mark notification as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking notification as read:', error);
                // Revert UI changes
                if (notificationElement) {
                    notificationElement.classList.add('unread');
                    if (button) {
                        button.style.display = 'block';
                    }
                }
                updateNotificationBadge();
                showNotification('Error marking notification as read', 'error');
            });
    }

    function markAllAsRead() {
        console.log('Marking ALL notifications as read');

        const unreadItems = document.querySelectorAll('.notification-item.unread');
        if (unreadItems.length === 0) {
            showNotification('All notifications are already marked as read', 'info');
            return;
        }

        showNotification('Marking all notifications as read...', 'info');

        // Update UI immediately
        unreadItems.forEach(item => {
            item.classList.remove('unread');
            const markReadBtn = item.querySelector('.notification-mark-read-btn');
            if (markReadBtn) {
                markReadBtn.style.display = 'none';
            }
        });

        // Update badge count immediately
        updateNotificationBadge();

        // Send AJAX request to mark all as read
        fetch('${pageContext.request.contextPath}/company/mark-all-notifications-read', {
            method: 'POST',
            body: new URLSearchParams({
                companyId: '<%= companyId %>'
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
                    console.log('All notifications marked as read successfully');
                    forceClearNotificationBadge();
                    showNotification('All notifications marked as read successfully!', 'success');

                    setTimeout(() => {
                        document.getElementById('notificationDropdown').classList.remove('show');
                    }, 1000);
                } else {
                    console.error('Server returned error:', data.error);
                    showNotification('Failed to mark notifications as read: ' + (data.error || 'Unknown error'), 'error');
                    unreadItems.forEach(item => {
                        item.classList.add('unread');
                    });
                    updateNotificationBadge();
                }
            })
            .catch(error => {
                console.error('Error marking all notifications as read:', error);
                showNotification('Error marking notifications as read. Please try again.', 'error');
                unreadItems.forEach(item => {
                    item.classList.add('unread');
                });
                updateNotificationBadge();
            });
    }

    function markAllAsReadInModal() {
        markAllAsRead();
        // Don't close modal immediately, let user see the changes
        setTimeout(() => {
            closeAllNotificationsModal();
        }, 1500);
    }

    function deleteAllNotifications() {
        if (!confirm('Are you sure you want to delete all notifications? This action cannot be undone.')) {
            return;
        }

        showNotification('Deleting all notifications...', 'info');

        fetch('${pageContext.request.contextPath}/company/delete-all-notifications', {
            method: 'POST',
            body: new URLSearchParams({
                companyId: '<%= companyId %>'
            }),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const notificationList = document.querySelector('.notification-list');
                    notificationList.innerHTML = '<div class="no-notifications">No notifications</div>';

                    const badge = document.getElementById('notificationBadge');
                    if (badge) {
                        badge.remove();
                    }

                    const clearBtn = document.querySelector('.clear-btn');
                    if (clearBtn) {
                        clearBtn.style.display = 'none';
                    }

                    const markReadBtn = document.querySelector('.mark-read-btn');
                    if (markReadBtn) {
                        markReadBtn.style.display = 'none';
                    }

                    document.getElementById('notificationDropdown').classList.remove('show');
                    showNotification('All notifications deleted successfully', 'success');
                } else {
                    console.error('Failed to delete all notifications:', data.error);
                    showNotification('Failed to delete notifications: ' + data.error, 'error');
                }
            })
            .catch(error => {
                console.error('Error deleting all notifications:', error);
                showNotification('Error deleting notifications', 'error');
            });
    }

    function deleteAllNotificationsInModal() {
        if (!confirm('Are you sure you want to delete ALL notifications? This action cannot be undone and will remove all notification history.')) {
            return;
        }

        showNotification('Deleting all notifications...', 'info');

        fetch('${pageContext.request.contextPath}/company/delete-all-notifications', {
            method: 'POST',
            body: new URLSearchParams({
                companyId: '<%= companyId %>'
            }),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const notificationList = document.getElementById('allNotificationsList');
                    notificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';

                    const badge = document.getElementById('notificationBadge');
                    if (badge) {
                        badge.remove();
                    }

                    // Update dropdown notifications
                    const dropdownList = document.querySelector('.notification-dropdown .notification-list');
                    if (dropdownList) {
                        dropdownList.innerHTML = '<div class="no-notifications">No notifications</div>';
                    }

                    showNotification('All notifications deleted successfully', 'success');

                    setTimeout(() => {
                        closeAllNotificationsModal();
                    }, 1500);
                } else {
                    console.error('Failed to delete all notifications:', data.error);
                    showNotification('Failed to delete notifications: ' + data.error, 'error');
                }
            })
            .catch(error => {
                console.error('Error deleting all notifications:', error);
                showNotification('Error deleting notifications', 'error');
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

        updateMarkReadButtonVisibility();
        refreshNotificationCount();
    }

    function forceClearNotificationBadge() {
        const badge = document.getElementById('notificationBadge');
        if (badge) {
            badge.remove();
        }
        updateMarkReadButtonVisibility();
    }

    function updateMarkReadButtonVisibility() {
        const unreadItems = document.querySelectorAll('.notification-item.unread');
        const markReadBtn = document.querySelector('.mark-read-btn');

        if (markReadBtn) {
            if (unreadItems.length === 0) {
                markReadBtn.style.display = 'none';
            } else {
                markReadBtn.style.display = 'block';
            }
        }
    }

    function refreshNotificationCount() {
        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))
            .then(response => response.json())
            .then(data => {
                console.log('Server unread count:', data.unreadCount);
                const badge = document.getElementById('notificationBadge');
                const clientUnreadCount = document.querySelectorAll('.notification-item.unread').length;

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
                            currentBadge.textContent = data.unreadCount;
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    } else {
                        createNotificationBadge(data.unreadCount);
                        if (data.unreadCount > 0) {
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    }
                }
            })
            .catch(error => console.error('Error checking notifications:', error));
    }

    // Show All Notifications Modal
    function showAllNotificationsModal() {
        const modal = document.getElementById('all-notifications-modal');
        modal.style.display = 'block';
        document.getElementById('notificationDropdown').classList.remove('show');
        showNotification('Opening all notifications');
    }

    // Close All Notifications Modal
    function closeAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'none';
        showNotification('Closed notifications view');
    }

    // Show notification details
    function showNotificationDetails(notificationId) {
        console.log('Showing details for notification:', notificationId);
        const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);
        if (notificationElement && notificationElement.classList.contains('unread')) {
            markAsReadInModal(notificationId, notificationElement.querySelector('.notification-mark-read-btn'));
        }
    }

    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('all-notifications-modal');
        if (event.target === modal) {
            closeAllNotificationsModal();
        }
    });

    // Notification Function
    function showNotification(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = 'toast-notification' + (type !== 'info' ? ' ' + type : '');
        toast.textContent = message;
        document.body.appendChild(toast);

        setTimeout(() => {
            toast.remove();
        }, 3000);

        if ('Notification' in window && Notification.permission === 'granted') {
            new Notification('HireZa Dashboard', { body: message });
        } else if ('Notification' in window && Notification.permission === 'default') {
            Notification.requestPermission().then(permission => {
                if (permission === 'granted') {
                    new Notification('HireZa Dashboard', { body: message });
                }
            });
        }
    }

    // Sign-out Modal Functions
    function showSignOutModal() {
        document.getElementById('signout-modal').style.display = 'block';
        showNotification('Sign out confirmation prompted');
    }

    function closeSignOutModal() {
        document.getElementById('signout-modal').style.display = 'none';
        showNotification('Sign out cancelled');
    }

    // Delete Modal Functions
    function showDeleteModal(jobId) {
        document.getElementById('delete-modal').style.display = 'block';
        document.getElementById('delete-job-id').value = jobId;
        const modalText = document.getElementById('delete-modal-text');
        modalText.textContent = 'Are you sure you want to delete this job post?';
        showNotification('Delete confirmation prompted for Job ID: ' + jobId);
    }

    function closeDeleteModal() {
        document.getElementById('delete-modal').style.display = 'none';
        showNotification('Delete cancelled');
    }

    function confirmDeleteAction() {
        const jobId = document.getElementById('delete-job-id').value;
        showNotification('Deleting job post ID: ' + jobId);
        window.location.href = '${pageContext.request.contextPath}/company/jobs/delete?id=' + jobId;
    }

    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        sidebar.classList.toggle('hidden');
        mainContent.classList.toggle('collapsed');
        showNotification(sidebar.classList.contains('hidden') ? 'Sidebar hidden' : 'Sidebar shown');
    }

    function toggleSidebarCollapse() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleIcon = document.querySelector('.toggle-icon');
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('expanded');
        toggleIcon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';
        showNotification(sidebar.classList.contains('collapsed') ? 'Sidebar collapsed' : 'Sidebar expanded');
    }

    function signOut() {
        showNotification('Signing out...');
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
        }, 500);
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

    // Request notification permission on page load
    document.addEventListener('DOMContentLoaded', function() {
        if ('Notification' in window && Notification.permission === 'default') {
            Notification.requestPermission();
        }

        // Check for new notifications every 30 seconds
        setInterval(() => {
            checkNewNotifications();
        }, 30000);
    });

    // Function to highlight active sidebar menu item based on current page
    function setActiveSidebarItem() {
        const currentPage = window.location.pathname;
        const sidebarLinks = document.querySelectorAll('.sidebar a');

        sidebarLinks.forEach(link => {
            // Remove active class from all links first
            link.classList.remove('active');

            // Check if this link's href matches current page
            if (link.getAttribute('href') === currentPage) {
                link.classList.add('active');
            }

            // Special case for dashboard which might have different URLs but same page
            if (currentPage.includes('employer_dashboard') && link.getAttribute('href').includes('employer_dashboard')) {
                link.classList.add('active');
            }
        });
    }

    // Call this function when page loads
    document.addEventListener('DOMContentLoaded', function() {
        setActiveSidebarItem();
    });
</script>
</body>
</html>