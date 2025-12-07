<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="model.User, dao.CompanyDAO, model.Company" %>--%>
<%--<%@ page import="dao.NotificationDAO" %>--%>
<%--<%@ page import="model.Notification" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%--%>
<%--    User employer = (User) session.getAttribute("user");--%>
<%--    if (employer == null || !"Employer".equals(employer.getRole())) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--    CompanyDAO companyDAO = new CompanyDAO();--%>
<%--    Company company = companyDAO.getCompanyByUserId(employer.getId());--%>
<%--    String companyId = (company != null) ? company.getCompanyId() : "0";--%>

<%--    // Store companyId in session for notification servlet--%>
<%--    session.setAttribute("companyId", companyId);--%>

<%--    // Initialize Notification DAO--%>
<%--    NotificationDAO notifDAO = new NotificationDAO();--%>
<%--    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);--%>
<%--    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);--%>

<%--    String companyLogo = (company != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/30?text=Logo";--%>
<%--    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Post New Job - Job Portal</title>--%>
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

<%--        /* Right Section Styles */--%>
<%--        .right-section {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 1rem;--%>
<%--        }--%>

<%--        /* Notification Bell Styles */--%>
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

<%--        /* Notification Dropdown */--%>
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

<%--        .form-container {--%>
<%--            background-color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);--%>
<%--            max-width: 800px;--%>
<%--        }--%>

<%--        .form-group {--%>
<%--            margin-bottom: 1.5rem;--%>
<%--        }--%>

<%--        .form-group label {--%>
<%--            display: block;--%>
<%--            font-weight: bold;--%>
<%--            margin-bottom: 0.5rem;--%>
<%--            color: #555;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        .form-group input,--%>
<%--        .form-group select,--%>
<%--        .form-group textarea {--%>
<%--            width: 100%;--%>
<%--            padding: 0.75rem 1rem;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--            border-radius: 5px;--%>
<%--            font-size: 0.95rem;--%>
<%--            box-sizing: border-box;--%>
<%--            transition: border-color 0.3s, box-shadow 0.3s;--%>
<%--        }--%>

<%--        .form-group input:focus,--%>
<%--        .form-group select:focus,--%>
<%--        .form-group textarea:focus {--%>
<%--            outline: none;--%>
<%--            border-color: #007bff;--%>
<%--            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);--%>
<%--        }--%>

<%--        .form-group textarea {--%>
<%--            resize: vertical;--%>
<%--            min-height: 100px;--%>
<%--        }--%>

<%--        .btn {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--            padding: 0.75rem 1.5rem;--%>
<%--            text-decoration: none;--%>
<%--            border-radius: 5px;--%>
<%--            border: none;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.95rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--            display: inline-block;--%>
<%--        }--%>

<%--        .btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        .quick-btn {--%>
<%--            background-color: #e9ecef;--%>
<%--            color: #333;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--            margin-right: 0.5rem;--%>
<%--            margin-top: 0.5rem;--%>
<%--            border-radius: 5px;--%>
<%--            border: none;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 0.9rem;--%>
<%--            transition: background-color 0.3s;--%>
<%--        }--%>

<%--        .quick-btn:hover {--%>
<%--            background-color: #d3d7db;--%>
<%--        }--%>

<%--        .back-btn {--%>
<%--            background-color: #6c757d;--%>
<%--            margin-top: 1rem;--%>
<%--        }--%>

<%--        .back-btn:hover {--%>
<%--            background-color: #545b62;--%>
<%--        }--%>

<%--        .error {--%>
<%--            color: #dc2626;--%>
<%--            text-align: center;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            font-size: 1rem;--%>
<%--            background-color: #f9fbfc;--%>
<%--            padding: 0.75rem;--%>
<%--            border-radius: 5px;--%>
<%--            border: 1px solid #e0e0e0;--%>
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

<%--        /* Notification Modals */--%>
<%--        .all-notifications-modal, .notification-details-modal {--%>
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

<%--        .all-notifications-modal-content, .notification-details-modal-content {--%>
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

<%--        .notification-list {--%>
<%--            max-height: 60vh;--%>
<%--            overflow-y: auto;--%>
<%--        }--%>

<%--        /* Action buttons in modal */--%>
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
<%--            background-color: #28a745;--%>
<%--            color: white;--%>
<%--        }--%>

<%--        .modal-action-btn.mark-read:hover {--%>
<%--            background-color: #218838;--%>
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

<%--            .notification-dropdown {--%>
<%--                width: 350px;--%>
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

<%--            .notification-dropdown {--%>
<%--                width: 300px;--%>
<%--                right: -50px;--%>
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

<%--            .form-container {--%>
<%--                max-width: 100%;--%>
<%--            }--%>

<%--            .modal-actions {--%>
<%--                flex-direction: column;--%>
<%--            }--%>

<%--            .modal-action-btn {--%>
<%--                width: 100%;--%>
<%--                justify-content: center;--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 480px) {--%>
<%--            .navbar {--%>
<%--                flex-direction: column;--%>
<%--                align-items: flex-start;--%>
<%--            }--%>

<%--            .navbar .logo {--%>
<%--                font-size: 1.4rem;--%>
<%--                margin-bottom: 0.5rem;--%>
<%--            }--%>

<%--            .navbar .logo img {--%>
<%--                height: 1.7rem;--%>
<%--                width: auto;--%>
<%--            }--%>

<%--            .notification-dropdown {--%>
<%--                width: 280px;--%>
<%--                right: -80px;--%>
<%--            }--%>

<%--            .navbar .profile-box {--%>
<%--                padding: 0.2rem 0.6rem;--%>
<%--                height: 35px;--%>
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

<%--            .all-notifications-modal-content {--%>
<%--                margin: 10% auto;--%>
<%--                padding: 15px;--%>
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
<%--                     data-notification-id="<%= notification.getNotificationId() %>">--%>
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
<%--            <h1>Post New Job</h1>--%>
<%--        </div>--%>
<%--        <div class="form-container">--%>
<%--            <%--%>
<%--                if (request.getParameter("error") != null) {--%>
<%--            %>--%>
<%--            <p class="error">Error posting job. Please try again.</p>--%>
<%--            <% } %>--%>
<%--            <form action="${pageContext.request.contextPath}/company/jobs/post" method="post" onsubmit="return validateForm()">--%>
<%--                <div class="form-group">--%>
<%--                    <label for="jobTitle">Job Title *</label>--%>
<%--                    <input type="text" id="jobTitle" name="jobTitle" required>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="workMode">Work Mode</label>--%>
<%--                    <select id="workMode" name="workMode">--%>
<%--                        <option value="">Select Work Mode</option>--%>
<%--                        <option value="onsite">Onsite</option>--%>
<%--                        <option value="remote">Remote</option>--%>
<%--                        <option value="hybrid">Hybrid</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="location">Location (City/Country)</label>--%>
<%--                    <input type="text" id="location" name="location">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="employmentType">Employment Type</label>--%>
<%--                    <input type="text" id="employmentType" name="employmentType" placeholder="e.g., full-time, part-time">--%>
<%--                    <div>--%>
<%--                        <button type="button" class="quick-btn" onclick="setEmploymentType('Full-time')">Full-time</button>--%>
<%--                        <button type="button" class="quick-btn" onclick="setEmploymentType('Part-time')">Part-time</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="jobDescription">Job Description</label>--%>
<%--                    <textarea id="jobDescription" name="jobDescription" rows="6"></textarea>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="requiredSkills">Required Skills</label>--%>
<%--                    <textarea id="requiredSkills" name="requiredSkills" rows="4"></textarea>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="experienceLevel">Experience Level</label>--%>
<%--                    <input type="text" id="experienceLevel" name="experienceLevel" placeholder="e.g., entry, 3-5 years">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="applicationDeadline">Application Deadline</label>--%>
<%--                    <input type="date" id="applicationDeadline" name="applicationDeadline" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="salaryRange">Salary Range</label>--%>
<%--                    <input type="text" id="salaryRange" name="salaryRange" placeholder="e.g., 50000-70000">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="workingHoursShifts">Working Hours / Shifts</label>--%>
<%--                    <input type="text" id="workingHoursShifts" name="workingHoursShifts" placeholder="e.g., 9-5, Mon-Fri">--%>
<%--                    <div>--%>
<%--                        <button type="button" class="quick-btn" onclick="setWorkingHours('9-5, Mon-Fri')">9-5, Mon-Fri</button>--%>
<%--                        <button type="button" class="quick-btn" onclick="setWorkingHours('Flexible')">Flexible</button>--%>
<%--                        <button type="button" class="quick-btn" onclick="setWorkingHours('Shift-based')">Shift-based</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <button type="submit" class="btn"><i class="fas fa-plus"></i> Post Job</button>--%>
<%--            </form>--%>
<%--            <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>--%>
<%--        </div>--%>
<%--    </main>--%>
<%--</div>--%>

<%--<script>--%>
<%--    // Enhanced notification functions - SAME AS EMPLOYER DASHBOARD--%>
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
<%--        console.log('Marking notification as read:', notificationId, 'isInModal:', isInModal);--%>

<%--        // Disable the button immediately to prevent double-clicks--%>
<%--        if (button) {--%>
<%--            button.disabled = true;--%>
<%--            button.style.opacity = '0.5';--%>
<%--            button.style.cursor = 'not-allowed';--%>
<%--        }--%>

<%--        // Find ALL notification elements with this ID (in dropdown and modal)--%>
<%--        const notificationElements = document.querySelectorAll(`[data-notification-id="${notificationId}"]`);--%>
<%--        console.log('Found notification elements:', notificationElements.length);--%>

<%--        // Store original state for rollback--%>
<%--        const originalStates = [];--%>
<%--        notificationElements.forEach(element => {--%>
<%--            const btn = element.querySelector('.notification-mark-read-btn');--%>
<%--            originalStates.push({--%>
<%--                element: element,--%>
<%--                hadUnreadClass: element.classList.contains('unread'),--%>
<%--                button: btn ? btn.cloneNode(true) : null,--%>
<%--                buttonParent: btn ? btn.parentElement : null--%>
<%--            });--%>
<%--        });--%>

<%--        // Update UI immediately for all instances - HIDE buttons with animation--%>
<%--        notificationElements.forEach(notificationElement => {--%>
<%--            notificationElement.classList.remove('unread');--%>
<%--            const markReadBtn = notificationElement.querySelector('.notification-mark-read-btn');--%>
<%--            if (markReadBtn) {--%>
<%--                // Add fade out animation--%>
<%--                markReadBtn.style.transition = 'opacity 0.3s ease, visibility 0.3s ease';--%>
<%--                markReadBtn.style.opacity = '0';--%>
<%--                markReadBtn.style.visibility = 'hidden';--%>

<%--                // After animation, set display none--%>
<%--                setTimeout(() => {--%>
<%--                    markReadBtn.style.display = 'none';--%>
<%--                }, 300);--%>
<%--            }--%>
<%--        });--%>

<%--        // Update badge count and mark read buttons immediately--%>
<%--        updateNotificationBadgeImmediate();--%>

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
<%--                    // Show success message--%>
<%--                    showNotification('Notification marked as read', 'success');--%>

<%--                    // Now permanently remove the buttons after ensuring they're hidden--%>
<%--                    setTimeout(() => {--%>
<%--                        notificationElements.forEach(notificationElement => {--%>
<%--                            const markReadBtn = notificationElement.querySelector('.notification-mark-read-btn');--%>
<%--                            if (markReadBtn) {--%>
<%--                                markReadBtn.remove();--%>
<%--                            }--%>
<%--                        });--%>
<%--                    }, 350);--%>

<%--                    // Final badge update from server--%>
<%--                    refreshNotificationCount();--%>
<%--                } else {--%>
<%--                    console.error('Failed to mark notification as read:', data.error);--%>
<%--                    // Revert UI changes--%>
<%--                    restoreOriginalStates(originalStates);--%>
<%--                    showNotification('Failed to mark notification as read', 'error');--%>
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error marking notification as read:', error);--%>
<%--                // Revert UI changes--%>
<%--                restoreOriginalStates(originalStates);--%>
<%--                showNotification('Error marking notification as read', 'error');--%>
<%--            });--%>
<%--    }--%>

<%--    function restoreOriginalStates(originalStates) {--%>
<%--        originalStates.forEach(state => {--%>
<%--            if (state.hadUnreadClass) {--%>
<%--                state.element.classList.add('unread');--%>
<%--            }--%>
<%--            if (state.button && state.buttonParent) {--%>
<%--                const existingBtn = state.element.querySelector('.notification-mark-read-btn');--%>
<%--                if (existingBtn) {--%>
<%--                    existingBtn.style.display = 'block';--%>
<%--                    existingBtn.style.opacity = '1';--%>
<%--                    existingBtn.style.visibility = 'visible';--%>
<%--                    existingBtn.disabled = false;--%>
<%--                    existingBtn.style.cursor = 'pointer';--%>
<%--                } else {--%>
<%--                    // Re-add the button--%>
<%--                    const newButton = state.button.cloneNode(true);--%>
<%--                    newButton.style.opacity = '1';--%>
<%--                    newButton.style.visibility = 'visible';--%>
<%--                    newButton.style.display = 'block';--%>

<%--                    // Re-attach the correct event handler--%>
<%--                    const notifId = state.element.getAttribute('data-notification-id');--%>
<%--                    const isInModalElement = state.element.closest('#allNotificationsList') !== null;--%>

<%--                    newButton.onclick = function(e) {--%>
<%--                        e.stopPropagation();--%>
<%--                        if (isInModalElement) {--%>
<%--                            markAsReadInModal(notifId, this);--%>
<%--                        } else {--%>
<%--                            markAsRead(notifId, this);--%>
<%--                        }--%>
<%--                    };--%>

<%--                    state.buttonParent.appendChild(newButton);--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>
<%--        updateNotificationBadgeImmediate();--%>
<%--    }--%>

<%--    function updateNotificationBadgeImmediate() {--%>
<%--        const badge = document.getElementById('notificationBadge');--%>
<%--        const unreadItems = document.querySelectorAll('.notification-item.unread');--%>
<%--        const unreadCount = unreadItems.length;--%>

<%--        console.log('Updating badge immediately, unread count:', unreadCount);--%>

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

<%--        // Update the visibility of "Mark all read" button in dropdown--%>
<%--        const markAllReadBtn = document.querySelector('.notification-actions .mark-read-btn');--%>
<%--        if (markAllReadBtn) {--%>
<%--            if (unreadCount === 0) {--%>
<%--                markAllReadBtn.style.display = 'none';--%>
<%--            } else {--%>
<%--                markAllReadBtn.style.display = 'flex';--%>
<%--            }--%>
<%--        }--%>

<%--        // Update the visibility of "Mark All as Read" button in modal--%>
<%--        const modalMarkAllReadBtn = document.querySelector('.modal-action-btn.mark-read');--%>
<%--        if (modalMarkAllReadBtn) {--%>
<%--            if (unreadCount === 0) {--%>
<%--                modalMarkAllReadBtn.style.display = 'none';--%>
<%--            } else {--%>
<%--                modalMarkAllReadBtn.style.display = 'flex';--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    function markAllAsRead() {--%>
<%--        console.log('Marking ALL notifications as read');--%>

<%--        const unreadItems = document.querySelectorAll('.notification-item.unread');--%>
<%--        if (unreadItems.length === 0) {--%>
<%--            showNotification('All notifications are already marked as read', 'success');--%>
<%--            return;--%>
<%--        }--%>

<%--        showNotification('Marking all notifications as read...', 'info');--%>

<%--        // Update UI immediately - remove buttons--%>
<%--        unreadItems.forEach(item => {--%>
<%--            item.classList.remove('unread');--%>
<%--            const markReadBtn = item.querySelector('.notification-mark-read-btn');--%>
<%--            if (markReadBtn) {--%>
<%--                markReadBtn.remove();--%>
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
<%--                }--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--                console.error('Error marking all notifications as read:', error);--%>
<%--                showNotification('Error marking notifications as read. Please try again.', 'error');--%>
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
<%--                    // Update dropdown notification list--%>
<%--                    const notificationList = document.querySelector('.notification-dropdown .notification-list');--%>
<%--                    notificationList.innerHTML = '<div class="no-notifications">No notifications</div>';--%>

<%--                    // Update modal notification list--%>
<%--                    const modalNotificationList = document.getElementById('allNotificationsList');--%>
<%--                    if (modalNotificationList) {--%>
<%--                        modalNotificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';--%>
<%--                    }--%>

<%--                    // Remove badge--%>
<%--                    const badge = document.getElementById('notificationBadge');--%>
<%--                    if (badge) {--%>
<%--                        badge.remove();--%>
<%--                    }--%>

<%--                    // Hide all action buttons in dropdown--%>
<%--                    const clearBtn = document.querySelector('.notification-actions .clear-btn');--%>
<%--                    if (clearBtn) {--%>
<%--                        clearBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    const markReadBtn = document.querySelector('.notification-actions .mark-read-btn');--%>
<%--                    if (markReadBtn) {--%>
<%--                        markReadBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    // Hide all action buttons in modal--%>
<%--                    const modalMarkReadBtn = document.querySelector('.modal-action-btn.mark-read');--%>
<%--                    if (modalMarkReadBtn) {--%>
<%--                        modalMarkReadBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    const modalDeleteBtn = document.querySelector('.modal-action-btn.delete-all');--%>
<%--                    if (modalDeleteBtn) {--%>
<%--                        modalDeleteBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    // Close dropdown--%>
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
<%--                    // Update modal notification list--%>
<%--                    const notificationList = document.getElementById('allNotificationsList');--%>
<%--                    notificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';--%>

<%--                    // Update dropdown notification list--%>
<%--                    const dropdownList = document.querySelector('.notification-dropdown .notification-list');--%>
<%--                    if (dropdownList) {--%>
<%--                        dropdownList.innerHTML = '<div class="no-notifications">No notifications</div>';--%>
<%--                    }--%>

<%--                    // Remove badge--%>
<%--                    const badge = document.getElementById('notificationBadge');--%>
<%--                    if (badge) {--%>
<%--                        badge.remove();--%>
<%--                    }--%>

<%--                    // Hide all action buttons in dropdown--%>
<%--                    const clearBtn = document.querySelector('.notification-actions .clear-btn');--%>
<%--                    if (clearBtn) {--%>
<%--                        clearBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    const markReadBtn = document.querySelector('.notification-actions .mark-read-btn');--%>
<%--                    if (markReadBtn) {--%>
<%--                        markReadBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    // Hide all action buttons in modal--%>
<%--                    const modalMarkReadBtn = document.querySelector('.modal-action-btn.mark-read');--%>
<%--                    if (modalMarkReadBtn) {--%>
<%--                        modalMarkReadBtn.style.display = 'none';--%>
<%--                    }--%>

<%--                    const modalDeleteBtn = document.querySelector('.modal-action-btn.delete-all');--%>
<%--                    if (modalDeleteBtn) {--%>
<%--                        modalDeleteBtn.style.display = 'none';--%>
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
<%--        updateNotificationBadgeImmediate();--%>
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
<%--                markReadBtn.style.display = 'flex';--%>
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
<%--    }--%>

<%--    // Close All Notifications Modal--%>
<%--    function closeAllNotificationsModal() {--%>
<%--        document.getElementById('all-notifications-modal').style.display = 'none';--%>
<%--    }--%>

<%--    // Show notification details - auto mark as read when clicked--%>
<%--    function showNotificationDetails(notificationId) {--%>
<%--        console.log('Showing details for notification:', notificationId);--%>
<%--        const notificationElements = document.querySelectorAll(`[data-notification-id="${notificationId}"]`);--%>

<%--        // Check if any of the notification instances is unread--%>
<%--        let isUnread = false;--%>
<%--        notificationElements.forEach(element => {--%>
<%--            if (element.classList.contains('unread')) {--%>
<%--                isUnread = true;--%>
<%--            }--%>
<%--        });--%>

<%--        // If unread, mark as read--%>
<%--        if (isUnread) {--%>
<%--            const markReadBtn = notificationElements[0].querySelector('.notification-mark-read-btn');--%>
<%--            markAsReadInModal(notificationId, markReadBtn);--%>
<%--        }--%>
<%--    }--%>

<%--    // Close modal when clicking outside--%>
<%--    window.addEventListener('click', function(event) {--%>
<%--        const allNotifModal = document.getElementById('all-notifications-modal');--%>
<%--        if (event.target === allNotifModal) {--%>
<%--            closeAllNotificationsModal();--%>
<%--        }--%>

<%--        const signoutModal = document.getElementById('signout-modal');--%>
<%--        if (event.target === signoutModal) {--%>
<%--            closeSignOutModal();--%>
<%--        }--%>
<%--    });--%>

<%--    // Prevent notification item click from closing modal--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        // Stop propagation for notification items in modal--%>
<%--        const allNotifsList = document.getElementById('allNotificationsList');--%>
<%--        if (allNotifsList) {--%>
<%--            allNotifsList.addEventListener('click', function(e) {--%>
<%--                e.stopPropagation();--%>
<%--            });--%>
<%--        }--%>

<%--        // Stop propagation for dropdown--%>
<%--        const dropdown = document.getElementById('notificationDropdown');--%>
<%--        if (dropdown) {--%>
<%--            dropdown.addEventListener('click', function(e) {--%>
<%--                e.stopPropagation();--%>
<%--            });--%>
<%--        }--%>

<%--        // Request notification permission--%>
<%--        if ('Notification' in window && Notification.permission === 'default') {--%>
<%--            Notification.requestPermission();--%>
<%--        }--%>

<%--        // Check for new notifications every 30 seconds--%>
<%--        setInterval(() => {--%>
<%--            checkNewNotifications();--%>
<%--        }, 30000);--%>
<%--    });--%>
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

<%--    function showSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'block';--%>
<%--    }--%>

<%--    function closeSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'none';--%>
<%--    }--%>

<%--    function toggleSidebar() {--%>
<%--        const sidebar = document.getElementById('sidebar');--%>
<%--        const mainContent = document.getElementById('mainContent');--%>
<%--        sidebar.classList.toggle('hidden');--%>
<%--        mainContent.classList.toggle('collapsed');--%>
<%--    }--%>

<%--    function toggleSidebarCollapse() {--%>
<%--        const sidebar = document.getElementById('sidebar');--%>
<%--        const mainContent = document.getElementById('mainContent');--%>
<%--        const toggleIcon = document.querySelector('.toggle-icon');--%>
<%--        sidebar.classList.toggle('collapsed');--%>
<%--        mainContent.classList.toggle('expanded');--%>
<%--        toggleIcon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';--%>
<%--    }--%>

<%--    function signOut() {--%>
<%--        showNotification('Signing out...', 'info');--%>
<%--        setTimeout(() => {--%>
<%--            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';--%>
<%--        }, 500);--%>
<%--    }--%>

<%--    // Quick Button Functions--%>
<%--    function setEmploymentType(value) {--%>
<%--        document.getElementById('employmentType').value = value;--%>
<%--        showNotification(`Employment Type set to ${value}`);--%>
<%--    }--%>

<%--    function setWorkingHours(value) {--%>
<%--        document.getElementById('workingHoursShifts').value = value;--%>
<%--        showNotification(`Working Hours set to ${value}`);--%>
<%--    }--%>

<%--    // Form Validation--%>
<%--    function validateForm() {--%>
<%--        let isValid = true;--%>

<%--        // Application Deadline Validation--%>
<%--        const deadlineInput = document.getElementById('applicationDeadline').value;--%>
<%--        if (deadlineInput) {--%>
<%--            const today = new Date();--%>
<%--            today.setHours(0, 0, 0, 0); // Normalize to midnight--%>
<%--            const selectedDate = new Date(deadlineInput);--%>
<%--            if (selectedDate < today) {--%>
<%--                showNotification('Application Deadline cannot be before today', 'error');--%>
<%--                isValid = false;--%>
<%--            }--%>
<%--        }--%>

<%--        // Salary Range Validation--%>
<%--        const salaryInput = document.getElementById('salaryRange').value;--%>
<%--        if (salaryInput && salaryInput.startsWith('-')) {--%>
<%--            showNotification('Salary Range cannot start with a negative sign', 'error');--%>
<%--            isValid = false;--%>
<%--        }--%>

<%--        if (!isValid) {--%>
<%--            return false; // Prevent form submission--%>
<%--        }--%>

<%--        showNotification('Posting job...', 'info');--%>
<%--        return true;--%>
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
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company" %>
<%@ page import="dao.NotificationDAO" %>
<%@ page import="model.Notification" %>
<%@ page import="java.util.List" %>
<%
    User employer = (User) session.getAttribute("user");
    if (employer == null || !"Employer".equals(employer.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(employer.getId());
    String companyId = (company != null) ? company.getCompanyId() : "0";

    // Store companyId in session for notification servlet
    session.setAttribute("companyId", companyId);

    // Initialize Notification DAO
    NotificationDAO notifDAO = new NotificationDAO();
    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);
    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);

    String companyLogo = (company != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/30?text=Logo";
    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post New Job - Job Portal</title>
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

        /* Right Section Styles */
        .right-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Notification Bell Styles */
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

        /* Notification Dropdown */
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
            position: relative;
            padding-bottom: 0.5rem;
        }

        .header h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: #007bff;
            border-radius: 2px;
        }

        .form-container {
            background-color: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            max-width: 900px;
            margin: 0 auto;
            transition: transform 0.3s ease;
        }

        .form-container:hover {
            transform: translateY(-5px);
        }

        .form-group {
            margin-bottom: 1.8rem;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.6rem;
            color: #444;
            font-size: 0.95rem;
            transition: color 0.3s ease;
        }

        .form-group label.required::after {
            content: '*';
            color: #dc3545;
            margin-left: 0.3rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 0.95rem;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background-color: #f9fafb;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
            background-color: #fff;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-group input:valid:not(:placeholder-shown),
        .form-group select:valid,
        .form-group textarea:valid:not(:placeholder-shown) {
            border-color: #28a745;
        }

        .btn {
            background: linear-gradient(90deg, #007bff, #0056b3);
            color: white;
            padding: 0.9rem 2rem;
            text-decoration: none;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            background: linear-gradient(90deg, #0056b3, #003087);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }

        .quick-btn {
            background-color: #e9ecef;
            color: #333;
            padding: 0.6rem 1.2rem;
            margin-right: 0.5rem;
            margin-top: 0.75rem;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .quick-btn:hover {
            background-color: #d3d7db;
            transform: translateY(-1px);
        }

        .quick-btn:active {
            transform: translateY(0);
        }

        .back-btn {
            background: linear-gradient(90deg, #6c757d, #545b62);
            margin-top: 1.5rem;
        }

        .back-btn:hover {
            background: linear-gradient(90deg, #545b62, #3d4449);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .error {
            color: #dc2626;
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            background-color: #fef2f2;
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #fee2e2;
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

        /* Notification Modals */
        .all-notifications-modal, .notification-details-modal {
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

        .all-notifications-modal-content, .notification-details-modal-content {
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

        .notification-list {
            max-height: 60vh;
            overflow-y: auto;
        }

        /* Action buttons in modal */
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
            background-color: #28a745;
            color: white;
        }

        .modal-action-btn.delete-all {
            background-color: #dc3545;
            color: white;
        }

        .modal-action-btn.mark-read:hover {
            background-color: #218838;
        }

        .modal-action-btn.delete-all:hover {
            background-color: #c82333;
        }

        .modal-action-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
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

            .notification-dropdown {
                width: 350px;
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

            .notification-dropdown {
                width: 300px;
                right: -50px;
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

            .form-container {
                max-width: 100%;
            }

            .modal-actions {
                flex-direction: column;
            }

            .modal-action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar .logo {
                font-size: 1.4rem;
                margin-bottom: 0.5rem;
            }

            .navbar .logo img {
                height: 1.7rem;
                width: auto;
            }

            .notification-dropdown {
                width: 280px;
                right: -80px;
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

            .all-notifications-modal-content {
                margin: 10% auto;
                padding: 15px;
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
<%--            <li><a href="${pageContext.request.contextPath}/company/jobs/post"><i class="fas fa-plus"></i> <span>Post New Job</span></a></li>--%>

            <li><a href="${pageContext.request.contextPath}/company/jobs/post" class="active"><i class="fas fa-tachometer-alt"></i> <span>Post New Job</span></a></li>

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

    <!-- Sign-out Modal -->
    <div id="signout-modal" class="signout-modal">
        <div class="signout-modal-content">
            <h2>Confirm Sign Out</h2>
            <p>Are you sure you want to sign out?</p>
            <button class="confirm-btn" onclick="signOut()">Yes, Sign Out</button>
            <button class="cancel-btn" onclick="closeSignOutModal()">Cancel</button>
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
            <h1>Post New Job</h1>
        </div>
        <div class="form-container">
            <%
                if (request.getParameter("error") != null) {
            %>
            <p class="error">Error posting job. Please try again.</p>
            <% } %>
            <form action="${pageContext.request.contextPath}/company/jobs/post" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="jobTitle" class="required">Job Title</label>
                    <input type="text" id="jobTitle" name="jobTitle" required>
                </div>
                <div class="form-group">
                    <label for="workMode" class="required">Work Mode</label>
                    <select id="workMode" name="workMode" required>
                        <option value="">Select Work Mode</option>
                        <option value="onsite">Onsite</option>
                        <option value="remote">Remote</option>
                        <option value="hybrid">Hybrid</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="location" class="required">Location (City/Country)</label>
                    <input type="text" id="location" name="location" required>
                </div>
                <div class="form-group">
                    <label for="employmentType" class="required">Employment Type</label>
                    <input type="text" id="employmentType" name="employmentType" placeholder="e.g., full-time, part-time" required>
                    <div>
                        <button type="button" class="quick-btn" onclick="setEmploymentType('Full-time')">Full-time</button>
                        <button type="button" class="quick-btn" onclick="setEmploymentType('Part-time')">Part-time</button>
                    </div>
                </div>
                <div class="form-group">
                    <label for="jobDescription" class="required">Job Description</label>
                    <textarea id="jobDescription" name="jobDescription" rows="6" required></textarea>
                </div>
                <div class="form-group">
                    <label for="requiredSkills" class="required">Required Skills</label>
                    <textarea id="requiredSkills" name="requiredSkills" rows="4" required></textarea>
                </div>
                <div class="form-group">
                    <label for="experienceLevel" class="required">Experience Level</label>
                    <input type="text" id="experienceLevel" name="experienceLevel" placeholder="e.g., entry, 3-5 years" required>
                </div>
                <div class="form-group">
                    <label for="applicationDeadline" class="required">Application Deadline</label>
                    <input type="date" id="applicationDeadline" name="applicationDeadline" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                </div>
                <div class="form-group">
                    <label for="salaryRange" class="required">Salary Range</label>
                    <input type="text" id="salaryRange" name="salaryRange" placeholder="e.g., 50000-70000" required>
                </div>
                <div class="form-group">
                    <label for="workingHoursShifts" class="required">Working Hours / Shifts</label>
                    <input type="text" id="workingHoursShifts" name="workingHoursShifts" placeholder="e.g., 9-5, Mon-Fri" required>
                    <div>
                        <button type="button" class="quick-btn" onclick="setWorkingHours('9-5, Mon-Fri')">9-5, Mon-Fri</button>
                        <button type="button" class="quick-btn" onclick="setWorkingHours('Flexible')">Flexible</button>
                        <button type="button" class="quick-btn" onclick="setWorkingHours('Shift-based')">Shift-based</button>
                    </div>
                </div>
                <button type="submit" class="btn"><i class="fas fa-plus"></i> Post Job</button>
            </form>
            <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </main>
</div>

<script>
    // Enhanced notification functions - SAME AS EMPLOYER DASHBOARD
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
        console.log('Marking notification as read:', notificationId, 'isInModal:', isInModal);

        // Disable the button immediately to prevent double-clicks
        if (button) {
            button.disabled = true;
            button.style.opacity = '0.5';
            button.style.cursor = 'not-allowed';
        }

        // Find ALL notification elements with this ID (in dropdown and modal)
        const notificationElements = document.querySelectorAll(`[data-notification-id="${notificationId}"]`);
        console.log('Found notification elements:', notificationElements.length);

        // Store original state for rollback
        const originalStates = [];
        notificationElements.forEach(element => {
            const btn = element.querySelector('.notification-mark-read-btn');
            originalStates.push({
                element: element,
                hadUnreadClass: element.classList.contains('unread'),
                button: btn ? btn.cloneNode(true) : null,
                buttonParent: btn ? btn.parentElement : null
            });
        });

        // Update UI immediately for all instances - HIDE buttons with animation
        notificationElements.forEach(notificationElement => {
            notificationElement.classList.remove('unread');
            const markReadBtn = notificationElement.querySelector('.notification-mark-read-btn');
            if (markReadBtn) {
                // Add fade out animation
                markReadBtn.style.transition = 'opacity 0.3s ease, visibility 0.3s ease';
                markReadBtn.style.opacity = '0';
                markReadBtn.style.visibility = 'hidden';

                // After animation, set display none
                setTimeout(() => {
                    markReadBtn.style.display = 'none';
                }, 300);
            }
        });

        // Update badge count and mark read buttons immediately
        updateNotificationBadgeImmediate();

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
                    // Show success message
                    showNotification('Notification marked as read', 'success');

                    // Now permanently remove the buttons after ensuring they're hidden
                    setTimeout(() => {
                        notificationElements.forEach(notificationElement => {
                            const markReadBtn = notificationElement.querySelector('.notification-mark-read-btn');
                            if (markReadBtn) {
                                markReadBtn.remove();
                            }
                        });
                    }, 350);

                    // Final badge update from server
                    refreshNotificationCount();
                } else {
                    console.error('Failed to mark notification as read:', data.error);
                    // Revert UI changes
                    restoreOriginalStates(originalStates);
                    showNotification('Failed to mark notification as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking notification as read:', error);
                // Revert UI changes
                restoreOriginalStates(originalStates);
                showNotification('Error marking notification as read', 'error');
            });
    }

    function restoreOriginalStates(originalStates) {
        originalStates.forEach(state => {
            if (state.hadUnreadClass) {
                state.element.classList.add('unread');
            }
            if (state.button && state.buttonParent) {
                const existingBtn = state.element.querySelector('.notification-mark-read-btn');
                if (existingBtn) {
                    existingBtn.style.display = 'block';
                    existingBtn.style.opacity = '1';
                    existingBtn.style.visibility = 'visible';
                    existingBtn.disabled = false;
                    existingBtn.style.cursor = 'pointer';
                } else {
                    // Re-add the button
                    const newButton = state.button.cloneNode(true);
                    newButton.style.opacity = '1';
                    newButton.style.visibility = 'visible';
                    newButton.style.display = 'block';

                    // Re-attach the correct event handler
                    const notifId = state.element.getAttribute('data-notification-id');
                    const isInModalElement = state.element.closest('#allNotificationsList') !== null;

                    newButton.onclick = function(e) {
                        e.stopPropagation();
                        if (isInModalElement) {
                            markAsReadInModal(notifId, this);
                        } else {
                            markAsRead(notifId, this);
                        }
                    };

                    state.buttonParent.appendChild(newButton);
                }
            }
        });
        updateNotificationBadgeImmediate();
    }

    function updateNotificationBadgeImmediate() {
        const badge = document.getElementById('notificationBadge');
        const unreadItems = document.querySelectorAll('.notification-item.unread');
        const unreadCount = unreadItems.length;

        console.log('Updating badge immediately, unread count:', unreadCount);

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

        // Update the visibility of "Mark all read" button in dropdown
        const markAllReadBtn = document.querySelector('.notification-actions .mark-read-btn');
        if (markAllReadBtn) {
            if (unreadCount === 0) {
                markAllReadBtn.style.display = 'none';
            } else {
                markAllReadBtn.style.display = 'flex';
            }
        }

        // Update the visibility of "Mark All as Read" button in modal
        const modalMarkAllReadBtn = document.querySelector('.modal-action-btn.mark-read');
        if (modalMarkAllReadBtn) {
            if (unreadCount === 0) {
                modalMarkAllReadBtn.style.display = 'none';
            } else {
                modalMarkAllReadBtn.style.display = 'flex';
            }
        }
    }

    function markAllAsRead() {
        console.log('Marking ALL notifications as read');

        const unreadItems = document.querySelectorAll('.notification-item.unread');
        if (unreadItems.length === 0) {
            showNotification('All notifications are already marked as read', 'success');
            return;
        }

        showNotification('Marking all notifications as read...', 'info');

        // Update UI immediately - remove buttons
        unreadItems.forEach(item => {
            item.classList.remove('unread');
            const markReadBtn = item.querySelector('.notification-mark-read-btn');
            if (markReadBtn) {
                markReadBtn.remove();
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
                }
            })
            .catch(error => {
                console.error('Error marking all notifications as read:', error);
                showNotification('Error marking notifications as read. Please try again.', 'error');
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
                    // Update dropdown notification list
                    const notificationList = document.querySelector('.notification-dropdown .notification-list');
                    notificationList.innerHTML = '<div class="no-notifications">No notifications</div>';

                    // Update modal notification list
                    const modalNotificationList = document.getElementById('allNotificationsList');
                    if (modalNotificationList) {
                        modalNotificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';
                    }

                    // Remove badge
                    const badge = document.getElementById('notificationBadge');
                    if (badge) {
                        badge.remove();
                    }

                    // Hide all action buttons in dropdown
                    const clearBtn = document.querySelector('.notification-actions .clear-btn');
                    if (clearBtn) {
                        clearBtn.style.display = 'none';
                    }

                    const markReadBtn = document.querySelector('.notification-actions .mark-read-btn');
                    if (markReadBtn) {
                        markReadBtn.style.display = 'none';
                    }

                    // Hide all action buttons in modal
                    const modalMarkReadBtn = document.querySelector('.modal-action-btn.mark-read');
                    if (modalMarkReadBtn) {
                        modalMarkReadBtn.style.display = 'none';
                    }

                    const modalDeleteBtn = document.querySelector('.modal-action-btn.delete-all');
                    if (modalDeleteBtn) {
                        modalDeleteBtn.style.display = 'none';
                    }

                    // Close dropdown
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
                    // Update modal notification list
                    const notificationList = document.getElementById('allNotificationsList');
                    notificationList.innerHTML = '<div class="no-notifications">No notifications available</div>';

                    // Update dropdown notification list
                    const dropdownList = document.querySelector('.notification-dropdown .notification-list');
                    if (dropdownList) {
                        dropdownList.innerHTML = '<div class="no-notifications">No notifications</div>';
                    }

                    // Remove badge
                    const badge = document.getElementById('notificationBadge');
                    if (badge) {
                        badge.remove();
                    }

                    // Hide all action buttons in dropdown
                    const clearBtn = document.querySelector('.notification-actions .clear-btn');
                    if (clearBtn) {
                        clearBtn.style.display = 'none';
                    }

                    const markReadBtn = document.querySelector('.notification-actions .mark-read-btn');
                    if (markReadBtn) {
                        markReadBtn.style.display = 'none';
                    }

                    // Hide all action buttons in modal
                    const modalMarkReadBtn = document.querySelector('.modal-action-btn.mark-read');
                    if (modalMarkReadBtn) {
                        modalMarkReadBtn.style.display = 'none';
                    }

                    const modalDeleteBtn = document.querySelector('.modal-action-btn.delete-all');
                    if (modalDeleteBtn) {
                        modalDeleteBtn.style.display = 'none';
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
        updateNotificationBadgeImmediate();
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
                markReadBtn.style.display = 'flex';
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
    }

    // Close All Notifications Modal
    function closeAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'none';
    }

    // Show notification details - auto mark as read when clicked
    function showNotificationDetails(notificationId) {
        console.log('Showing details for notification:', notificationId);
        const notificationElements = document.querySelectorAll(`[data-notification-id="${notificationId}"]`);

        // Check if any of the notification instances is unread
        let isUnread = false;
        notificationElements.forEach(element => {
            if (element.classList.contains('unread')) {
                isUnread = true;
            }
        });

        // If unread, mark as read
        if (isUnread) {
            const markReadBtn = notificationElements[0].querySelector('.notification-mark-read-btn');
            markAsReadInModal(notificationId, markReadBtn);
        }
    }

    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        const allNotifModal = document.getElementById('all-notifications-modal');
        if (event.target === allNotifModal) {
            closeAllNotificationsModal();
        }

        const signoutModal = document.getElementById('signout-modal');
        if (event.target === signoutModal) {
            closeSignOutModal();
        }
    });

    // Prevent notification item click from closing modal
    document.addEventListener('DOMContentLoaded', function() {
        // Stop propagation for notification items in modal
        const allNotifsList = document.getElementById('allNotificationsList');
        if (allNotifsList) {
            allNotifsList.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Stop propagation for dropdown
        const dropdown = document.getElementById('notificationDropdown');
        if (dropdown) {
            dropdown.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Request notification permission
        if ('Notification' in window && Notification.permission === 'default') {
            Notification.requestPermission();
        }

        // Check for new notifications every 30 seconds
        setInterval(() => {
            checkNewNotifications();
        }, 30000);
    });
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

    function showSignOutModal() {
        document.getElementById('signout-modal').style.display = 'block';
    }

    function closeSignOutModal() {
        document.getElementById('signout-modal').style.display = 'none';
    }

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
        showNotification('Signing out...', 'info');
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
        }, 500);
    }

    // Quick Button Functions
    function setEmploymentType(value) {
        document.getElementById('employmentType').value = value;
        showNotification(`Employment Type set to ${value}`);
    }

    function setWorkingHours(value) {
        document.getElementById('workingHoursShifts').value = value;
        showNotification(`Working Hours set to ${value}`);
    }

    // Form Validation
    function validateForm() {
        let isValid = true;

        // Application Deadline Validation
        const deadlineInput = document.getElementById('applicationDeadline').value;
        if (deadlineInput) {
            const today = new Date();
            today.setHours(0, 0, 0, 0); // Normalize to midnight
            const selectedDate = new Date(deadlineInput);
            if (selectedDate < today) {
                showNotification('Application Deadline cannot be before today', 'error');
                isValid = false;
            }
        }

        // Salary Range Validation
        const salaryInput = document.getElementById('salaryRange').value;
        if (salaryInput && salaryInput.startsWith('-')) {
            showNotification('Salary Range cannot start with a negative sign', 'error');
            isValid = false;
        }

        if (!isValid) {
            return false; // Prevent form submission
        }

        showNotification('Posting job...', 'info');
        return true;
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