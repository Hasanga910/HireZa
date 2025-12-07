<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Employer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setup Complete - HireZa</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/jpeg" href="${pageContext.request.contextPath}/images/employer/2.jpg">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .success-container {
            background: white;
            border-radius: 20px;
            padding: 4rem 3rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            text-align: center;
            max-width: 650px;
            width: 100%;
            animation: fadeInUp 0.6s ease;
            border: 1px solid #f3f4f6;
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

        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #10b981, #059669);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            animation: scaleIn 0.5s ease 0.3s both;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.25);
        }

        @keyframes scaleIn {
            from {
                transform: scale(0) rotate(-180deg);
            }
            to {
                transform: scale(1) rotate(0deg);
            }
        }

        .success-icon i {
            font-size: 3.5rem;
            color: white;
        }

        .success-container h1 {
            color: #1a1a1a;
            font-size: 2.25rem;
            margin-bottom: 1rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .success-container p {
            color: #6b7280;
            font-size: 1.125rem;
            margin-bottom: 2.5rem;
            line-height: 1.7;
            font-weight: 400;
        }

        .features {
            background: #f9fafb;
            border-radius: 16px;
            padding: 2rem;
            margin: 2.5rem 0;
            text-align: left;
            border: 2px solid #f3f4f6;
        }

        .features h3 {
            color: #1a1a1a;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 700;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.25rem;
            padding: 1rem;
            background: white;
            border-radius: 12px;
            transition: all 0.2s ease;
            border: 1px solid #f3f4f6;
        }

        .feature-item:last-child {
            margin-bottom: 0;
        }

        .feature-item:hover {
            transform: translateX(8px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-color: #e5e7eb;
        }

        .feature-item i {
            color: #10b981;
            font-size: 1.5rem;
            margin-right: 1.25rem;
            min-width: 30px;
            background: #ecfdf5;
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        .feature-item span {
            color: #374151;
            font-size: 1rem;
            font-weight: 500;
        }

        .btn-dashboard {
            display: inline-block;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 1.125rem 3.5rem;
            border-radius: 12px;
            text-decoration: none;
            font-size: 1.125rem;
            font-weight: 600;
            transition: all 0.2s ease;
            margin-top: 1rem;
            box-shadow: 0 4px 6px rgba(99, 102, 241, 0.2);
        }

        .btn-dashboard:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 12px rgba(99, 102, 241, 0.3);
        }

        .btn-dashboard:active {
            transform: translateY(-1px);
        }

        .btn-dashboard i {
            margin-left: 0.5rem;
        }

        .confetti {
            position: fixed;
            width: 10px;
            height: 10px;
            background: #6366f1;
            position: absolute;
            animation: confetti-fall 3s linear infinite;
        }

        @keyframes confetti-fall {
            to {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        .celebration-emoji {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: inline-block;
            animation: bounce 1s ease infinite;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .success-container {
                padding: 3rem 2rem;
            }

            .success-container h1 {
                font-size: 1.75rem;
            }

            .success-container p {
                font-size: 1rem;
            }

            .success-icon {
                width: 100px;
                height: 100px;
            }

            .success-icon i {
                font-size: 3rem;
            }

            .btn-dashboard {
                padding: 1rem 2.5rem;
                font-size: 1rem;
                width: 100%;
            }

            .features {
                padding: 1.5rem;
            }

            .feature-item {
                padding: 0.875rem;
            }
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="success-icon">
        <i class="fas fa-check"></i>
    </div>

    <div class="celebration-emoji">🎉</div>
    <h1>Profile Setup Complete!</h1>
    <p>Congratulations! Your company profile has been successfully created. You're now ready to start posting jobs and connecting with talented candidates.</p>

    <div class="features">
        <h3>What's Next?</h3>
        <div class="feature-item">
            <i class="fas fa-briefcase"></i>
            <span>Post your first job opening</span>
        </div>
        <div class="feature-item">
            <i class="fas fa-users"></i>
            <span>Manage your recruiter team</span>
        </div>
        <div class="feature-item">
            <i class="fas fa-file-alt"></i>
            <span>Review job applications</span>
        </div>
        <div class="feature-item">
            <i class="fas fa-chart-line"></i>
            <span>Track recruitment analytics</span>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp" class="btn-dashboard">
        Go to Dashboard <i class="fas fa-arrow-right"></i>
    </a>
</div>

<script>
    // Create confetti effect
    function createConfetti() {
        const colors = ['#6366f1', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#ec4899'];
        for (let i = 0; i < 50; i++) {
            setTimeout(() => {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.animationDelay = Math.random() * 3 + 's';
                confetti.style.animationDuration = (Math.random() * 2 + 2) + 's';
                document.body.appendChild(confetti);

                setTimeout(() => {
                    confetti.remove();
                }, 5000);
            }, i * 30);
        }
    }

    // Trigger confetti on page load
    window.addEventListener('load', createConfetti);
</script>
</body>
</html>