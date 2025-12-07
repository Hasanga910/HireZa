<%@ page import="dao.JobSeekerProfileDAO" %>
<%@ page import="model.JobSeekerProfile" %>
<%@ page import="model.User" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get logged-in user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch profile
    JobSeekerProfile profile = null;
    try {
        JobSeekerProfileDAO profileDAO = new JobSeekerProfileDAO();
        profile = profileDAO.getProfileBySeekerId(user.getId());

        // Redirect to complete profile if missing
        if (profile == null
                || profile.getTitle() == null || profile.getTitle().trim().isEmpty()
                || profile.getLocation() == null || profile.getLocation().trim().isEmpty()
                || profile.getAbout() == null || profile.getAbout().trim().isEmpty()) {
            response.sendRedirect("completeProfile.jsp");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% if (request.getParameter("error") != null) { %>
<div class="alert alert-danger"><%= request.getParameter("error") %></div>
<% } %>

<% if (request.getParameter("success") != null) { %>
<div class="alert alert-success"><%= request.getParameter("success") %></div>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professional Profile - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">


    <style>
        .navbar {
            background-color: #e9ecef; /* Example: blue shade */
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }



        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-dark);
        }


        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color:#1e3a8a;
        }

        .nav-link {
            font-weight: 500;
            color: var(--text-dark) !important;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
        }

        .btn-primary {
            background: var(--secondary-color);
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .profile-btn {
            background: var(--secondary-color);
            color: white !important;
            padding: 8px 12px;
            border-radius: 50%;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
        }

        .profile-btn:hover {
            background: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
            color: white !important;
        }
        :root {
            --primary-color: #5b80f3;
            --secondary-color: #00a0dc;
            --accent-color: #f3f2ef;
            --text-dark: #000000de;
            --border-color: #e9ecef;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8f9fa;
            line-height: 1.6;
        }

        .custom-btn {
            border-color: var(--primary-color) !important;
            color: var(--primary-color) !important;
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
        }

        .custom-btn:hover {
            background-color: var(--primary-color) !important;
            color: white !important;
        }

        .profile-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .cover-photo {
            height: 200px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            position: relative;
        }

        .profile-header {
            padding: 0 2rem 2rem;
            position: relative;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            position: absolute;
            top: -75px;
            left: 2rem;
            background: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #666;
        }

        .profile-info {
            margin-left: 180px;
            margin-top: 1rem;
        }

        .profile-name {
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
            color: var(--text-dark);
        }

        .profile-title {
            font-size: 1.2rem;
            color: #666;
            margin: 0.5rem 0;
        }

        .profile-location {
            color: #666;
            margin-bottom: 1rem;
        }

        .btn-prepare-cv {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 0.7rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-prepare-cv:hover {
            background: var(--secondary-color);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,119,181,0.3);
        }

        .analytics-section {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border-color);
        }

        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .analytics-item {
            text-align: center;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
            transition: transform 0.3s ease;
        }

        .analytics-item:hover {
            transform: translateY(-2px);
        }

        .analytics-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
            display: block;
        }

        .section-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }

        .section-header {
            padding: 1.5rem 2rem 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
            color: var(--text-dark);
        }

        .section-content {
            padding: 1.5rem 2rem;
        }

        .experience-item, .education-item {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #f0f0f0;
        }

        .experience-item:last-child, .education-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .item-title {
            font-weight: bold;
            color: var(--text-dark);
            margin-bottom: 0.3rem;
        }

        .item-company {
            color: var(--primary-color);
            font-weight: 500;
            margin-bottom: 0.3rem;
        }

        .item-duration {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .skills-container {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
        }

        .skill-tag {
            background: var(--accent-color);
            color: var(--text-dark);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .skill-tag:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-1px);
        }

        .sidebar {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 1.5rem;
        }

        .people-list {
            list-style: none;
            padding: 0;
        }

        .people-list li {
            padding: 0.8rem 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .people-list li:last-child {
            border-bottom: none;
        }

        .people-list a {
            text-decoration: none;
            color: var(--primary-color);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .people-list a:hover {
            color: var(--secondary-color);
        }

        @media (max-width: 768px) {
            .profile-info {
                margin-left: 0;
                margin-top: 6rem;
                text-align: center;
            }

            .profile-picture {
                left: 50%;
                transform: translateX(-50%);
            }

            .analytics-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/jobseeker/home.jsp">
            <img src="${pageContext.request.contextPath}/jobseeker/logo.jpg" alt="HireZa Logo" width="40" height="40" class="me-2" />
            HireZa
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/Myapplication">My Applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/search-jobs">Search Jobs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/profile.jsp">My Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobseeker/Aboutus.jsp">About Us</a>
                </li>
            </ul>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-primary me-2 custom-btn" href="${pageContext.request.contextPath}/jobseeker/logout">Logout</a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="profile-container">
    <div class="row">
        <div class="col-lg-8">
            <!-- Profile Header Card -->
            <div class="profile-card">
                <div class="cover-photo"></div>
                <div class="profile-header">
                    <div class="profile-picture">
                        <% if(profile != null && profile.getProfilePic() != null && !profile.getProfilePic().isEmpty()) { %>
                        <img src="<%= request.getContextPath() + "/uploads/" + profile.getProfilePic() %>" alt="Profile Picture" class="img-fluid rounded-circle" />
                        <% } else { %>
                        <i class="fas fa-user"></i>
                        <% } %>
                    </div>

                    <div class="profile-info">
                        <%--                        <h1 class="profile-name"><%= user.getFullName() %></h1>--%>
                        <h1 class="profile-name"><%= user != null ? user.getFullName() : "Guest" %></h1>
                        <p class="profile-title"><%= profile.getTitle() %></p>
                        <p class="profile-location">
                            <i class="fas fa-map-marker-alt me-1"></i> <%= profile.getLocation() %>
                        </p>
                        <a href="CV page.jsp" class="btn btn-prepare-cv me-3">
                            <i class="fas fa-file-download me-2"></i>Prepare CV
                        </a>

                        <button type="button" class="btn btn-outline-success"
                                onclick="location.href='<%= request.getContextPath() %>/CompleteProfileServlet'">
                            <i class="fas fa-edit me-2"></i>Edit Profile
                        </button>



                    </div>
                </div>

                <!-- Analytics Section -->
                <div class="analytics-section">
                    <h3 class="section-title mb-3">Profile Analytics</h3>
                    <div class="analytics-grid">
                        <div class="analytics-item">
                            <span class="analytics-number">125</span>
                            <span class="text-muted">Profile Views</span>
                        </div>
                        <div class="analytics-item">
                            <span class="analytics-number">45</span>
                            <span class="text-muted">Search Appearances</span>
                        </div>
                        <div class="analytics-item">
                            <span class="analytics-number">32</span>
                            <span class="text-muted">Post Views</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- About Section -->
            <div class="section-card">
                <div class="section-header">
                    <h3 class="section-title">About</h3>
                </div>
                <div class="section-content">
                    <p><%= profile.getAbout() %></p>
                </div>
            </div>

            <!-- Experience Section -->
            <div class="section-card">
                <div class="section-header">
                    <h3 class="section-title">Experience</h3>
                </div>
                <div class="section-content">
                    <div class="experience-item">


                        <p class="text-muted mb-0"><%= profile.getExperience() %></p>
                    </div>

                </div>
            </div>

            <!-- Education Section -->
            <div class="section-card">
                <div class="section-header">
                    <h3 class="section-title">Education</h3>
                </div>
                <div class="section-content">
                    <div class="education-item">



                        <p class="text-muted mb-0"><%= profile.getEducation() %></p>
                    </div>
                </div>
            </div>

            <!-- Skills Section -->
            <div class="section-card">
                <div class="section-header">
                    <h3 class="section-title">Skills</h3>
                </div>
                <div class="section-content">
                    <div class="skills-container">
                        <%
                            String[] skills = profile.getSkills().split(",");
                            for(String skill : skills) {
                        %>
                        <span class="skill-tag"><%= skill.trim() %></span>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- People Also Viewed -->
            <div class="sidebar">
                <h4 class="mb-3">People Also Viewed</h4>
                <ul class="people-list">
                    <li>
                        <a href="#">
                            <i class="fas fa-user-circle me-2"></i>
                            Jane Smith - Frontend Developer
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-user-circle me-2"></i>
                            Ali Rahman - Mobile App Developer
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-user-circle me-2"></i>
                            Sara Lee - Data Analyst
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-user-circle me-2"></i>
                            Mike Johnson - DevOps Engineer
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Quick Actions -->
            <div class="sidebar mt-4">
                <h4 class="mb-3">Quick Actions</h4>
                <div class="d-grid gap-2">
                    <button class="btn btn-outline-primary" onclick="shareProfile()">
                        <i class="fas fa-share me-2"></i>Share Profile
                    </button>
                    <button type="button" class="btn btn-outline-secondary"
                            onclick="location.href='<%= request.getContextPath() %>/jobseeker/change_password.jsp'">
                        <i class="fas fa-key me-2"></i>Change Password
                    </button>
                    <!-- Edit Profile Button -->
                    <button type="button" class="btn btn-outline-success"
                            onclick="location.href='<%= request.getContextPath() %>/CompleteProfileServlet'">
                        <i class="fas fa-edit me-2"></i>Edit Profile
                    </button>

                    <!-- Delete Account Button -->
                    <button type="button" class="btn btn-outline-danger"
                            onclick="if(confirm('Are you sure you want to delete your account? This action cannot be undone?')) {
                                    location.href='<%= request.getContextPath() %>/DeleteAccountServlet';
                                    }">
                        <i class="fas fa-trash me-2"></i>Delete Account
                    </button>


                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    function prepareCv() {
        // Simulate CV preparation
        const button = document.querySelector('.btn-prepare-cv');
        const originalText = button.innerHTML;

        button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Preparing CV...';
        button.disabled = true;

        setTimeout(() => {
            button.innerHTML = '<i class="fas fa-check me-2"></i>CV Ready!';

            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;

                // Simulate download
                alert('Your professional CV has been prepared and downloaded!');
            }, 2000);
        }, 3000);
    }

    function shareProfile() {
        if (navigator.share) {
            navigator.share({
                title: 'John Doe - Professional Profile',
                text: 'Check out my professional profile on HireZa',
                url: window.location.href
            });
        } else {
            // Fallback for browsers that don't support Web Share API
            navigator.clipboard.writeText(window.location.href);
            alert('Profile link copied to clipboard!');
        }
    }

    function downloadProfile() {
        alert('Profile PDF download started!');
    }

    function addSkill() {
        const skill = prompt('Enter a new skill:');
        if (skill) {
            const skillsContainer = document.querySelector('.skills-container');
            const skillTag = document.createElement('span');
            skillTag.className = 'skill-tag';
            skillTag.textContent = skill;
            skillsContainer.appendChild(skillTag);
        }
    }

    // Add smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
</script>
</body>
</html>