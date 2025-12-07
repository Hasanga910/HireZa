<%--
  Created by IntelliJ IDEA.
  User: dsaje
  Date: 8/17/2025
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company, model.RecruiterActivityLog, java.util.List, model.Recruiter, dao.RecruiterDAO, model.User, dao.UserDAO, dao.JobApplicationDAO, model.JobApplication, dao.JobPostDAO, model.JobPost" %>
<%
    User employer = (User) session.getAttribute("user");
    if (employer == null || !"Employer".equals(employer.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(employer.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Activity - Job Portal</title>
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
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .stat-card h4 {
            margin: 0 0 0.5rem;
            color: #333;
            font-size: 1rem;
        }

        .stat-card p {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
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
            outline_EXTERNALSITE none;
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

        .btn-secondary {
            background-color: #6c757d;
            margin-top: 1.5rem;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .no-activities {
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

            .btn {
                padding: 0.4rem 0.8rem;
                font-size: 0.8rem;
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
        <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">
            <%
                String companyLogo = (company != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/30?text=Logo";
                String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";
            %>
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
<%--            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity"><i class="fas fa-chart-line"></i> <span>Recruiter Activity</span></a></li>--%>

            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity" class="active"><i class="fas fa-tachometer-alt"></i> <span>Recruiter Activity</span></a></li>

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

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="header">
            <h1>Recruiter Activity</h1>
        </div>
        <%
            List<RecruiterActivityLog> activities = (List<RecruiterActivityLog>) request.getAttribute("activities");
            int totalActivities = activities != null ? activities.size() : 0;
            int recentActivities = activities != null ? (int) activities.stream().filter(a -> a.getActionDate().after(new java.util.Date(System.currentTimeMillis() - 7 * 24 * 60 * 60 * 1000L))).count() : 0;
        %>
        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Activities</h4>
                <p><%= totalActivities %></p>
            </div>
            <div class="stat-card">
                <h4>Unique Recruiters</h4>
                <p><%= activities != null ? activities.stream().map(a -> a.getRecruiterId()).distinct().count() : 0 %></p>
            </div>
            <div class="stat-card">
                <h4>Recent Activities (7 days)</h4>
                <p><%= recentActivities %></p>
            </div>
        </div>
        <div class="search-box">
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search by recruiter name...">
        </div>
        <% if (activities == null || activities.isEmpty()) { %>
        <p class="no-activities">No recruiter activities found.</p>
        <% } else { %>
        <table id="activityTable">
            <thead>
            <tr>
                <th>Recruiter Name</th>
                <th>Application ID</th>
                <th>Job Title</th>
                <th>Applicant Name</th>
                <th>Action</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <%
                JobApplicationDAO appDAO = new JobApplicationDAO();
                JobPostDAO jobPostDAO = new JobPostDAO();
                RecruiterDAO recruiterDAO = new RecruiterDAO();
                UserDAO userDAO = new UserDAO();
                for (RecruiterActivityLog activity : activities) {
                    Recruiter recruiter = recruiterDAO.getRecruiterById(activity.getRecruiterId());
                    User recruiterUser = userDAO.getUserById(recruiter != null ? recruiter.getUserId() : null);
                    JobApplication app = appDAO.getApplicationById(activity.getApplicationId());
                    JobPost job = jobPostDAO.getJobPostById(app != null ? app.getJobId() : null);
                    User applicantUser = userDAO.getUserById(app != null ? app.getSeekerId() : null);
            %>
            <tr>
                <td><%= recruiterUser != null ? (recruiterUser.getFullName() != null ? recruiterUser.getFullName() : recruiterUser.getUsername()) : "N/A" %></td>
                <td><%= activity.getApplicationId() %></td>
                <td><%= job != null ? job.getJobTitle() : "N/A" %></td>
                <td><%= applicantUser != null ? (applicantUser.getFullName() != null ? applicantUser.getFullName() : applicantUser.getUsername()) : "N/A" %></td>
                <td><%= activity.getAction() != null ? activity.getAction() : "N/A" %></td>
                <td><%= activity.getActionDate() != null ? activity.getActionDate() : "N/A" %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
        <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn btn-secondary" onclick="showNotification('Returning to Dashboard')"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </main>
</div>

<script>
    // Notification Function
    function showNotification(message) {
        // Create toast notification
        const toast = document.createElement('div');
        toast.className = 'toast-notification';
        toast.textContent = message;
        document.body.appendChild(toast);

        // Remove toast after 3 seconds
        setTimeout(() => {
            toast.remove();
        }, 3000);

        // Browser notification
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

    function filterTable() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.getElementById('activityTable');
        if (table) {
            const tr = table.getElementsByTagName('tr');
            for (let i = 1; i < tr.length; i++) {
                const tdRecruiter = tr[i].getElementsByTagName('td')[0];
                if (tdRecruiter) {
                    tr[i].style.display = tdRecruiter.textContent.toLowerCase().indexOf(filter) > -1 ? '' : 'none';
                }
            }
        }
        showNotification('Filtering table by: ' + (filter || 'empty search'));
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





<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="model.User, dao.CompanyDAO, model.Company, model.RecruiterActivityLog, java.util.List, model.Recruiter, dao.RecruiterDAO, dao.JobApplicationDAO, model.JobApplication, dao.JobPostDAO, model.JobPost" %>--%>
<%--<%--%>
<%--    User employer = (User) session.getAttribute("user");--%>
<%--    if (employer == null || !"Employer".equals(employer.getRole())) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--    CompanyDAO companyDAO = new CompanyDAO();--%>
<%--    Company company = companyDAO.getCompanyByUserId(employer.getId());--%>
<%--    if (company == null) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--    String companyId = company.getCompanyId();--%>
<%--    session.setAttribute("companyId", companyId);--%>
<%--    String companyLogo = (company != null && company.getLogo() != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/150?text=Logo";--%>
<%--    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";--%>

<%--    // Fetch recruiter activities--%>
<%--    dao.RecruiterActivityDAO activityDAO = new dao.RecruiterActivityDAO();--%>
<%--    List<RecruiterActivityLog> activities = activityDAO.getActivitiesByCompanyId(companyId);--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <title>Recruiter Activity - Job Portal</title>--%>
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
<%--            padding: 6rem 2rem 2rem 2rem;--%>
<%--            width: calc(100% - 250px);--%>
<%--            box-sizing: border-box;--%>
<%--            min-height: calc(100vh - 60px);--%>
<%--            transition: margin-left 0.3s ease, width 0.3s ease;--%>
<%--        }--%>

<%--        .main-content.collapsed {--%>
<%--            margin-left: 0;--%>
<%--            width: 100%;--%>
<%--            padding: 6rem 2rem 2rem 2rem;--%>
<%--        }--%>

<%--        .main-content.expanded {--%>
<%--            margin-left: 60px;--%>
<%--            width: calc(100% - 60px);--%>
<%--            padding: 6rem 2rem 2rem 2rem;--%>
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

<%--        /* Table Styles */--%>
<%--        table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            background-color: white;--%>
<%--            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);--%>
<%--            border-radius: 10px;--%>
<%--            overflow: hidden;--%>
<%--        }--%>

<%--        th, td {--%>
<%--            padding: 1rem;--%>
<%--            text-align: left;--%>
<%--            border-bottom: 1px solid #e0e0e0;--%>
<%--        }--%>

<%--        th {--%>
<%--            background-color: #f8f9fa;--%>
<%--            font-weight: 600;--%>
<%--            color: #333;--%>
<%--        }--%>

<%--        tr:hover {--%>
<%--            background-color: #f4f7fa;--%>
<%--        }--%>

<%--        /* Search Bar Styles */--%>
<%--        .search-bar {--%>
<%--            margin-bottom: 1.5rem;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            gap: 1rem;--%>
<%--        }--%>

<%--        .search-bar input {--%>
<%--            padding: 0.75rem;--%>
<%--            border: 1px solid #e0e0e0;--%>
<%--            border-radius: 5px;--%>
<%--            font-size: 0.95rem;--%>
<%--            width: 300px;--%>
<%--        }--%>

<%--        .search-bar input:focus {--%>
<%--            outline: none;--%>
<%--            border-color: #007bff;--%>
<%--            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);--%>
<%--        }--%>

<%--        /* Button Styles */--%>
<%--        .btn {--%>
<%--            background: linear-gradient(135deg, #007bff, #0056b3);--%>
<%--            color: white;--%>
<%--            padding: 0.75rem 1.5rem;--%>
<%--            text-decoration: none;--%>
<%--            border-radius: 5px;--%>
<%--            border: none;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 1rem;--%>
<%--            font-weight: 500;--%>
<%--            transition: all 0.3s ease;--%>
<%--            display: inline-block;--%>
<%--            text-align: center;--%>
<%--        }--%>

<%--        .btn:hover {--%>
<%--            background: linear-gradient(135deg, #0056b3, #004085);--%>
<%--            transform: translateY(-2px);--%>
<%--            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);--%>
<%--        }--%>

<%--        .btn:active {--%>
<%--            transform: translateY(0);--%>
<%--        }--%>

<%--        .btn-secondary {--%>
<%--            background: linear-gradient(135deg, #6c757d, #545b62);--%>
<%--        }--%>

<%--        .btn-secondary:hover {--%>
<%--            background: linear-gradient(135deg, #545b62, #3d4246);--%>
<%--        }--%>

<%--        /* No Data Message */--%>
<%--        .no-data {--%>
<%--            font-size: 1.1rem;--%>
<%--            color: #6c757d;--%>
<%--            text-align: center;--%>
<%--            padding: 2rem;--%>
<%--        }--%>

<%--        /* Responsive Design */--%>
<%--        @media (max-width: 1024px) {--%>
<%--            .sidebar {--%>
<%--                width: 200px;--%>
<%--            }--%>

<%--            .main-content {--%>
<%--                margin-left: 200px;--%>
<%--                width: calc(100% - 200px);--%>
<%--                padding: 6rem 1.5rem 2rem 1.5rem;--%>
<%--            }--%>

<%--            .main-content.expanded {--%>
<%--                margin-left: 60px;--%>
<%--                width: calc(100% - 60px);--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 768px) {--%>
<%--            .container {--%>
<%--                flex-direction: column;--%>
<%--            }--%>

<%--            .navbar {--%>
<%--                flex-direction: row;--%>
<%--                padding: 1rem;--%>
<%--                height: 50px;--%>
<%--            }--%>

<%--            .navbar .logo {--%>
<%--                font-size: 1.4rem;--%>
<%--            }--%>

<%--            .navbar .logo img {--%>
<%--                height: 1.8rem;--%>
<%--            }--%>

<%--            .sidebar {--%>
<%--                width: 100%;--%>
<%--                position: relative;--%>
<%--                top: 0;--%>
<%--                height: auto;--%>
<%--                padding: 1rem;--%>
<%--                transform: none;--%>
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
<%--                padding: 5rem 1rem 1rem 1rem;--%>
<%--                width: 100%;--%>
<%--            }--%>

<%--            .main-content.collapsed,--%>
<%--            .main-content.expanded {--%>
<%--                margin-left: 0;--%>
<%--                width: 100%;--%>
<%--                padding: 5rem 1rem 1rem 1rem;--%>
<%--            }--%>

<%--            table {--%>
<%--                display: block;--%>
<%--                overflow-x: auto;--%>
<%--            }--%>

<%--            th, td {--%>
<%--                min-width: 120px;--%>
<%--            }--%>

<%--            .search-bar input {--%>
<%--                width: 100%;--%>
<%--            }--%>
<%--        }--%>

<%--        @media (max-width: 480px) {--%>
<%--            .navbar {--%>
<%--                flex-direction: column;--%>
<%--                align-items: flex-start;--%>
<%--                height: auto;--%>
<%--                padding: 0.75rem;--%>
<%--            }--%>

<%--            .navbar .logo {--%>
<%--                font-size: 1.3rem;--%>
<%--                margin-bottom: 0.5rem;--%>
<%--            }--%>

<%--            .navbar .logo img {--%>
<%--                height: 1.6rem;--%>
<%--            }--%>

<%--            .navbar .profile-box {--%>
<%--                padding: 0.3rem 0.8rem;--%>
<%--                align-self: flex-end;--%>
<%--            }--%>

<%--            .navbar .profile-box .profile-info span {--%>
<%--                font-size: 0.8rem;--%>
<%--            }--%>

<%--            .header h1 {--%>
<%--                font-size: 1.5rem;--%>
<%--            }--%>

<%--            .btn {--%>
<%--                font-size: 0.9rem;--%>
<%--                padding: 0.65rem 1.25rem;--%>
<%--            }--%>

<%--            .main-content {--%>
<%--                padding: 4rem 0.5rem 0.5rem 0.5rem;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container">--%>
<%--    <nav class="navbar" id="navbar">--%>
<%--        <div class="logo">--%>
<%--            <img src="<%= companyLogo %>" alt="Company Logo">--%>
<%--            <%= companyName %>--%>
<%--        </div>--%>
<%--        <div class="right-section">--%>
<%--            <div class="profile-box">--%>
<%--                <img src="${pageContext.request.contextPath}/images/employer/2.jpg" alt="Profile">--%>
<%--                <div class="profile-info">--%>
<%--                    <span><%= employer.getFullName() != null ? employer.getFullName() : employer.getUsername() %></span>--%>
<%--                    <span>Employer</span>--%>
<%--                </div>--%>
<%--                <div class="dropdown-content">--%>
<%--                    <a href="${pageContext.request.contextPath}/company/profile">Edit Profile</a>--%>
<%--                    <a href="#" onclick="showSignOutModal()">Sign Out</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </nav>--%>
<%--    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>--%>
<%--    <nav class="sidebar" id="sidebar">--%>
<%--        <div class="header">--%>
<%--            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>--%>
<%--        </div>--%>
<%--        <ul>--%>
<%--            <li><a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>--%>
<%--            <li class="group-title">Jobs</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/post-job"><i class="fas fa-briefcase"></i> <span>Post a Job</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/jobs"><i class="fas fa-list"></i> <span>Manage Jobs</span></a></li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity"><i class="fas fa-user-clock"></i> <span>Recruiter Activity</span></a></li>--%>
<%--            <li class="group-title">Profile</li>--%>
<%--            <li><a href="${pageContext.request.contextPath}/company/profile"><i class="fas fa-user-edit"></i> <span>Edit Profile</span></a></li>--%>
<%--            <li class="sign-out">--%>
<%--                <a href="#" onclick="showSignOutModal()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </nav>--%>
<%--    <main class="main-content" id="mainContent">--%>
<%--        <div class="header">--%>
<%--            <h1>Recruiter Activity</h1>--%>
<%--        </div>--%>
<%--        <div class="search-bar">--%>
<%--            <input type="text" id="searchInput" placeholder="Search by recruiter or action..." onkeyup="filterTable()">--%>
<%--        </div>--%>
<%--        <% if (activities == null || activities.isEmpty()) { %>--%>
<%--        <p class="no-data">No recruiter activities found.</p>--%>
<%--        <% } else { %>--%>
<%--        <table id="activityTable">--%>
<%--            <tr>--%>
<%--                <th>Recruiter</th>--%>
<%--                <th>Action</th>--%>
<%--                <th>Application ID</th>--%>
<%--                <th>Action Date</th>--%>
<%--            </tr>--%>
<%--            <%--%>
<%--                RecruiterDAO recruiterDAO = new RecruiterDAO();--%>
<%--                JobApplicationDAO applicationDAO = new JobApplicationDAO();--%>
<%--                JobPostDAO jobPostDAO = new JobPostDAO();--%>
<%--                for (RecruiterActivityLog activity : activities) {--%>
<%--                    Recruiter recruiter = recruiterDAO.getRecruiterById(activity.getRecruiterId());--%>
<%--                    String recruiterName = recruiter != null ? recruiter.getPosition() : "N/A"; // Simplified to avoid redundant call--%>
<%--                    JobApplication jobApplication = applicationDAO.getApplicationById(activity.getApplicationId()); // Renamed variable--%>
<%--                    JobPost job = jobApplication != null ? jobPostDAO.getJobPostById(jobApplication.getJobId()) : null;--%>
<%--                    String actionDescription = activity.getAction();--%>
<%--                    if (job != null) {--%>
<%--                        actionDescription += " (Job: " + job.getJobTitle() + ")";--%>
<%--                    }--%>
<%--            %>--%>
<%--            <tr>--%>
<%--                <td><%= recruiterName %></td>--%>
<%--                <td><%= actionDescription %></td>--%>
<%--                <td><%= activity.getApplicationId() %></td>--%>
<%--                <td><%= activity.getActionDate() %></td>--%>
<%--            </tr>--%>
<%--            <% } %>--%>
<%--        </table>--%>
<%--        <% } %>--%>
<%--        <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>--%>
<%--    </main>--%>
<%--</div>--%>

<%--<!-- Sign-out Modal -->--%>
<%--<div id="signout-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">--%>
<%--    <div style="background: white; width: 300px; margin: 15% auto; padding: 20px; border-radius: 10px; text-align: center;">--%>
<%--        <h2>Confirm Sign Out</h2>--%>
<%--        <p>Are you sure you want to sign out?</p>--%>
<%--        <button class="btn" onclick="signOut()">Yes, Sign Out</button>--%>
<%--        <button class="btn btn-secondary" onclick="closeSignOutModal()">Cancel</button>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
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

<%--    function filterTable() {--%>
<%--        const input = document.getElementById('searchInput');--%>
<%--        const filter = input.value.toLowerCase();--%>
<%--        const table = document.getElementById('activityTable');--%>
<%--        if (table) {--%>
<%--            const tr = table.getElementsByTagName('tr');--%>
<%--            for (let i = 1; i < tr.length; i++) {--%>
<%--                const tdRecruiter = tr[i].getElementsByTagName('td')[0];--%>
<%--                const tdAction = tr[i].getElementsByTagName('td')[1];--%>
<%--                if (tdRecruiter || tdAction) {--%>
<%--                    const recruiterText = tdRecruiter ? tdRecruiter.textContent.toLowerCase() : '';--%>
<%--                    const actionText = tdAction ? tdAction.textContent.toLowerCase() : '';--%>
<%--                    tr[i].style.display = (recruiterText.indexOf(filter) > -1 || actionText.indexOf(filter) > -1) ? '' : 'none';--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>
<%--        showNotification('Filtering table by: ' + (filter || 'empty search'));--%>
<%--    }--%>

<%--    function showSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'block';--%>
<%--        showNotification('Sign out confirmation prompted');--%>
<%--    }--%>

<%--    function closeSignOutModal() {--%>
<%--        document.getElementById('signout-modal').style.display = 'none';--%>
<%--        showNotification('Sign out cancelled');--%>
<%--    }--%>

<%--    function signOut() {--%>
<%--        showNotification('Signing out...');--%>
<%--        setTimeout(() => {--%>
<%--            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';--%>
<%--        }, 500);--%>
<%--    }--%>

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
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
