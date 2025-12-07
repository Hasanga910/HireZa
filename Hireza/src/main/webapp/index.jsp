<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.JobPostDAO, model.JobPost, java.util.List" %>
<%@ page import="dao.UserDAO" %>
<%
    JobPostDAO dao = new JobPostDAO();
    List<JobPost> allJobs = dao.getAllJobPosts();
    List<JobPost> jobs = allJobs != null && allJobs.size() > 5 ? allJobs.subList(0, 5) : allJobs;
%>
<%
    UserDAO userDAO = new UserDAO();
    int jobSeekersCount = userDAO.getJobSeekersCount();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireZa - Find Your Dream Job</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-color: #3b82f6;
            --secondary-color: #6b7280;
            --accent-color: #38bdf8;
            --success-color: #22c55e;
            --background-color: #e5e7eb;
            --card-background: #f3f4f6;
            --text-color: #374151;
            --navbar-background: #f9fafb;
            --footer-background: #1f2937;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--background-color);
            overflow-x: hidden;
            color: var(--text-color);
        }

        /* Animations */
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

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        @keyframes liquidGlass {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .animate-on-scroll {
            opacity: 0;
            animation: fadeInUp 0.8s ease forwards;
        }

        /* Navbar with Neutral Liquid Glass Effect */
        .navbar {
            background: rgba(249, 250, 251, 0.2); /* Semi-transparent */
            backdrop-filter: blur(15px) saturate(180%);
            -webkit-backdrop-filter: blur(15px) saturate(180%);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 0.5rem 0;
            transition: all 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.2);
            background-image: linear-gradient(
                    45deg,
                    rgba(255, 255, 255, 0.1),
                    rgba(200, 200, 200, 0.1),
                    rgba(255, 255, 255, 0.1)
            );
            background-size: 200% 200%;
            animation: liquidGlass 6s ease-in-out infinite;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e3a8a;
            transition: all 0.3s;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .navbar-brand img {
            border-radius: 8px;
            transition: transform 0.3s;
        }

        .navbar-brand:hover img {
            transform: rotate(360deg);
        }

        .nav-link {
            font-weight: 500;
            margin: 0 10px;
            transition: all 0.3s;
            position: relative;
            color: var(--text-color);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: all 0.3s;
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 80%;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
        }

        /* Liquid Glass Effect for Buttons */
        .btn-liquid-glass {
            background: rgba(59, 130, 246, 0.2);
            backdrop-filter: blur(12px) saturate(180%);
            -webkit-backdrop-filter: blur(12px) saturate(180%);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-image: linear-gradient(
                    45deg,
                    rgba(59, 130, 246, 0.3),
                    rgba(56, 189, 248, 0.3),
                    rgba(59, 130, 246, 0.3)
            );
            background-size: 200% 200%;
            animation: liquidGlass 4s ease-in-out infinite;
        }

        .btn-liquid-glass:hover {
            background: rgba(96, 165, 250, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            border-color: rgba(255, 255, 255, 0.4);
            background-image: linear-gradient(
                    45deg,
                    rgba(96, 165, 250, 0.4),
                    rgba(56, 189, 248, 0.4),
                    rgba(96, 165, 250, 0.4)
            );
        }

        .btn-liquid-glass:active {
            transform: translateY(0);
            background: rgba(59, 130, 246, 0.4);
        }

        .btn-liquid-glass-outline {
            background: transparent;
            backdrop-filter: blur(12px) saturate(180%);
            -webkit-backdrop-filter: blur(12px) saturate(180%);
            border: 2px solid rgba(255, 255, 255, 0.4);
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-image: linear-gradient(
                    45deg,
                    rgba(59, 130, 246, 0.1),
                    rgba(56, 189, 248, 0.1),
                    rgba(59, 130, 246, 0.1)
            );
            background-size: 200% 200%;
            animation: liquidGlass 4s ease-in-out infinite;
        }

        .btn-liquid-glass-outline:hover {
            background: rgba(255, 255, 255, 0.2);
            color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .btn-liquid-glass-outline:active {
            transform: translateY(0);
            background: rgba(255, 255, 255, 0.3);
        }

        /* Hero Section */
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            color: white;
            text-align: left;
            padding: 120px 20px 80px;
        }

        .hero-bg {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-size: cover;
            background-position: center top;
            background-attachment: fixed;
            opacity: 0;
            animation: fadeSlide 20s infinite;
            z-index: 0;
        }

        .hero-bg:nth-child(1) {
            background-image: url('images/index/image1.jpg');
            animation-delay: 0s;
        }

        .hero-bg:nth-child(2) {
            background-image: url('images/index/image2.jpg');
            animation-delay: 5s;
        }

        .hero-bg:nth-child(3) {
            background-image: url('images/index/image3.jpg');
            animation-delay: 10s;
        }

        .hero-bg:nth-child(4) {
            background-image: url('images/index/image4.jpg');
            animation-delay: 15s;
        }

        @keyframes fadeSlide {
            0% { opacity: 0; }
            5% { opacity: 1; }
            25% { opacity: 1; }
            30% { opacity: 0; }
            100% { opacity: 0; }
        }

        .hero-section::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3));
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(107, 114, 128, 0.1);
            z-index: 1;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            animation: fadeInUp 1s ease;
            color: white;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
            animation: fadeInUp 1s ease 0.2s backwards;
            color: white;
        }

        .hero-buttons {
            animation: fadeInUp 1s ease 0.4s backwards;
        }

        .hero-buttons .btn {
            padding: 14px 36px;
            font-size: 1.1rem;
            margin: 10px;
            font-weight: 600;
        }

        .search-form {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            padding: 2.5rem;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow:
                    0 8px 32px rgba(0, 0, 0, 0.1),
                    inset 0 1px 0 rgba(255, 255, 255, 0.2),
                    inset 0 -1px 0 rgba(0, 0, 0, 0.05);
            margin-top: 3rem;
            position: relative;
            z-index: 3;
        }

        .search-form h4 {
            color: white;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-control {
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            padding: 14px 18px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.15);
            color: white;
            backdrop-filter: blur(10px);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            border-color: rgba(255, 255, 255, 0.6);
            box-shadow:
                    0 0 0 3px rgba(255, 255, 255, 0.15),
                    inset 0 2px 4px rgba(255, 255, 255, 0.1);
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .btn-search {
            background: rgba(59, 130, 246, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 14px 30px;
            border-radius: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            box-shadow:
                    0 4px 15px rgba(0, 0, 0, 0.1),
                    inset 0 1px 0 rgba(255, 255, 255, 0.2);
        }

        .btn-search:hover {
            background: rgba(96, 165, 250, 0.8);
            transform: translateY(-2px);
            box-shadow:
                    0 6px 20px rgba(0, 0, 0, 0.15),
                    inset 0 1px 0 rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn-search:active {
            transform: translateY(0);
            background: rgba(59, 130, 246, 0.8);
        }

        .search-form select.form-control {
            background: rgba(255, 255, 255, 0.15) !important;
            backdrop-filter: blur(10px) !important;
            -webkit-backdrop-filter: blur(10px) !important;
            color: white !important;
            border: 1px solid rgba(255, 255, 255, 0.3) !important;
            border-radius: 12px !important;
            padding: 14px 18px !important;
            font-size: 0.95rem !important;
            transition: all 0.3s ease !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            -moz-appearance: none !important;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='white' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E") !important;
            background-repeat: no-repeat !important;
            background-position: right 16px center !important;
            background-size: 16px !important;
            padding-right: 45px !important;
        }

        .search-form select.form-control:focus {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: rgba(255, 255, 255, 0.6) !important;
            box-shadow:
                    0 0 0 3px rgba(255, 255, 255, 0.15),
                    inset 0 2px 4px rgba(255, 255, 255, 0.1) !important;
            outline: none !important;
            color: white !important;
        }

        .search-form select.form-control:hover {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: rgba(255, 255, 255, 0.4) !important;
        }

        .search-form select.form-control option {
            background: rgba(30, 30, 40, 0.95) !important;
            color: white !important;
            padding: 12px !important;
            border: none !important;
        }

        .search-form select.form-control::-webkit-scrollbar {
            width: 8px;
        }

        .search-form select.form-control::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        .search-form select.form-control::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 4px;
        }

        .search-form select.form-control::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.5);
        }

        .search-form select.form-control::-ms-expand {
            display: none;
        }

        .search-form select.form-control option[value=""][disabled] {
            color: rgba(255, 255, 255, 0.7) !important;
        }

        .search-form select.form-control option:checked {
            background: rgba(59, 130, 246, 0.5) !important;
            color: white !important;
        }

        .hero-text-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            opacity: 0;
            animation: textFadeSlide 20s infinite;
            pointer-events: none;
        }

        .hero-text-slide.active {
            position: relative;
        }

        .hero-text-slide:nth-child(1) {
            animation-delay: 0s;
        }

        .hero-text-slide:nth-child(2) {
            animation-delay: 5s;
        }

        .hero-text-slide:nth-child(3) {
            animation-delay: 10s;
        }

        .hero-text-slide:nth-child(4) {
            animation-delay: 15s;
        }

        @keyframes textFadeSlide {
            0% { opacity: 0; transform: translateY(20px); }
            2% { opacity: 1; transform: translateY(0); }
            23% { opacity: 1; transform: translateY(0); }
            25% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 0; transform: translateY(-20px); }
        }

        .hero-content > .d-flex {
            position: relative;
            z-index: 10;
        }

        /* Stats Section */
        .stats-section {
            background: var(--card-background);
            padding: 60px 0;
            box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.05);
        }

        .stat-item {
            text-align: center;
            padding: 30px 20px;
            animation: fadeInUp 0.8s ease;
        }

        .stat-item:hover .stat-number {
            animation: pulse 0.6s ease;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: var(--primary-color);
            transition: all 0.3s;
        }

        .stat-label {
            font-size: 1rem;
            color: var(--secondary-color);
            margin-top: 10px;
        }

        /* User Roles Section */
        .roles-section {
            padding: 100px 0;
            background: linear-gradient(135deg, var(--background-color), #d1d5db);
        }

        .section-title {
            font-size: 2.8rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .section-subtitle {
            text-align: center;
            color: var(--secondary-color);
            margin-bottom: 4rem;
            font-size: 1.2rem;
        }

        .role-card {
            background: var(--card-background);
            border-radius: 20px;
            padding: 3rem 2rem;
            height: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .role-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.2), transparent);
            transition: left 0.5s;
        }

        .role-card:hover::before {
            left: 100%;
        }

        .role-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
            border-color: var(--primary-color);
        }

        .role-card.featured {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, var(--card-background), #e5e7eb);
            transform: scale(1.05);
        }

        .role-card.featured:hover {
            transform: translateY(-15px) scale(1.05);
        }

        .featured-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 8px 18px;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
            animation: pulse 2s infinite;
        }

        .role-icon {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 2.5rem;
            color: white;
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
            transition: all 0.3s;
        }

        .role-card:hover .role-icon {
            transform: rotateY(360deg);
        }

        .role-title {
            font-size: 1.8rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1.5rem;
            color: var(--text-color);
        }

        .role-description {
            text-align: center;
            color: var(--secondary-color);
            line-height: 1.8;
            margin-bottom: 2rem;
            font-size: 1rem;
        }

        .role-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem 0;
        }

        .role-features li {
            padding: 0.75rem 0;
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s;
        }

        .role-features li:hover {
            transform: translateX(10px);
            color: var(--primary-color);
        }

        .role-features i {
            color: var(--success-color);
            margin-right: 12px;
            font-size: 1.1rem;
        }

        /* How It Works Section */
        .how-it-works-section {
            padding: 100px 0;
            background: var(--card-background);
            position: relative;
        }

        .step-card {
            background: linear-gradient(135deg, var(--card-background), #e5e7eb);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            height: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border: 2px solid var(--background-color);
        }

        .step-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            transition: height 0.3s;
        }

        .step-card:hover::before {
            height: 100%;
            opacity: 0.1;
        }

        .step-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
            border-color: var(--primary-color);
        }

        .step-number {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.3);
            transition: all 0.3s;
        }

        .step-card:hover .step-number {
            transform: rotate(360deg) scale(1.1);
        }

        .step-icon {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, var(--background-color), #d1d5db);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 1.5rem auto 2rem;
            font-size: 2.2rem;
            color: var(--primary-color);
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .step-card:hover .step-icon {
            transform: scale(1.1) rotateY(180deg);
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
        }

        .step-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .step-description {
            color: var(--secondary-color);
            line-height: 1.8;
            font-size: 1rem;
        }

        /* Jobs Section */
        .jobs-section {
            padding: 100px 0;
            background: linear-gradient(135deg, var(--background-color), #d1d5db);
        }

        .job-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.4s ease;
            border-left: 5px solid var(--primary-color);
            animation: fadeInUp 0.6s ease;
        }

        .job-card:hover {
            transform: translateX(10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .job-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .job-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .company-name {
            color: var(--primary-color);
            font-weight: 500;
            font-size: 1.1rem;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 1.5rem 0;
        }

        .job-meta-item {
            display: flex;
            align-items: center;
            color: var(--secondary-color);
            font-size: 1rem;
        }

        .job-meta-item i {
            margin-right: 10px;
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .job-description {
            color: var(--text-color);
            line-height: 1.8;
            margin: 1.5rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .badge-custom {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            background: var(--primary-color);
            color: white;
            animation: pulse 2s infinite;
        }

        .view-all-btn {
            text-align: center;
            margin-top: 3rem;
        }

        .btn-primary,
        .btn-outline-primary {
            transition: all 0.3s;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover,
        .btn-outline-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
            background: var(--accent-color);
            border-color: var(--accent-color);
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #1a1f2e 0%, #2d3748 100%);
            color: #e5e7eb;
            padding: 80px 0 0;
            position: relative;
            overflow: hidden;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color), var(--success-color));
        }

        .footer::after {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.1), transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        .footer-brand img {
            border-radius: 8px;
            margin-right: 12px;
        }

        .footer-brand h4 {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            margin: 0;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .footer h5 {
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.8rem;
            color: white;
            font-size: 1.2rem;
        }

        .footer h5::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }

        .footer-description {
            color: #cbd5e1;
            line-height: 1.8;
            margin-bottom: 1.5rem;
        }

        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 0.8rem;
        }

        .footer-links a {
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            position: relative;
            padding-left: 0;
        }

        .footer-links a::before {
            content: '›';
            margin-right: 8px;
            font-size: 1.3rem;
            transition: all 0.3s ease;
            color: var(--primary-color);
        }

        .footer-links a:hover {
            color: var(--primary-color);
            padding-left: 8px;
        }

        .footer-links a:hover::before {
            margin-right: 12px;
        }

        .social-icons {
            display: flex;
            gap: 12px;
            margin-top: 1.5rem;
        }

        .social-icons a {
            width: 45px;
            height: 45px;
            background: rgba(59, 130, 246, 0.1);
            border: 2px solid rgba(59, 130, 246, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .social-icons a:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-color: var(--primary-color);
            color: white;
            transform: translateY(-5px) rotate(360deg);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .contact-item {
            display: flex;
            align-items: start;
            margin-bottom: 1rem;
            color: #cbd5e1;
        }

        .contact-item i {
            width: 24px;
            color: var(--primary-color);
            margin-right: 12px;
            margin-top: 3px;
            font-size: 1.1rem;
        }

        .newsletter-form {
            position: relative;
            margin-top: 1.5rem;
        }

        .newsletter-form .form-control {
            border-radius: 12px;
            border: 2px solid rgba(59, 130, 246, 0.2);
            padding: 14px 20px;
            background: rgba(255, 255, 255, 0.05);
            color: white;
            transition: all 0.3s ease;
        }

        .newsletter-form .form-control:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            outline: none;
        }

        .newsletter-form .form-control::placeholder {
            color: #94a3b8;
        }

        .newsletter-form .btn-primary {
            margin-top: 12px;
            border-radius: 12px;
            padding: 12px 28px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .newsletter-form .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .footer-bottom {
            background: rgba(0, 0, 0, 0.2);
            margin-top: 60px;
            padding: 25px 0;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .copyright {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #94a3b8;
            margin: 0;
        }

        .copyright p {
            margin: 0;
        }

        .back-to-top {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: rgba(59, 130, 246, 0.1);
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 25px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-to-top:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        @media (max-width: 768px) {
            .copyright {
                flex-direction: column;
                text-align: center;
            }
            .copyright a {
                margin-top: 10px;
            }
            .hero-title {
                font-size: 2.2rem;
            }
            .hero-subtitle {
                font-size: 1.1rem;
            }
            .section-title {
                font-size: 2rem;
            }
            .role-card.featured {
                transform: scale(1);
            }
            .role-card.featured:hover {
                transform: translateY(-15px) scale(1);
            }
            .stat-number {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="jobseeker/logo.jpg" alt="HireZa Logo" width="40" height="40" class="me-2" />
            HireZa
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#jobs">Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="#categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
            </ul>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-liquid-glass-outline me-2 custom-btn" href="jobseeker/signin.jsp">Sign In</a>
                <a class="btn btn-liquid-glass custom-btn" href="jobseeker/signup.jsp">Sign Up</a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero-section">
    <div class="hero-bg"></div>
    <div class="hero-bg"></div>
    <div class="hero-bg"></div>
    <div class="hero-bg"></div>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <div class="hero-content fade-in">
                    <div class="hero-text-slide active">
                        <h1 class="hero-title">Find Your Dream Career Today</h1>
                        <p class="hero-subtitle">Connect with top companies and discover opportunities that match your skills and ambitions. Your next career move starts here.</p>
                    </div>
                    <div class="hero-text-slide">
                        <h1 class="hero-title">Technology & IT Opportunities</h1>
                        <p class="hero-subtitle">Join innovative tech companies and work on cutting-edge projects. Shape the future of technology with your expertise.</p>
                    </div>
                    <div class="hero-text-slide">
                        <h1 class="hero-title">Marketing & Creative Roles</h1>
                        <p class="hero-subtitle">Unleash your creativity in dynamic marketing roles. Build brands, craft campaigns, and drive business growth.</p>
                    </div>
                    <div class="hero-text-slide">
                        <h1 class="hero-title">Healthcare Careers</h1>
                        <p class="hero-subtitle">Make a difference in people's lives. Explore rewarding healthcare positions with leading medical institutions.</p>
                    </div>
                    <div class="d-flex gap-3">
                        <button class="btn btn-liquid-glass btn-lg">Browse Jobs</button>
                        <button class="btn btn-liquid-glass-outline btn-lg">Post a Job</button>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="search-form fade-in delay-1">
                    <h4 class="mb-4 text-center">Start Your Job Search</h4>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <input type="text" class="form-control" placeholder="Job title or keyword">
                        </div>
                        <div class="col-md-6">
                            <select class="form-control">
                                <option>Select Location</option>
                                <option>Colombo</option>
                                <option>Kandy</option>
                                <option>Galle</option>
                                <option>Remote</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <select class="form-control">
                                <option>Job Type</option>
                                <option>Full Time</option>
                                <option>Part Time</option>
                                <option>Contract</option>
                                <option>Freelance</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <button class="btn btn-search w-100">
                                <i class="fas fa-search me-2"></i>Search Jobs
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number"><%= allJobs != null ? allJobs.size() : 0 %></div>
                    <div class="stat-label">Active Job Posts</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Companies Hiring</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number"><%= jobSeekersCount %></div>
                    <div class="stat-label">Job Seekers</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- User Roles Section -->
<section class="roles-section" id="roles">
    <div class="container">
        <h2 class="section-title">Who We Serve</h2>
        <p class="section-subtitle">HireZa connects three key players in the job market</p>
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="role-card">
                    <div class="role-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3 class="role-title">Employers</h3>
                    <p class="role-description">
                        Companies and organizations looking to find the best talent. Post job openings,
                        review applications, and connect with qualified candidates.
                    </p>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Post unlimited jobs</li>
                        <li><i class="fas fa-check-circle"></i> Manage applications</li>
                        <li><i class="fas fa-check-circle"></i> Find top talent</li>
                    </ul>
                    <a href="jobseeker/signup.jsp" class="btn btn-outline-primary w-100">
                        <i class="fas fa-sign-in-alt me-2"></i>Register as An Employer
                    </a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="role-card featured">
                    <div class="featured-badge">Most Popular</div>
                    <div class="role-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h3 class="role-title">Job Seekers</h3>
                    <p class="role-description">
                        Professionals seeking their next career opportunity. Browse jobs, apply online,
                        and get expert guidance from our counsellors.
                    </p>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Browse thousands of jobs</li>
                        <li><i class="fas fa-check-circle"></i> Easy application process</li>
                        <li><i class="fas fa-check-circle"></i> Get career counselling</li>
                    </ul>
                    <a href="jobseeker/signup.jsp" class="btn btn-primary w-100">
                        <i class="fas fa-sign-in-alt me-2"></i>Register as A Job Seeker
                    </a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="role-card">
                    <div class="role-icon">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h3 class="role-title">Job Counsellors</h3>
                    <p class="role-description">
                        Career experts dedicated to helping job seekers find their perfect match.
                        Provide guidance and support throughout the job search journey.
                    </p>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Guide job seekers</li>
                        <li><i class="fas fa-check-circle"></i> Offer expert advice</li>
                        <li><i class="fas fa-check-circle"></i> Track success stories</li>
                    </ul>
                    <a href="jobseeker/signup.jsp" class="btn btn-outline-primary w-100">
                        <i class="fas fa-sign-in-alt me-2"></i>Register as A Counsellor
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How It Works Section -->
<section class="how-it-works-section" id="how-it-works">
    <div class="container">
        <h2 class="section-title">How HireZa Works</h2>
        <p class="section-subtitle">Simple steps to connect talent with opportunity</p>
        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="step-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h4 class="step-title">Create Account</h4>
                    <p class="step-description">Sign up as an employer, job seeker, or counsellor based on your needs</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="step-icon">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <h4 class="step-title">Post or Browse</h4>
                    <p class="step-description">Employers post jobs while seekers browse opportunities and get counselling</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="step-icon">
                        <i class="fas fa-paper-plane"></i>
                    </div>
                    <h4 class="step-title">Apply or Review</h4>
                    <p class="step-description">Job seekers apply with one click, employers review qualified candidates</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">4</div>
                    <div class="step-icon">
                        <i class="fas fa-handshake"></i>
                    </div>
                    <h4 class="step-title">Get Hired</h4>
                    <p class="step-description">Connect, interview, and start your new career journey together</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Latest Jobs Section -->
<section class="jobs-section" id="jobs">
    <div class="container">
        <h2 class="section-title">Latest Job Opportunities</h2>
        <p class="section-subtitle">Discover the newest positions from top companies</p>
        <% if (jobs != null && !jobs.isEmpty()) { %>
        <% for (JobPost job : jobs) { %>
        <div class="job-card">
            <div class="job-card-header">
                <div>
                    <h3 class="job-title"><%= job.getJobTitle() %></h3>
                    <div class="company-name">
                        <i class="fas fa-building me-2"></i><%= job.getCompanyName() %>
                    </div>
                </div>
                <div>
                    <span class="badge bg-primary badge-custom">New</span>
                </div>
            </div>
            <div class="job-meta">
                <% if (job.getLocation() != null && !job.getLocation().isEmpty()) { %>
                <div class="job-meta-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <%= job.getLocation() %>
                </div>
                <% } %>
                <% if (job.getWorkMode() != null && !job.getWorkMode().isEmpty()) { %>
                <div class="job-meta-item">
                    <i class="fas fa-laptop-house"></i>
                    <%= job.getWorkMode() %>
                </div>
                <% } %>
                <% if (job.getSalaryRange() != null && !job.getSalaryRange().isEmpty()) { %>
                <div class="job-meta-item">
                    <i class="fas fa-dollar-sign"></i>
                    <%= job.getSalaryRange() %>
                </div>
                <% } %>
            </div>
            <div class="job-description">
                <%= job.getJobDescription() %>
            </div>
            <div class="mt-3">
                <a href="jobseeker/signin.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-paper-plane me-2"></i>Apply Now
                </a>
            </div>
        </div>
        <% } %>
        <div class="view-all-btn">
            <a href="jobseeker/signin.jsp" class="btn btn-primary btn-lg">
                View All Jobs <i class="fas fa-arrow-right ms-2"></i>
            </a>
        </div>
        <% } else { %>
        <div class="text-center py-5">
            <i class="fas fa-briefcase fa-3x text-muted mb-3"></i>
            <p class="text-muted">No jobs available at the moment. Check back soon!</p>
        </div>
        <% } %>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="d-flex align-items-center mb-3">
                    <img src="${pageContext.request.contextPath}/images/index/favicon.png" alt="HireZa Logo" width="40" height="40" class="me-2" />
                    <h5 class="mb-0">HireZa</h5>
                </div>
                <p style="color: #d1d5db;">Your trusted partner in finding the perfect job. We connect talented professionals with leading companies.</p>
                <div class="social-icons mt-3">
                    <a href="#" class="me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="me-3"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="#jobs">Browse Jobs</a></li>
                    <li><a href="jobseeker/signin.jsp">Job Seeker Login</a></li>
                    <li><a href="jobseeker/signin.jsp">Employer Login</a></li>
                    <li><a href="jobseeker/signin.jsp">Counsellor Login</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Support</h5>
                <ul class="footer-links">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">FAQ</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Contact</h5>
                <p style="color: #d1d5db;">
                    <i class="fas fa-envelope me-2"></i>support@hireza.com<br>
                    <i class="fas fa-phone me-2"></i>+94775245896<br>
                    <i class="fas fa-map-marker-alt me-2"></i>123 Career Street, Job City, Srilanka
                </p>
                <h5 class="mt-4">Newsletter</h5>
                <form action="#" class="d-flex">
                    <input type="email" class="form-control me-2" placeholder="Your email">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>
                </form>
            </div>
        </div>
        <div class="copyright d-flex justify-content-between align-items-center">
            <p class="mb-0">&copy; <%= new java.util.Date().getYear() + 1900 %> HireZa. All rights reserved.</p>
            <a href="#home" class="btn btn-outline-light btn-sm"><i class="fas fa-arrow-up me-2"></i>Back to Top</a>
        </div>
    </div>
</footer>

<script>
    document.querySelector('.copyright a[href="#home"]').addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>