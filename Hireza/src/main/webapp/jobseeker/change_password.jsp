<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #4A90E2;
            --light-blue: #E8F4F8;
            --dark-blue: #2C5F8D;
            --border-blue: #B8D4E8;
        }

        body {
            background: linear-gradient(135deg, #E8F4F8 0%, #F0F8FF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .password-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(74, 144, 226, 0.12);
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
        }

        .card-header-custom {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .card-header-custom i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        .card-header-custom h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.75rem;
        }

        .card-header-custom p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .card-body-custom {
            padding: 2.5rem;
        }

        .form-label {
            color: var(--dark-blue);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-control {
            border: 2px solid var(--border-blue);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.15);
        }

        .input-group-custom {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-blue);
            z-index: 10;
        }

        .form-control.with-icon {
            padding-left: 2.75rem;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(74, 144, 226, 0.4);
        }

        .btn-secondary-custom {
            background: white;
            border: 2px solid var(--border-blue);
            color: var(--dark-blue);
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary-custom:hover {
            background: var(--light-blue);
            border-color: var(--primary-blue);
            color: var(--dark-blue);
        }

        .alert {
            border-radius: 8px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
        }

        .alert-danger {
            background: #FFF5F5;
            color: #C53030;
            border-left: 4px solid #FC8181;
        }

        .alert-success {
            background: #F0FFF4;
            color: #2F855A;
            border-left: 4px solid #68D391;
        }

        .alert i {
            margin-right: 0.5rem;
        }

        .password-requirements {
            background: var(--light-blue);
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1.5rem;
            border-left: 4px solid var(--primary-blue);
        }

        .password-requirements h6 {
            color: var(--dark-blue);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .password-requirements ul {
            margin: 0;
            padding-left: 1.25rem;
            font-size: 0.85rem;
            color: var(--dark-blue);
        }

        .password-requirements li {
            margin-bottom: 0.25rem;
        }

        @media (max-width: 768px) {
            .card-body-custom {
                padding: 1.5rem;
            }

            .btn-group-custom {
                flex-direction: column;
            }

            .btn-group-custom .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
        }
    </style>
</head>
<body>

<div class="container mt-5 mb-5">
    <div class="password-card">
        <div class="card-header-custom">
            <i class="fas fa-shield-alt"></i>
            <h2>Change Password</h2>
            <p>Keep your account secure by updating your password regularly</p>
        </div>

        <div class="card-body-custom">
            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <%= request.getParameter("success") %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/jobseekerChangePasswordServlet" method="post">
                <div class="mb-4">
                    <label for="currentPassword" class="form-label">
                        <i class="fas fa-lock"></i> Current Password
                    </label>
                    <div class="input-group-custom">
                        <i class="fas fa-key input-icon"></i>
                        <input type="password"
                               id="currentPassword"
                               name="currentPassword"
                               class="form-control with-icon"
                               placeholder="Enter your current password"
                               required>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="newPassword" class="form-label">
                        <i class="fas fa-lock"></i> New Password
                    </label>
                    <div class="input-group-custom">
                        <i class="fas fa-key input-icon"></i>
                        <input type="password"
                               id="newPassword"
                               name="newPassword"
                               class="form-control with-icon"
                               placeholder="Enter your new password"
                               required>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-lock"></i> Confirm New Password
                    </label>
                    <div class="input-group-custom">
                        <i class="fas fa-check-double input-icon"></i>
                        <input type="password"
                               id="confirmPassword"
                               name="confirmPassword"
                               class="form-control with-icon"
                               placeholder="Confirm your new password"
                               required>
                    </div>
                </div>

                <div class="password-requirements">
                    <h6><i class="fas fa-info-circle"></i> Password Requirements</h6>
                    <ul>
                        <li>Minimum 8 characters long</li>
                        <li>Include at least one uppercase letter</li>
                        <li>Include at least one number</li>
                        <li>Avoid using common words or patterns</li>
                    </ul>
                </div>

                <div class="d-flex gap-3 mt-4 btn-group-custom">
                    <button type="submit" class="btn btn-primary-custom flex-grow-1">
                        <i class="fas fa-save"></i> Update Password
                    </button>
                    <a href="<%= request.getContextPath() %>/jobseeker/home.jsp"
                       class="btn btn-secondary-custom">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>