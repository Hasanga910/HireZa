<%@ page import="java.util.List" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="model.JobPost" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.JobPostDAO" %>
<%@ page import="dao.CompanyDAO" %>
<%@ page import="dao.UserDAO" %>

<%
    JobPostDAO jobDAO = new JobPostDAO();
    CompanyDAO companyDAO = new CompanyDAO();
    UserDAO userDAO = new UserDAO();

    int jobsCount = jobDAO.getJobsCount();
    int companiesCount = companyDAO.getCompaniesCount();
    int jobSeekersCount = userDAO.getJobSeekersCount();

%>

<%
    JobPostDAO jobPostDAO = new JobPostDAO();
    // Get only approved jobs (you can also create a getFeaturedJobs() if needed)
    List<JobPost> featuredJobs = jobPostDAO.getApprovedJobPosts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        .navbar {
            background-color: #e9ecef;
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
            --primary-color: #007bff;
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

        /* Home Page Specific Styles */
        .hero-section {
            background: linear-gradient(135deg, rgba(0, 123, 255, 0.85), rgba(0, 160, 220, 0.85)),
            url('https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            padding: 5rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .hero-section .container {
            position: relative;
            z-index: 2;
        }

        .hero-section h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            animation: fadeInUp 1s ease-out;
        }

        .hero-section p {
            font-size: 1.3rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            animation: fadeInUp 1s ease-out 0.3s both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .hero-floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
            overflow: hidden;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.1);
            font-size: 2rem;
            animation: float 6s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) { top: 20%; left: 10%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 60%; left: 80%; animation-delay: 2s; }
        .floating-icon:nth-child(3) { top: 30%; left: 85%; animation-delay: 4s; }
        .floating-icon:nth-child(4) { top: 70%; left: 15%; animation-delay: 1s; }
        .floating-icon:nth-child(5) { top: 40%; left: 5%; animation-delay: 3s; }

        .search-box {
            max-width: 650px;
            margin: 0 auto;
            position: relative;
            animation: fadeInUp 1s ease-out 0.6s both;
        }

        .search-box input {
            border-radius: 50px;
            padding: 18px 60px 18px 25px;
            border: none;
            font-size: 1.1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            outline: none;
        }

        .search-btn {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            background: var(--primary-color);
            border: none;
            border-radius: 50%;
            width: 45px;
            height: 45px;
            color: white;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-50%) scale(1.1);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .content-section {
            padding: 3rem 0;
        }

        .job-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.08);
            position: relative;
            overflow: hidden;
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .job-card:hover::before {
            left: 100%;
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            border-color: var(--primary-color);
        }

        .company-logo {
            width: 50px;
            height: 50px;
            background: var(--accent-color);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .job-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .job-meta {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .job-salary {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.95rem;
        }

        .stats-section {
            background: white;
            border-radius: 15px;
            padding: 2.5rem;
            margin: 2rem 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            position: relative;
            overflow: hidden;
        }

        .stats-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--primary-color);
            transition: color 0.3s ease;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .stat-item:hover .stat-number {
            color: var(--secondary-color);
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Sidebar Styling */
        .sidebar-section {
            position: sticky;
            top: 20px;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 3px solid var(--primary-color);
        }

        /* Updated Category Card Styles */
        .category-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            border: 1px solid rgba(0,0,0,0.08);
            position: relative;
            overflow: hidden;
            height: 160px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-bottom: 1rem;
        }

        .category-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            opacity: 0.08;
            transition: opacity 0.3s ease;
            z-index: 1;
        }

        .category-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 2;
        }

        .category-card:hover::before {
            opacity: 0.12;
        }

        .category-card:hover::after {
            opacity: 0.05;
        }

        /* Background images for each category */
        .category-card.it-software::before {
            background-image: url('https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80');
        }

        .category-card.marketing::before {
            background-image: url('https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80');
        }

        .category-card.finance::before {
            background-image: url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80');
        }

        .category-card.hr::before {
            background-image: url('https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80');
        }

        .category-card:hover {
            transform: translateY(-8px);
            color: inherit;
            text-decoration: none;
            border-color: var(--primary-color);
            box-shadow: 0 12px 28px rgba(0,0,0,0.15);
        }

        .category-content {
            position: relative;
            z-index: 3;
        }

        .category-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 0.75rem;
            transition: all 0.3s ease;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .category-card:hover .category-icon {
            transform: scale(1.15);
            color: var(--secondary-color);
            filter: drop-shadow(0 4px 8px rgba(0,0,0,0.2));
        }

        .category-card h5 {
            font-weight: 600;
            margin-bottom: 0.4rem;
            font-size: 1.1rem;
            text-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        .category-card p {
            font-size: 0.85rem;
            opacity: 0.75;
            margin-bottom: 0;
            text-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        /* Professional LinkedIn-style Apply Button */
        .apply-btn {
            background: #0a66c2;
            color: white;
            border: 1px solid #0a66c2;
            padding: 8px 20px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .apply-btn:hover {
            background: #004182;
            border-color: #004182;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(10, 102, 194, 0.3);
            color: white;
        }

        .apply-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 6px rgba(10, 102, 194, 0.3);
        }

        .badge {
            padding: 0.4rem 0.8rem;
            font-size: 0.8rem;
            font-weight: 600;
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

<!-- Hero Section -->
<section class="hero-section">
    <div class="hero-floating-elements">
        <i class="floating-icon fas fa-briefcase"></i>
        <i class="floating-icon fas fa-chart-line"></i>
        <i class="floating-icon fas fa-users"></i>
        <i class="floating-icon fas fa-building"></i>
        <i class="floating-icon fas fa-graduation-cap"></i>
    </div>
    <div class="container">
        <h1>Find Your Dream Job</h1>
        <p>Connect with top employers and discover career opportunities that match your skills</p>
        <div class="search-box">
            <input type="text" class="form-control" placeholder="Search for jobs, companies, or keywords..." id="heroSearch">
            <button class="search-btn" type="button" onclick="performSearch()">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>
</section>

<!-- Stats Section -->
<div class="container">
    <div class="stats-section">
        <div class="row">
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-number"><%= jobsCount %>+</div>
                    <div class="stat-label">Jobs Available</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-number"><%= companiesCount %>+</div>
                    <div class="stat-label">Companies</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-number"><%= jobSeekersCount %>+</div>
                    <div class="stat-label">Job Seekers</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-number">5+</div>
                    <div class="stat-label">Successful Hires</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Main Content Section with Sidebar -->
<section class="content-section">
    <div class="container">
        <div class="row">
            <!-- Featured Jobs Section - Left Side (8 columns) -->
            <div class="col-lg-8 mb-4">
                <h2 class="section-title">Featured Jobs</h2>

                <%
                    if (featuredJobs != null && !featuredJobs.isEmpty()) {
                        for (JobPost job : featuredJobs) {
                %>
                <div class="job-card">
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <div class="company-logo">
                                <%= job.getCompanyName().substring(0,2).toUpperCase() %>
                            </div>
                        </div>
                        <div class="col">
                            <div class="job-title"><%= job.getJobTitle() %></div>
                            <div class="job-meta">
                                <i class="fas fa-building me-1"></i><%= job.getCompanyName() %>
                                <i class="fas fa-map-marker-alt ms-3 me-1"></i><%= job.getLocation() %>
                            </div>
                            <div class="job-salary">
                                <%= (job.getSalaryRange() != null && !job.getSalaryRange().isEmpty()) ? job.getSalaryRange() : "Not disclosed" %>
                            </div>
                        </div>
                        <div class="col-auto">
                            <a href="<%= request.getContextPath() %>/jobseeker/Jobdetails.jsp?jobId=<%= job.getId() %>" class="apply-btn btn btn-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>
                                View Details
                            </a>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No featured jobs available right now. Check back soon!
                </div>
                <%
                    }
                %>
            </div>

            <!-- Popular Categories Sidebar - Right Side (4 columns) -->
            <div class="col-lg-4">
                <div class="sidebar-section">
                    <h3 class="section-title">Popular Categories</h3>

                    <a href="#" class="category-card it-software d-block">
                        <div class="category-content">
                            <div class="category-icon">
                                <i class="fas fa-code"></i>
                            </div>
                            <h5>IT & Software</h5>
                            <p class="text-muted">450 Jobs Available</p>
                        </div>
                    </a>

                    <a href="#" class="category-card marketing d-block">
                        <div class="category-content">
                            <div class="category-icon">
                                <i class="fas fa-bullhorn"></i>
                            </div>
                            <h5>Marketing</h5>
                            <p class="text-muted">230 Jobs Available</p>
                        </div>
                    </a>

                    <a href="#" class="category-card finance d-block">
                        <div class="category-content">
                            <div class="category-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <h5>Finance</h5>
                            <p class="text-muted">180 Jobs Available</p>
                        </div>
                    </a>

                    <a href="#" class="category-card hr d-block">
                        <div class="category-content">
                            <div class="category-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h5>Human Resources</h5>
                            <p class="text-muted">125 Jobs Available</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    function performSearch() {
        var searchQuery = document.getElementById('heroSearch').value;
        if (searchQuery.trim() !== '') {
            window.location.href = '${pageContext.request.contextPath}/search-jobs?q=' + encodeURIComponent(searchQuery);
        }
    }

    document.getElementById('heroSearch').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
</script>

</body>
</html>


