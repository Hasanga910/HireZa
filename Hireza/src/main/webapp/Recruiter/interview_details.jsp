<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="model.User, dao.InterviewDAO, model.Interview, dao.JobPostDAO, model.JobPost" %>--%>
<%--<%--%>
<%--    User user = (User) session.getAttribute("user");--%>
<%--    if (user == null) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--    String interviewIdParam = request.getParameter("interviewId");--%>
<%--    Interview interview = null;--%>
<%--    JobPost job = null;--%>
<%--    if (interviewIdParam != null && !interviewIdParam.isEmpty()) {--%>
<%--        try {--%>
<%--            int interviewId = Integer.parseInt(interviewIdParam);--%>
<%--            InterviewDAO interviewDAO = new InterviewDAO();--%>
<%--            interview = interviewDAO.getInterviewById(interviewId);--%>
<%--            if (interview != null) {--%>
<%--                JobPostDAO jobPostDAO = new JobPostDAO();--%>
<%--                job = jobPostDAO.getJobPostById(interview.getJobId());--%>
<%--            }--%>
<%--        } catch (NumberFormatException e) {--%>
<%--            request.setAttribute("error", "Invalid interview ID format.");--%>
<%--        }--%>
<%--    } else {--%>
<%--        request.setAttribute("error", "Interview ID is missing.");--%>
<%--    }--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Interview Details - Job Portal</title>--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">--%>
<%--    <link rel="icon" type="image/jpeg" href="/HireZa/images/recruiter/2.jpg">--%>
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
<%--            background: linear-gradient(90deg, #007bff, #00c4b4);--%>
<%--            padding: 1rem 2rem;--%>
<%--            position: fixed;--%>
<%--            width: 100%;--%>
<%--            top: 0;--%>
<%--            z-index: 1000;--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            align-items: center;--%>
<%--            box-sizing: border-box;--%>
<%--            height: 60px;--%>
<%--            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);--%>
<%--        }--%>

<%--        .navbar .logo {--%>
<%--            font-size: 1.8rem;--%>
<%--            font-weight: 700;--%>
<%--            color: #ffffff;--%>
<%--            white-space: nowrap;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            transition: opacity 0.3s ease;--%>
<%--        }--%>

<%--        .navbar .logo:hover {--%>
<%--            opacity: 0.9;--%>
<%--        }--%>

<%--        .navbar .logo img {--%>
<%--            height: 2.2rem;--%>
<%--            width: auto;--%>
<%--            margin-right: 0.5rem;--%>
<%--            object-fit: contain;--%>
<%--            vertical-align: middle;--%>
<%--        }--%>

<%--        .navbar .profile-box {--%>
<%--            position: relative;--%>
<%--            cursor: pointer;--%>
<%--            padding: 0.5rem 1rem;--%>
<%--            border-radius: 20px;--%>
<%--            background-color: rgba(255, 255, 255, 0.2);--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            transition: background-color 0.3s ease;--%>
<%--        }--%>

<%--        .navbar .profile-box:hover {--%>
<%--            background-color: rgba(255, 255, 255, 0.3);--%>
<%--        }--%>

<%--        .navbar .profile-box .profile-info span {--%>
<%--            font-size: 0.9rem;--%>
<%--            font-weight: 500;--%>
<%--            color: #ffffff;--%>
<%--            white-space: nowrap;--%>
<%--        }--%>

<%--        .navbar .profile-box .dropdown-content {--%>
<%--            display: none;--%>
<%--            position: absolute;--%>
<%--            background-color: #ffffff;--%>
<%--            min-width: 180px;--%>
<%--            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);--%>
<%--            border-radius: 6px;--%>
<%--            right: 0;--%>
<%--            z-index: 1;--%>
<%--            top: 100%;--%>
<%--            font-size: 0.9rem;--%>
<%--            margin-top: 0.5rem;--%>
<%--            overflow: hidden;--%>
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
<%--            transition: background-color 0.2s ease;--%>
<%--        }--%>

<%--        .navbar .profile-box .dropdown-content a:hover {--%>
<%--            background-color: #e6f0fa;--%>
<%--            color: #007bff;--%>
<%--        }--%>

<%--        /* Sidebar Styles */--%>
<%--        .sidebar {--%>
<%--            width: 250px;--%>
<%--            background-color: #2d3436;--%>
<%--            color: #dfe6e9;--%>
<%--            padding: 1.5rem;--%>
<%--            box-shadow: 2px 0 12px rgba(0, 0, 0, 0.2);--%>
<%--            position: fixed;--%>
<%--            top: 60px;--%>
<%--            height: calc(100vh - 60px);--%>
<%--            z-index: 900;--%>
<%--            transition: transform 0.3s ease;--%>
<%--            display: flex;--%>
<%--            flex-direction: column;--%>
<%--            font-size: 1rem;--%>
<%--            border-right: 1px solid #636e72;--%>
<%--        }--%>

<%--        .sidebar.hidden {--%>
<%--            transform: translateX(-100%);--%>
<%--        }--%>

<%--        .sidebar.collapsed {--%>
<%--            width: 60px;--%>
<%--            padding: 1rem;--%>
<%--        }--%>

<%--        .sidebar.collapsed .group-title,--%>
<%--        .sidebar.collapsed a span {--%>
<%--            display: none;--%>
<%--        }--%>

<%--        .sidebar.collapsed .header {--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--            align-items: center;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--        }--%>

<%--        .sidebar.collapsed a {--%>
<%--            padding: 0.75rem;--%>
<%--            justify-content: center;--%>
<%--        }--%>

<%--        .sidebar.collapsed a i {--%>
<%--            margin: 0;--%>
<%--            font-size: 1.5rem;--%>
<%--        }--%>

<%--        .sidebar .header {--%>
<%--            display: flex;--%>
<%--            justify-content: center;--%>
<%--            align-items: center;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            background: none;--%>
<%--            min-height: 2rem;--%>
<%--        }--%>

<%--        .sidebar .toggle-icon {--%>
<%--            cursor: pointer;--%>
<%--            color: #dfe6e9;--%>
<%--            font-size: 1.4rem;--%>
<%--            transition: transform 0.3s ease, color 0.3s ease;--%>
<%--            line-height: 1.3;--%>
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

<%--        .sidebar a {--%>
<%--            color: #dfe6e9;--%>
<%--            text-decoration: none;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            padding: 0.75rem 1rem;--%>
<%--            border-radius: 6px;--%>
<%--            transition: background-color 0.3s ease, color 0.3s ease;--%>
<%--            font-size: 0.95rem;--%>
<%--            white-space: nowrap;--%>
<%--            background-color: #353b48;--%>
<%--        }--%>

<%--        .sidebar a i {--%>
<%--            margin-right: 0.5rem;--%>
<%--            color: #00c4b4;--%>
<%--        }--%>

<%--        .sidebar a:hover {--%>
<%--            background-color: #00c4b4;--%>
<%--            color: #ffffff;--%>
<%--        }--%>

<%--        .sidebar a:hover i {--%>
<%--            color: #ffffff;--%>
<%--        }--%>

<%--        .sidebar .group-title {--%>
<%--            font-size: 0.85rem;--%>
<%--            color: #b2bec3;--%>
<%--            margin: 1rem 0 0.5rem;--%>
<%--            text-transform: uppercase;--%>
<%--            letter-spacing: 1px;--%>
<%--            line-height: 1.3;--%>
<%--        }--%>

<%--        .sidebar .sign-out {--%>
<%--            margin-top: 0.5rem;--%>
<%--            border-top: 1px solid #636e72;--%>
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
<%--            transition: background-color 0.3s ease;--%>
<%--        }--%>

<%--        .mobile-toggle-btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--        }--%>

<%--        /* Main Content Styles */--%>
<%--        .main-content {--%>
<%--            margin-left: 250px;--%>
<%--            padding: 6rem 2rem 2rem 4rem;--%>
<%--            width: calc(100% - 250px);--%>
<%--            box-sizing: border-box;--%>
<%--            min-height: calc(100vh - 60px);--%>
<%--            transition: margin-left 0.3s ease, width 0.3s ease, padding-right 0.3s ease;--%>
<%--        }--%>

<%--        .main-content.collapsed {--%>
<%--            margin-left: 0;--%>
<%--            padding: 6rem 2rem 2rem 4rem;--%>
<%--            width: 100%;--%>
<%--        }--%>

<%--        .main-content.expanded {--%>
<%--            margin-left: 60px;--%>
<%--            width: calc(100% - 60px);--%>
<%--            padding-right: 2rem;--%>
<%--            padding-left: 4rem;--%>
<%--        }--%>

<%--        .header {--%>
<%--            background-color: white;--%>
<%--            padding: 1.5rem;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);--%>
<%--            margin-bottom: 2rem;--%>
<%--        }--%>

<%--        .header h1 {--%>
<%--            font-size: 1.8rem;--%>
<%--            margin: 0 0 1rem;--%>
<%--            color: #007bff;--%>
<%--            font-weight: 600;--%>
<%--        }--%>

<%--        /* Details Container Styles */--%>
<%--        .details-container {--%>
<%--            background-color: white;--%>
<%--            padding: 2rem;--%>
<%--            border-radius: 10px;--%>
<%--            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);--%>
<%--            margin-bottom: 2rem;--%>
<%--            transition: transform 0.3s ease, box-shadow 0.3s ease;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--        }--%>

<%--        .details-container:hover {--%>
<%--            transform: translateY(-5px);--%>
<%--            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);--%>
<%--        }--%>

<%--        .details-container h2 {--%>
<%--            font-size: 1.5rem;--%>
<%--            margin: 0 0 1.5rem;--%>
<%--            color: #007bff;--%>
<%--            font-weight: 600;--%>
<%--            border-bottom: 2px solid #e6f0fa;--%>
<%--            padding-bottom: 0.5rem;--%>
<%--        }--%>

<%--        .details-container .detail-row {--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            margin-bottom: 1rem;--%>
<%--            padding: 0.5rem 0;--%>
<%--            border-bottom: 1px solid #f1f1f1;--%>
<%--        }--%>

<%--        .details-container .detail-row:last-child {--%>
<%--            border-bottom: none;--%>
<%--        }--%>

<%--        .details-container .detail-label {--%>
<%--            font-weight: 600;--%>
<%--            color: #333;--%>
<%--            width: 30%;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        .details-container .detail-value {--%>
<%--            color: #444;--%>
<%--            width: 65%;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        .details-container .error {--%>
<%--            color: #dc3545;--%>
<%--            font-size: 0.95rem;--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            padding: 0.75rem;--%>
<%--            background-color: #fff5f5;--%>
<%--            border-radius: 5px;--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        /* Button Styles */--%>
<%--        .btn {--%>
<%--            background-color: #007bff;--%>
<%--            color: white;--%>
<%--            padding: 0.75rem 1.5rem;--%>
<%--            text-decoration: none;--%>
<%--            border-radius: 5px;--%>
<%--            border: none;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 1rem;--%>
<%--            transition: background-color 0.3s ease, transform 0.2s ease;--%>
<%--            display: inline-flex;--%>
<%--            align-items: center;--%>
<%--            margin-right: 0.5rem;--%>
<%--            margin-bottom: 0.5rem;--%>
<%--        }--%>

<%--        .btn i {--%>
<%--            margin-right: 0.5rem;--%>
<%--        }--%>

<%--        .btn:hover {--%>
<%--            background-color: #0056b3;--%>
<%--            transform: translateY(-2px);--%>
<%--        }--%>

<%--        .btn-secondary {--%>
<%--            background-color: #6c757d;--%>
<%--        }--%>

<%--        .btn-secondary:hover {--%>
<%--            background-color: #5a6268;--%>
<%--            transform: translateY(-2px);--%>
<%--        }--%>

<%--        .btn-danger {--%>
<%--            background-color: #dc3545;--%>
<%--        }--%>

<%--        .btn-danger:hover {--%>
<%--            background-color: #c82333;--%>
<%--            transform: translateY(-2px);--%>
<%--        }--%>

<%--        /* Responsive Design */--%>
<%--        @media (max-width: 1024px) {--%>
<%--            .sidebar {--%>
<%--                width: 200px;--%>
<%--            }--%>

<%--            .main-content {--%>
<%--                margin-left: 200px;--%>
<%--                width: calc(100% - 200px);--%>
<%--                padding: 6rem 2rem 2rem 4rem;--%>
<%--            }--%>

<%--            .main-content.expanded {--%>
<%--                margin-left: 60px;--%>
<%--                width: calc(100% - 60px);--%>
<%--                padding-right: 2rem;--%>
<%--                padding-left: 4rem;--%>
<%--            }--%>

<%--            .details-container .detail-row {--%>
<%--                flex-direction: column;--%>
<%--            }--%>

<%--            .details-container .detail-label,--%>
<%--            .details-container .detail-value {--%>
<%--                width: 100%;--%>
<%--            }--%>

<%--            .details-container .detail-label {--%>
<%--                margin-bottom: 0.25rem;--%>
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
<%--                padding: 6rem 1.5rem 2rem 1.5rem;--%>
<%--                width: 100%;--%>
<%--            }--%>

<%--            .main-content.collapsed {--%>
<%--                margin-left: 0;--%>
<%--                width: 100%;--%>
<%--                padding: 6rem 1.5rem 2rem 1.5rem;--%>
<%--            }--%>

<%--            .btn {--%>
<%--                width: 100%;--%>
<%--                padding: 0.75rem;--%>
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

<%--            .navbar .profile-box {--%>
<%--                padding: 0.2rem 0.6rem;--%>
<%--                height: 35px;--%>
<%--            }--%>

<%--            .navbar .profile-box .profile-info span {--%>
<%--                font-size: 0.75rem;--%>
<%--            }--%>

<%--            .header h1 {--%>
<%--                font-size: 1.5rem;--%>
<%--            }--%>

<%--            .details-container h2 {--%>
<%--                font-size: 1.3rem;--%>
<%--            }--%>

<%--            .btn {--%>
<%--                font-size: 0.9rem;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <!-- Navbar -->--%>
<%--    <nav class="navbar" id="navbar">--%>
<%--        <div class="logo">--%>
<%--            <img src="/HireZa/images/recruiter/1.jpg" alt="HireZa Logo">--%>
<%--            HireZa--%>
<%--        </div>--%>
<%--        <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">--%>
<%--            <div class="profile-info">--%>
<%--                <span><%= user.getFullName() != null ? user.getFullName() : user.getUsername() %></span>--%>
<%--            </div>--%>
<%--            <div class="dropdown-content">--%>
<%--                <a href="${pageContext.request.contextPath}/recruiter/profile">Edit Profile</a>--%>
<%--                <a href="#" onclick="signOut()">Sign Out</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </nav>--%>

<%--    <!-- Toggle Button for Sidebar (Mobile) -->--%>
<%--    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>--%>

<%--    <!-- Sidebar -->--%>
<%--    <nav class="sidebar" id="sidebar">--%>
<%--        <div class="header">--%>
<%--            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>--%>
<%--        </div>--%>
<%--        <ul>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Recruiter/recruiter_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>--%>
<%--            <li class="group-title">Jobs</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Recruiter/select_job.jsp"><i class="fas fa-briefcase"></i> <span>Select Job</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp"><i class="fas fa-calendar-alt"></i> <span>Interviews</span></a></li>--%>
<%--            <li class="group-title">Profile</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/recruiter/profile"><i class="fas fa-user-edit"></i> <span>Edit Profile</span></a></li>--%>
<%--            <li class="sign-out">--%>
<%--                <a href="#" onclick="signOut()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </nav>--%>

<%--    <!-- Main Content -->--%>
<%--    <main class="main-content" id="mainContent">--%>
<%--        <div class="header">--%>
<%--            <h1>Interview Details</h1>--%>
<%--        </div>--%>
<%--        <div class="details-container">--%>
<%--            <% if (request.getAttribute("error") != null) { %>--%>
<%--            <p class="error"><%= request.getAttribute("error") %></p>--%>
<%--            <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>--%>
<%--            <% } else if (interview == null) { %>--%>
<%--            <p class="error">No interview found.</p>--%>
<%--            <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>--%>
<%--            <% } else { %>--%>
<%--            <h2>Interview #<%= interview.getInterviewId() %></h2>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Job Title:</span>--%>
<%--                <span class="detail-value"><%= job != null ? job.getJobTitle() : "N/A" %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Interviewer:</span>--%>
<%--                <span class="detail-value"><%= interview.getInterviewer() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Mode:</span>--%>
<%--                <span class="detail-value"><%= interview.getMode() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Location:</span>--%>
<%--                <span class="detail-value"><%= interview.getLocation() != null ? interview.getLocation() : "N/A" %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Scheduled At:</span>--%>
<%--                <span class="detail-value"><%= interview.getScheduledAt() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Duration:</span>--%>
<%--                <span class="detail-value"><%= interview.getDurationMinutes() %> minutes</span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Notes:</span>--%>
<%--                <span class="detail-value"><%= interview.getNotes() != null ? interview.getNotes() : "None" %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Status:</span>--%>
<%--                <span class="detail-value"><%= interview.getStatus() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Created At:</span>--%>
<%--                <span class="detail-value"><%= interview.getCreatedAt() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <span class="detail-label">Updated At:</span>--%>
<%--                <span class="detail-value"><%= interview.getUpdatedAt() %></span>--%>
<%--            </div>--%>
<%--            <div class="detail-row">--%>
<%--                <a href="${pageContext.request.contextPath}/Recruiter/edit_interview.jsp?interviewId=<%= interview.getInterviewId() %>" class="btn"><i class="fas fa-edit"></i> Edit Interview</a>--%>
<%--                <a href="${pageContext.request.contextPath}/DeleteInterviewServlet?interviewId=<%= interview.getInterviewId() %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this interview?')"><i class="fas fa-trash"></i> Delete Interview</a>--%>
<%--                <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>--%>
<%--            </div>--%>
<%--            <% } %>--%>
<%--        </div>--%>
<%--    </main>--%>
<%--</div>--%>
<%--<script>--%>
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
<%--        window.location.href = '${pageContext.request.contextPath}/logout';--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.InterviewDAO, model.Interview, dao.JobPostDAO, model.JobPost" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    String interviewIdParam = request.getParameter("interviewId");
    Interview interview = null;
    JobPost job = null;

    if (interviewIdParam != null && !interviewIdParam.isEmpty()) {
        try {
            InterviewDAO interviewDAO = new InterviewDAO();
            interview = interviewDAO.getInterviewById(interviewIdParam);

            if (interview != null) {
                JobPostDAO jobPostDAO = new JobPostDAO();
                job = jobPostDAO.getJobPostById(interview.getJobId());
            } else {
                request.setAttribute("error", "Interview not found with ID: " + interviewIdParam);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error loading interview: " + e.getMessage());
            e.printStackTrace();
        }
    } else {
        request.setAttribute("error", "Interview ID is missing.");
    }
%>
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interview Details - Job Portal</title>
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

        /* Details Container Styles */
        .details-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e0e0e0;
        }

        .details-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .details-container h2 {
            font-size: 1.5rem;
            margin: 0 0 1.5rem;
            color: #007bff;
            font-weight: 600;
            border-bottom: 2px solid #e6f0fa;
            padding-bottom: 0.5rem;
        }

        .details-container .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid #f1f1f1;
        }

        .details-container .detail-row:last-child {
            border-bottom: none;
        }

        .details-container .detail-label {
            font-weight: 600;
            color: #333;
            width: 30%;
            font-size: 0.95rem;
        }

        .details-container .detail-value {
            color: #444;
            width: 65%;
            font-size: 0.95rem;
        }

        .details-container .error {
            color: #dc3545;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            padding: 0.75rem;
            background-color: #fff5f5;
            border-radius: 5px;
            text-align: center;
        }

        /* Button Styles */
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
            display: inline-flex;
            align-items: center;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .btn i {
            margin-right: 0.5rem;
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

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
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

            .details-container .detail-row {
                flex-direction: column;
            }

            .details-container .detail-label,
            .details-container .detail-value {
                width: 100%;
            }

            .details-container .detail-label {
                margin-bottom: 0.25rem;
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
                padding: 6rem 1.5rem 2rem 1.5rem;
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
                width: 100%;
                padding: 6rem 1.5rem 2rem 1.5rem;
            }

            .btn {
                width: 100%;
                padding: 0.75rem;
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

            .navbar .profile-box {
                padding: 0.2rem 0.6rem;
                height: 35px;
            }

            .navbar .profile-box .profile-info span {
                font-size: 0.75rem;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .details-container h2 {
                font-size: 1.3rem;
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
        <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">
            <div class="profile-info">
                <span><%= user.getFullName() != null ? user.getFullName() : user.getUsername() %></span>
            </div>
            <div class="dropdown-content">
                <a href="${pageContext.request.contextPath}/recruiter/profile">Edit Profile</a>
                <a href="#" onclick="signOut()">Sign Out</a>
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
            <h1>Interview Details</h1>
        </div>
        <div class="details-container">
            <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
            <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>
            <% } else if (interview == null) { %>
            <p class="error">No interview found.</p>
            <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>
            <% } else { %>
            <h2>Interview #<%= interview.getInterviewId() %></h2>
            <div class="detail-row">
                <span class="detail-label">Job Title:</span>
                <span class="detail-value"><%= job != null ? job.getJobTitle() : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Interviewer:</span>
                <span class="detail-value"><%= interview.getInterviewer() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Mode:</span>
                <span class="detail-value"><%= interview.getMode() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Location:</span>
                <span class="detail-value"><%= interview.getLocation() != null ? interview.getLocation() : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Scheduled At:</span>
                <span class="detail-value"><%= interview.getScheduledAt() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Duration:</span>
                <span class="detail-value"><%= interview.getDurationMinutes() %> minutes</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Notes:</span>
                <span class="detail-value"><%= interview.getNotes() != null ? interview.getNotes() : "None" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Status:</span>
                <span class="detail-value"><%= interview.getStatus() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Created At:</span>
                <span class="detail-value"><%= interview.getCreatedAt() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Updated At:</span>
                <span class="detail-value"><%= interview.getUpdatedAt() %></span>
            </div>
            <div class="detail-row">
                <a href="${pageContext.request.contextPath}/Recruiter/edit_interview.jsp?interviewId=<%= interview.getInterviewId() %>" class="btn"><i class="fas fa-edit"></i> Edit Interview</a>
                <a href="${pageContext.request.contextPath}/DeleteInterviewServlet?interviewId=<%= interview.getInterviewId() %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this interview?')"><i class="fas fa-trash"></i> Delete Interview</a>
                <a href="${pageContext.request.contextPath}/Recruiter/interviews.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Interviews</a>
            </div>
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
</script>
</body>
</html>