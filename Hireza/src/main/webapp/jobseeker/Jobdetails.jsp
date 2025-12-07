<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.JobPost, dao.JobPostDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobPost, dao.JobPostDAO" %>
<meta charset="UTF-8">

<%
    String jobIdParam = request.getParameter("jobId");
    JobPost job = null;

    if (jobIdParam != null && !jobIdParam.trim().isEmpty()) {
        try {
            JobPostDAO dao = new JobPostDAO();
            job = dao.getJobPostById(jobIdParam); // Pass jobId as String
        } catch (Exception e) {
            out.println("<p>Error fetching job post: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Job ID not provided!</p>");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${job.title} - ${job.company} | Jobs Portal</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
            color: #1a1a1a;
            line-height: 1.6;
            min-height: 100vh;
        }

        /* Professional Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(37, 99, 235, 0.1);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 20px rgba(37, 99, 235, 0.08);
            transition: all 0.3s ease;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }

        .back-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0.75rem;
            border-radius: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 0.875rem;
            position: relative;
            overflow: hidden;
        }

        .back-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.1), transparent);
            transition: left 0.6s ease;
        }

        .back-link:hover::before {
            left: 100%;
        }

        .back-link:hover {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            color: #1d4ed8;
            transform: translateX(-2px);
        }

        .logo {
            font-size: 1.25rem;
            font-weight: 600;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.025em;
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Job Header - Clean and Professional */
        .job-header {
            background: linear-gradient(135deg, #ffffff 0%, #f8faff 100%);
            border: 1px solid rgba(37, 99, 235, 0.15);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(37, 99, 235, 0.12);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .job-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #2563eb, #3b82f6, #60a5fa);
            background-size: 200% 100%;
            animation: shimmer 3s linear infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        .job-header:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(37, 99, 235, 0.16);
        }

        .company-section {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .company-logo {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border: 2px solid rgba(37, 99, 235, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.125rem;
            font-weight: 600;
            color: #2563eb;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .company-logo:hover {
            transform: scale(1.05) rotate(2deg);
            background: linear-gradient(135deg, #bfdbfe, #93c5fd);
            border-color: rgba(37, 99, 235, 0.4);
        }

        .company-info h2 {
            font-size: 1.125rem;
            margin-bottom: 0.25rem;
            font-weight: 600;
            color: #1e40af;
            transition: color 0.3s ease;
            cursor: pointer;
        }

        .company-info h2:hover {
            color: #2563eb;
        }

        .job-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            line-height: 1.2;
            color: #0f172a;
            letter-spacing: -0.025em;
        }

        .job-meta {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #64748b;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .meta-item i {
            color: #94a3b8;
            font-size: 0.875rem;
        }

        /* Action Section - Professional Layout */
        .action-section {
            background: #ffffff;
            border: 1px solid #e1e5e9;
            border-radius: 12px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            padding: 0.625rem 1.25rem;
            border: none;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            height: 40px;
            white-space: nowrap;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: white;
            border: 1px solid #2563eb;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            border-color: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #ffffff, #f8faff);
            color: #2563eb;
            border: 1px solid rgba(37, 99, 235, 0.3);
            box-shadow: 0 2px 8px rgba(37, 99, 235, 0.1);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border-color: rgba(37, 99, 235, 0.5);
            color: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(37, 99, 235, 0.2);
        }

        .btn-outline {
            background: rgba(255, 255, 255, 0.8);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
            backdrop-filter: blur(10px);
        }

        .btn-outline:hover {
            background: rgba(59, 130, 246, 0.1);
            color: #2563eb;
            border-color: rgba(37, 99, 235, 0.5);
            transform: translateY(-2px);
        }

        .salary-info {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border: 1px solid rgba(37, 99, 235, 0.2);
            color: #1e40af;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            text-align: right;
            min-width: 140px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .salary-info:hover {
            background: linear-gradient(135deg, #bfdbfe, #93c5fd);
            border-color: rgba(37, 99, 235, 0.4);
            transform: scale(1.02);
        }

        .salary-amount {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0.125rem;
            color: #1e40af;
        }

        .salary-period {
            font-size: 0.75rem;
            color: #3b82f6;
            font-weight: 500;
        }

        /* Content Layout */
        .content-wrapper {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 2rem;
        }

        /* Job Details Grid - Clean Professional Style */
        .job-details-grid {
            background: linear-gradient(135deg, #ffffff 0%, #f8faff 100%);
            border: 1px solid rgba(37, 99, 235, 0.15);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(37, 99, 235, 0.08);
            transition: all 0.3s ease;
        }

        .job-details-grid:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(37, 99, 235, 0.12);
        }

        .details-title {
            font-size: 1rem;
            font-weight: 600;
            color: #1e40af;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .details-title i {
            color: #3b82f6;
            font-size: 0.875rem;
        }

        .details-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 0.75rem;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(37, 99, 235, 0.1);
            transition: all 0.3s ease;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-item:hover {
            background: rgba(37, 99, 235, 0.03);
            border-radius: 8px;
            padding-left: 0.5rem;
            padding-right: 0.5rem;
        }

        .detail-label {
            font-size: 0.875rem;
            color: #64748b;
            font-weight: 500;
        }

        .detail-value {
            font-size: 0.875rem;
            color: #1e293b;
            font-weight: 600;
        }

        /* Section Styling - Professional */
        .section {
            background: linear-gradient(135deg, #ffffff 0%, #f8faff 100%);
            border: 1px solid rgba(37, 99, 235, 0.15);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(37, 99, 235, 0.08);
            transition: all 0.3s ease;
        }

        .section:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(37, 99, 235, 0.12);
        }

        .section-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            color: #2563eb;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .section-title:hover .section-icon {
            transform: rotate(5deg) scale(1.1);
            background: linear-gradient(135deg, #bfdbfe, #93c5fd);
        }

        .section-content {
            font-size: 0.9375rem;
            line-height: 1.6;
            color: #475569;
            margin-bottom: 1rem;
        }

        /* Skills - Professional Tags */
        .skills-container {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .skill-tag {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            color: #1e40af;
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8125rem;
            font-weight: 500;
            border: 1px solid rgba(37, 99, 235, 0.2);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .skill-tag::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s ease;
        }

        .skill-tag:hover::before {
            left: 100%;
        }

        .skill-tag:hover {
            background: linear-gradient(135deg, #bfdbfe, #93c5fd);
            color: #1d4ed8;
            transform: translateY(-2px) scale(1.05);
            border-color: rgba(37, 99, 235, 0.4);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        /* Sidebar */
        .sidebar {
            /* Sidebar content */
        }

        .company-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8faff 100%);
            border: 1px solid rgba(37, 99, 235, 0.15);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(37, 99, 235, 0.08);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .company-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(37, 99, 235, 0.15);
        }

        .company-avatar {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            border: 2px solid rgba(37, 99, 235, 0.2);
            color: #2563eb;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0 auto 1rem;
            transition: all 0.3s ease;
        }

        .company-card:hover .company-avatar {
            transform: scale(1.1) rotate(5deg);
            background: linear-gradient(135deg, #bfdbfe, #93c5fd);
        }

        .company-name {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .company-description {
            font-size: 0.875rem;
            color: #64748b;
        }

        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
            border: 1px solid rgba(16, 185, 129, 0.3);
            padding: 0.5rem 0.875rem;
            border-radius: 20px;
            font-size: 0.8125rem;
            font-weight: 500;
            margin-top: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .status-indicator:hover {
            background: linear-gradient(135deg, #a7f3d0, #6ee7b7);
            transform: scale(1.05);
        }

        .status-dot {
            width: 6px;
            height: 6px;
            background: #10b981;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.2); }
            100% { opacity: 1; transform: scale(1); }
        }
        width: 6px;
        height: 6px;
        background: #16a34a;
        border-radius: 50%;
        }

        .application-info {
            background: #fef3c7;
            border: 1px solid #f59e0b;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
        }

        .application-deadline {
            font-size: 0.875rem;
            color: #92400e;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .content-wrapper {
                grid-template-columns: 1fr;
            }

            .sidebar {
                order: -1;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .job-header,
            .action-section,
            .section {
                padding: 1.5rem;
            }

            .job-title {
                font-size: 1.5rem;
            }

            .action-section {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }

            .action-buttons {
                justify-content: center;
                flex-wrap: wrap;
            }

            .salary-info {
                text-align: center;
                min-width: auto;
            }

            .job-meta {
                gap: 1rem;
            }
        }

        @media (max-width: 480px) {
            .job-meta {
                flex-direction: column;
                gap: 0.5rem;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Job Header -->
    <div class="job-header">
        <div class="company-section">
            <div class="company-logo">
                <%
                    if (job.getCompanyName() != null && !job.getCompanyName().isEmpty()) {
                        out.print(job.getCompanyName().substring(0, 1).toUpperCase());
                    }
                %>
            </div>
            <div class="company-info">
                <h2><%= job.getCompanyName() %></h2>
            </div>
        </div>

        <h1 class="job-title"><%= job.getJobTitle() %></h1>

        <div class="job-meta">
            <div class="meta-item">
                <i class="fas fa-map-marker-alt"></i>
                <span><%= job.getLocation() %></span>
            </div>
            <div class="meta-item">
                <i class="fas fa-briefcase"></i>
                <span><%= job.getWorkMode() %></span>
            </div>
            <div class="meta-item">
                <i class="fas fa-clock"></i>
                <span><%= job.getWorkMode() %></span>
            </div>
        </div>
    </div>

    <!-- Action Section -->
    <div class="action-section">
        <div class="action-buttons">
            <form action="<%= request.getContextPath() %>/jobseeker/Applynow.jsp" method="get" style="display:inline;">
                <input type="hidden" name="jobId" value="<%= job.getJobId() %>" />
                <button type="submit" class="btn btn-primary apply-btn">
                    <i class="fas fa-paper-plane"></i>
                    Apply Now
                </button>
            </form>

            <button class="btn btn-secondary" onclick="saveJob(${job.id})">
                <i class="fas fa-bookmark"></i>
                Save Job
            </button>
            <button class="btn btn-outline" onclick="shareJob(${job.id})">
                <i class="fas fa-share"></i>
                Share
            </button>
        </div>
        <div class="salary-info">
            <div class="salary-amount">
                <%
                    if (job != null && job.getSalaryRange() != null && !job.getSalaryRange().isEmpty()) {
                        try {
                            double salary = Double.parseDouble(job.getSalaryRange());
                            java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
                            out.print(nf.format(salary));
                        } catch (NumberFormatException e) {
                            out.print(job.getSalaryRange());
                        }
                    } else {
                        out.print("N/A");
                    }
                %>
            </div>
            <div class="salary-period">per month</div>
        </div>
    </div>

    <div class="content-wrapper">
        <!-- Main Content -->
        <div class="main-content">
            <!-- Job Details -->
            <div class="job-details-grid">
                <h3 class="details-title">
                    <i class="fas fa-info-circle"></i>
                    Job Information
                </h3>
                <div class="details-grid">
                    <div class="detail-item">
                        <span class="detail-label">Experience Level</span>
                        <span class="detail-value"><%= job.getExperienceLevel() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Work Hours</span>
                        <span class="detail-value"><%= job.getWorkingHoursShifts() %> hours/day</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Application Deadline</span>
                        <span class="detail-value">
                                <%
                                    if (job.getApplicationDeadline() != null) {
                                        out.print(new java.text.SimpleDateFormat("MMM d, yyyy").format(job.getApplicationDeadline()));
                                    } else {
                                        out.print("Not specified");
                                    }
                                %>
                            </span>
                    </div>
                </div>
            </div>

            <!-- Job Description -->
            <div class="section">
                <h2 class="section-title">
                    <div class="section-icon">
                        <i class="fas fa-file-text"></i>
                    </div>
                    Job Description
                </h2>
                <div class="section-content">
                    <%= job.getJobDescription() %>
                </div>
                <div class="status-indicator">
                    <div class="status-dot"></div>
                    Actively Recruiting
                </div>
            </div>

            <!-- Required Skills -->
            <div class="section">
                <h2 class="section-title">
                    <div class="section-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    Required Skills & Technologies
                </h2>
                <div class="skills-container">
                    <%
                        if (job.getRequiredSkills() != null && !job.getRequiredSkills().trim().isEmpty()) {
                            String[] skills = job.getRequiredSkills().split(",");
                            for (String skill : skills) {
                    %>
                    <span class="skill-tag"><%= skill.trim() %></span>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="company-card">
                <div class="company-avatar">
                    <%
                        if (job.getCompanyName() != null && !job.getCompanyName().isEmpty()) {
                            out.print(job.getCompanyName().substring(0, 1).toUpperCase());
                        }
                    %>
                </div>
                <div class="company-name"><%= job.getCompanyName() %></div>
                <div class="company-description">
                    View company profile and other openings
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function applyForJob(jobId) {
        window.location.href = 'applyJob.jsp?jobId=' + jobId;
    }

    function saveJob(jobId) {
        const button = event.target.closest('.btn');
        fetch('saveJob', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'jobId=' + jobId
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    button.innerHTML = '<i class="fas fa-check"></i> Job Saved';
                    button.style.backgroundColor = '#10b981';
                    button.style.borderColor = '#10b981';
                    button.style.color = 'white';
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    function shareJob(jobId) {
        const url = window.location.href;
        const title = document.querySelector('.job-title').textContent;

        if (navigator.share) {
            navigator.share({
                title: title,
                url: url
            });
        } else {
            navigator.clipboard.writeText(url).then(() => {
                const button = event.target.closest('.btn');
                const originalContent = button.innerHTML;
                button.innerHTML = '<i class="fas fa-check"></i> Link Copied';
                setTimeout(() => {
                    button.innerHTML = originalContent;
                }, 2000);
            });
        }
    }
</script>
</body>
</html>