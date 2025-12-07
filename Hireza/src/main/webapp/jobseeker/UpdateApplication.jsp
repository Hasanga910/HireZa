<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobApplication" %>
<%
    JobApplication app = (JobApplication) request.getAttribute("application");
    if (app == null) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=not_found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Application - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }

        .container {
            max-width: 900px;
        }

        .application-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(37, 99, 235, 0.12);
            overflow: hidden;
            border: 1px solid rgba(37, 99, 235, 0.15);
        }

        .card-header {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: white;
            padding: 2rem;
            border-bottom: none;
        }

        .card-header h3 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .job-title-subtitle {
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .card-body {
            padding: 2rem;
        }

        .info-alert {
            background: #eff6ff;
            border-left: 4px solid #3b82f6;
            padding: 1rem 1.25rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            color: #1e40af;
        }

        .form-label {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .required {
            color: #ef4444;
        }

        .form-control, .form-select {
            border: 1px solid #e1e5e9;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        textarea.form-control {
            min-height: 120px;
        }

        .file-note {
            font-size: 0.8rem;
            color: #64748b;
            margin-top: 0.5rem;
        }

        .btn-group-custom {
            display: flex;
            gap: 0.75rem;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: white;
            color: #64748b;
            border: 1px solid #e1e5e9;
        }

        .btn-secondary:hover {
            background: #f8fafc;
            color: #1e293b;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="application-card">
        <div class="card-header">
            <h3>
                <i class="fas fa-edit"></i>
                Update Application
            </h3>
            <div class="job-title-subtitle">
                <i class="fas fa-briefcase"></i>
                <%= app.getJobTitle() %>
            </div>
        </div>

        <div class="card-body">
            <div class="info-alert">
                <i class="fas fa-info-circle"></i>
                Please review and update your application details below. All fields marked with <span class="required">*</span> are required.
            </div>

            <form action="${pageContext.request.contextPath}/EditApplicationServlet" method="post" enctype="multipart/form-data">

                <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>"/>

                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-user"></i>
                        Full Name<span class="required">*</span>
                    </label>
                    <input type="text"
                           name="fullName"
                           class="form-control"
                           value="<%= app.getFullName() %>"
                           placeholder="Enter your full name"
                           required/>
                </div>

                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email Address<span class="required">*</span>
                    </label>
                    <input type="email"
                           name="email"
                           class="form-control"
                           value="<%= app.getEmail() %>"
                           placeholder="your.email@example.com"
                           required/>
                </div>

                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-phone"></i>
                        Phone Number<span class="required">*</span>
                    </label>
                    <input type="text"
                           name="phone"
                           class="form-control"
                           value="<%= app.getPhone() %>"
                           placeholder="+1 (555) 000-0000"
                           required/>
                </div>

                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-file-alt"></i>
                        Cover Letter
                    </label>
                    <textarea name="coverLetter"
                              class="form-control"
                              rows="6"
                              placeholder="Tell us why you're interested in this position..."><%= app.getCoverLetter() != null ? app.getCoverLetter() : "" %></textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-file-pdf"></i>
                        Resume File
                    </label>
                    <input type="file"
                           name="resumeFile"
                           class="form-control"
                           accept=".pdf,.doc,.docx"/>
                    <div class="file-note">
                        <i class="fas fa-info-circle"></i>
                        Current file: <%= app.getResumeFile() != null && !app.getResumeFile().isEmpty() ? app.getResumeFile() : "No file uploaded" %>
                    </div>
                    <div class="file-note">
                        Leave empty to keep existing resume
                    </div>
                </div>

                <div class="btn-group-custom">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Update Application
                    </button>
                    <a href="${pageContext.request.contextPath}/jobseeker/Myapplication" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>