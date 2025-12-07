<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company" %>
<%@ page import="dao.JobApplicationDAO" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="dao.RecruiterDAO, model.Recruiter" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="model.JobPost" %>
<%@ page import="model.JobApplication" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.NotificationDAO" %>
<%@ page import="model.Notification" %>
<%
    // Get the logged-in user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    // Fetch the Company object for the user
    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(user.getId());
    String companyId = (company != null) ? company.getCompanyId() : "0";

    // Store companyId in session for notification servlet
    session.setAttribute("companyId", companyId);

    String companyLogo = (company != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/30?text=Logo";
    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";

    // Initialize DAOs
    NotificationDAO notifDAO = new NotificationDAO();
    JobPostDAO jobPostDAO = new JobPostDAO();
    JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
    RecruiterDAO recruiterDAO = new RecruiterDAO();

    // Fetch data
    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);
    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);
    int activeJobsCount = jobPostDAO.getActiveJobsCount(companyId);
    int totalApplicationsCount = jobApplicationDAO.getTotalApplicationsCount(companyId);
    List<Recruiter> recruiters = recruiterDAO.getRecruitersByCompanyId(companyId);
    int totalRecruiters = recruiters.size();

    // Fetch recent jobs
    List<JobPost> posts = jobPostDAO.getAllJobPostsByCompanyId(companyId);
    Collections.sort(posts, Comparator.comparing(JobPost::getJobId).reversed());

    // Fetch applications
    List<JobApplication> applications = new ArrayList<>();
    for (JobPost post : posts) {
        List<JobApplication> jobApps = jobApplicationDAO.getApplicationsByJobId(post.getJobId());
        applications.addAll(jobApps);
    }
    Collections.sort(applications, Comparator.comparing(JobApplication::getAppliedAt).reversed());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard - Job Portal</title>
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
            padding: 6rem 2rem 2rem 4rem;
            width: 100%;
        }

        .main-content.expanded {
            margin-left: 60px;
            width: calc(100% - 60px);
            padding-right: 2rem;
            padding-left: 4rem;
        }

        .search-bar {
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            width: 100%;
            max-width: none;
            gap: 0.5rem;
        }

        .search-bar input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        .search-bar input:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        .search-bar .clear-btn {
            background-color: #f4f7fa;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            cursor: pointer;
            color: #666;
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            transition: background-color 0.3s, color 0.3s;
        }

        .search-bar .clear-btn:hover {
            background-color: #007bff;
            color: #ffffff;
        }

        .search-bar .clear-btn i {
            font-size: 0.9rem;
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
        }

        .company-info {
            display: flex;
            align-items: center;
            background-color: #f9fbfc;
            padding: 1rem;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }

        .company-logo img {
            width: 150px;
            height: 150px;
            border-radius: 10px;
            margin-left: 1rem;
            margin-right: 1.5rem;
            object-fit: cover;
            border: 2px solid #007bff;
        }

        .company-details p {
            margin: 0.4rem 0;
            font-size: 1rem;
        }

        .company-details strong {
            color: #555;
        }

        /* Button Group for Post New Job and Manage Recruiters */
        .button-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .post-new-job-card {
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
            font-weight: bold;
            color: #ffffff;
            transition: filter 0.3s;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .post-new-job-card:nth-child(1) {
            background: linear-gradient(135deg, #dc2626, #991b1b);
        }

        .post-new-job-card:nth-child(2) {
            background: linear-gradient(135deg, #14b8a6, #0f766e);
        }

        .post-new-job-card:hover {
            filter: brightness(110%);
            text-decoration: underline;
        }

        .button-icon {
            margin-right: 0.5rem;
            font-size: 1.2rem;
            color: #ffffff;
        }

        /* Quick Stats */
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            visibility: visible;
        }

        .stat-card {
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;
            animation: flashout 0.5s ease-out forwards;
        }

        .stat-card .icon {
            font-size: 2rem;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }

        .stat-card h4 {
            font-size: 1rem;
            margin-bottom: 0.75rem;
            color: #ffffff;
        }

        .stat-card p {
            font-size: 1.8rem;
            font-weight: bold;
            margin: 0;
            color: #ffffff;
        }

        .stat-card:nth-child(1) {
            background: linear-gradient(135deg, #f8961e, #f3722c);
            color: #ffffff;
        }

        .stat-card:nth-child(2) {
            background: linear-gradient(135deg, #9d4edd, #7b2cbf);
            color: #ffffff;
        }

        .stat-card:nth-child(3) {
            background: linear-gradient(135deg, #f72585, #b5179e);
            color: #ffffff;
        }

        @keyframes flashout {
            0% { filter: brightness(100%); }
            50% { filter: brightness(150%); }
            100% { filter: brightness(100%); }
        }

        /* Recent Sections */
        .section {
            background-color: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
            position: relative;
        }

        .section h3 {
            font-size: 1.4rem;
            margin: 0 0 1rem;
            color: #333;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 0.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
            font-size: 0.95rem;
            word-wrap: break-word;
        }

        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #555;
        }

        td {
            color: #666;
        }

        .no-data {
            text-align: center;
            color: #999;
            font-style: italic;
            padding: 1.5rem;
            font-size: 1rem;
        }

        /* View All Button */
        .view-all-btn {
            display: block;
            padding: 0.4rem 1.2rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            text-align: center;
            text-decoration: none;
            width: 120px;
            margin: 1rem auto 0;
            transition: background-color 0.3s;
        }

        .view-all-btn:hover {
            background-color: #0056b3;
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
            background-color: #28a745;  /* GREEN */
            color: white;
            border: 1px solid #28a745;
        }

        .modal-action-btn.mark-read:hover {
            background-color: #218838;  /* Darker GREEN on hover */
            border-color: #1e7e34;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3);
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

            .notification-dropdown {
                width: 350px;
            }

            .quick-stats {
                grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            }

            .button-group {
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
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
                padding: 6rem 2rem 2rem 4rem;
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
                width: 100%;
                padding: 6rem 2rem 2rem 4rem;
            }

            .search-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-bar .clear-btn {
                width: fit-content;
                align-self: flex-end;
            }

            .button-group {
                grid-template-columns: 1fr;
            }

            .post-new-job-card {
                width: 100%;
            }

            .company-info {
                flex-direction: column;
                align-items: flex-start;
            }

            .company-logo img {
                width: 120px;
                height: 120px;
                margin: 0 0 1rem 1rem;
                margin-right: 1.5rem;
            }

            .quick-stats {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9rem;
            }

            th, td {
                padding: 0.5rem;
            }

            .view-all-btn {
                width: 110px;
            }

            .right-section {
                gap: 0.5rem;
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

            .stat-card p {
                font-size: 1.5rem;
            }

            .section h3 {
                font-size: 1.2rem;
            }

            .company-logo img {
                width: 100px;
                height: 100px;
                margin-left: 1rem;
                margin-right: 1.5rem;
            }

            .search-bar {
                width: 100%;
            }

            .post-new-job-card {
                width: 100%;
            }

            .view-all-btn {
                width: 100px;
            }

            .right-section {
                gap: 0.3rem;
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
            <li><a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>            <li class="group-title">Jobs</li>
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
        <!-- Header Section -->
        <div class="header">
            <h1>Welcome, <%= user.getFullName() != null ? user.getFullName() : user.getUsername() %>!</h1>
            <div class="company-info">
                <div class="company-logo">
                    <img src="<%= companyLogo %>" alt="Company Logo">
                </div>
                <div class="company-details">
                    <div style="margin-top: 1.5rem;"></div>
                    <p><strong>Company Name:</strong> <%= companyName %></p>
                    <p><strong>Company Email:</strong> <%= (company != null && company.getCompanyEmail() != null) ? company.getCompanyEmail() : "Not provided" %></p>
                    <p><strong>Company Mobile:</strong> <%= (company != null && company.getContactNumber() != null) ? company.getContactNumber() : "Not provided" %></p>
                    <div style="margin-top: 1rem;"></div>
                    <p><strong>User Name:</strong> <%= user.getFullName() != null ? user.getFullName() : user.getUsername() %></p>
                    <p><strong>Role:</strong> <%= user.getRole() %></p>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <section class="quick-stats">
            <div class="stat-card">
                <div class="icon"><i class="fas fa-briefcase"></i></div>
                <h4>Active Job Posts</h4>
                <p><%= activeJobsCount %></p>
            </div>
            <div class="stat-card">
                <div class="icon"><i class="fas fa-file-alt"></i></div>
                <h4>Total Applications</h4>
                <p><%= totalApplicationsCount %></p>
            </div>
            <div class="stat-card">
                <div class="icon"><i class="fas fa-users"></i></div>
                <h4>Total Recruiters</h4>
                <p><%= totalRecruiters %></p>
            </div>
        </section>

        <!-- Button Group for Post New Job and Manage Recruiters -->
        <section class="button-group">
            <button class="post-new-job-card" onclick="window.location.href='${pageContext.request.contextPath}/company/jobs/post';">
                <i class="fas fa-plus button-icon"></i> Post New Job
            </button>
            <button class="post-new-job-card" onclick="window.location.href='${pageContext.request.contextPath}/Employer/manage_recruiters.jsp';">
                <i class="fas fa-users button-icon"></i> Manage Recruiters
            </button>
        </section>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search jobs, recruiters, or applications..." onkeyup="filterDashboard()">
            <button class="clear-btn" onclick="clearSearch()"><i class="fas fa-times"></i> Clear</button>
        </div>

        <!-- Recent Job Posts -->
        <section class="section">
            <h3>Recent Job Posts</h3>
            <% if (posts.isEmpty()) { %>
            <p class="no-data">No job posts found.</p>
            <% } else { %>
            <table id="jobPostsTable">
                <thead>
                <tr>
                    <th>Job Title</th>
                    <th>Work Mode</th>
                    <th>Location</th>
                    <th>Employment Type</th>
                    <th>Experience Level</th>
                </tr>
                </thead>
                <tbody>
                <% for (int i = 0; i < Math.min(3, posts.size()); i++) {
                    JobPost post = posts.get(i);
                %>
                <tr>
                    <td><%= post.getJobTitle() %></td>
                    <td><%= post.getWorkMode() != null ? post.getWorkMode() : "N/A" %></td>
                    <td><%= post.getLocation() != null ? post.getLocation() : "N/A" %></td>
                    <td><%= post.getEmploymentType() != null ? post.getEmploymentType() : "N/A" %></td>
                    <td><%= post.getExperienceLevel() != null ? post.getExperienceLevel() : "N/A" %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
            <a href="${pageContext.request.contextPath}/company/jobs" class="view-all-btn">Manage Job Posts</a>
        </section>

        <!-- Applications -->
        <section class="section">
            <h3>Recent Applications</h3>
            <% if (applications.isEmpty()) { %>
            <p class="no-data">No applications found.</p>
            <% } else { %>
            <table id="applicationsTable">
                <thead>
                <tr>
                    <th>Application ID</th>
                    <th>Job Title</th>
                    <th>Applicant Name</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <% for (int i = 0; i < Math.min(3, applications.size()); i++) {
                    JobApplication app = applications.get(i);
                    JobPost job = jobPostDAO.getJobPostById(app.getJobId());
                    String jobTitle = (job != null) ? job.getJobTitle() : "N/A";
                %>
                <tr>
                    <td><%= app.getApplicationId() %></td>
                    <td><%= jobTitle %></td>
                    <td><%= app.getFullName() %></td>
                    <td><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(app.getAppliedAt()) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
            <a href="${pageContext.request.contextPath}/company/employer/applications" class="view-all-btn">View More</a>
        </section>
    </main>
</div>

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

<script>
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

        // Disable the button immediately to prevent double-clicks
        if (button) {
            button.disabled = true;
            button.style.opacity = '0.5';
            button.style.cursor = 'not-allowed';
        }

        // Find ALL notification elements with this ID (in dropdown and modal)
        const notificationElements = document.querySelectorAll(`[data-notification-id="${notificationId}"]`);

        // Store original state for rollback
        const originalStates = [];
        notificationElements.forEach(element => {
            const btn = element.querySelector('.notification-mark-read-btn');
            originalStates.push({
                element: element,
                hadUnreadClass: element.classList.contains('unread'),
                button: btn ? btn.cloneNode(true) : null
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
            if (state.button) {
                const existingBtn = state.element.querySelector('.notification-mark-read-btn');
                if (existingBtn) {
                    existingBtn.style.display = 'block';
                    existingBtn.style.opacity = '1';
                    existingBtn.style.visibility = 'visible';
                    existingBtn.disabled = false;
                    existingBtn.style.cursor = 'pointer';
                } else {
                    const content = state.element.querySelector('.notification-content');
                    if (content) {
                        const newButton = state.button.cloneNode(true);
                        newButton.style.opacity = '1';
                        newButton.style.visibility = 'visible';
                        newButton.style.display = 'block';
                        newButton.onclick = function(e) {
                            e.stopPropagation();
                            const notifId = state.element.getAttribute('data-notification-id');
                            markNotificationAsRead(notifId, this, false);
                        };
                        content.appendChild(newButton);
                    }
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

    // Show notification details
    function showNotificationDetails(notificationId) {
        console.log('Showing details for notification:', notificationId);
        const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);
        if (notificationElement && notificationElement.classList.contains('unread')) {
            const markReadBtn = notificationElement.querySelector('.notification-mark-read-btn');
            markAsReadInModal(notificationId, markReadBtn);
        }
    }

    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('all-notifications-modal');
        if (event.target === modal) {
            closeAllNotificationsModal();
        }

        const signoutModal = document.getElementById('signout-modal');
        if (event.target === signoutModal) {
            closeSignOutModal();
        }
    });

    // Existing functions
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

    function filterDashboard() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const jobTable = document.getElementById('jobPostsTable');
        const applicationsTable = document.getElementById('applicationsTable');

        if (jobTable) {
            const jobRows = jobTable.getElementsByTagName('tr');
            for (let i = 1; i < jobRows.length; i++) {
                const jobTitle = jobRows[i].getElementsByTagName('td')[0].textContent.toLowerCase();
                jobRows[i].style.display = jobTitle.includes(input) ? '' : 'none';
            }
        }

        if (applicationsTable) {
            const applicationRows = applicationsTable.getElementsByTagName('tr');
            for (let i = 1; i < applicationRows.length; i++) {
                const applicantName = applicationRows[i].getElementsByTagName('td')[2].textContent.toLowerCase();
                const jobTitle = applicationRows[i].getElementsByTagName('td')[1].textContent.toLowerCase();
                applicationRows[i].style.display = (applicantName.includes(input) || jobTitle.includes(input)) ? '' : 'none';
            }
        }
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

    function clearSearch() {
        const input = document.getElementById('searchInput');
        input.value = '';
        filterDashboard();
    }

    function signOut() {
        showNotification('Signing out...', 'info');
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