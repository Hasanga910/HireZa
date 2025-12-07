<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        /* Navigation styles (unchanged) */
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
            --success-color: #059669;
            --text-muted: #6b7280;
            --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            line-height: 1.6;
            min-height: 100vh;
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

        /* Professional About Us Styles */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .hero-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9) 0%, rgba(118, 75, 162, 0.9) 100%),
            url('https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80') center/cover;
            color: white;
            padding: 4rem 2rem;
            border-radius: 20px;
            margin-bottom: 3rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%23ffffff" fill-opacity="0.05"><circle cx="7" cy="7" r="7"/><circle cx="53" cy="53" r="7"/></g></svg>');
            opacity: 0.3;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-section h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ffffff, #e2e8f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-section .lead {
            font-size: 1.25rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        .section {
            margin-bottom: 4rem;
        }

        .section-title {
            color: #1f2937;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .content-card {
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .content-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80') center/cover;
            opacity: 0.03;
            z-index: 0;
        }

        .content-card > * {
            position: relative;
            z-index: 1;
        }

        .content-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .mission-vision {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .mission-card, .vision-card {
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .mission-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40%;
            background: url('https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80') center/cover;
            opacity: 0.05;
            z-index: 0;
        }

        .vision-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 40%;
            background: url('https://images.unsplash.com/photo-1553028826-f4804151e0e0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80') center/cover;
            opacity: 0.05;
            z-index: 0;
        }

        .mission-card > *, .vision-card > * {
            position: relative;
            z-index: 1;
        }

        .mission-card:hover, .vision-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .mission-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .vision-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--success-color), #10b981);
        }

        .card-icon {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .vision-card .card-icon {
            background: linear-gradient(135deg, var(--success-color), #10b981);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1f2937;
        }

        .card-text {
            color: var(--text-muted);
            font-size: 1.1rem;
            line-height: 1.6;
        }

        .stats-section {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.98) 100%),
            url('https://images.unsplash.com/photo-1556761175-5973dc0f32e7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80') center/cover;
            border-radius: 16px;
            padding: 3rem 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(0, 0, 0, 0.05);
            margin: 3rem 0;
            position: relative;
            overflow: hidden;
        }

        .stats-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent 0%, rgba(59, 130, 246, 0.02) 50%, transparent 100%);
            z-index: 1;
        }

        .stats-section > * {
            position: relative;
            z-index: 2;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item {
            padding: 1.5rem;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: block;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 1rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            text-align: center;
        }

        .feature-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 1.5rem;
        }

        .feature-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1f2937;
        }

        .feature-text {
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .cta-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.95) 0%, rgba(118, 75, 162, 0.95) 100%),
            url('https://images.unsplash.com/photo-1521737711867-e3b97375f902?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80') center/cover;
            color: white;
            padding: 3rem 2rem;
            border-radius: 16px;
            text-align: center;
            margin-top: 4rem;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 70%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.05) 0%, transparent 50%);
            z-index: 1;
        }

        .cta-section > * {
            position: relative;
            z-index: 2;
        }

        .cta-section h3 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .cta-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }

        .cta-button {
            background: white;
            color: var(--primary-color);
            padding: 1rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .cta-button:hover {
            color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .hero-section {
                padding: 3rem 1.5rem;
            }

            .hero-section h1 {
                font-size: 2rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .content-card {
                padding: 1.5rem;
            }

            .mission-card, .vision-card {
                padding: 2rem;
            }

            .stats-section {
                padding: 2rem 1rem;
            }

            .stat-number {
                font-size: 2.5rem;
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

<div class="main-container">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1>About HireZa</h1>
            <p class="lead">Connecting talented professionals with exceptional opportunities. We're revolutionizing the way companies and job seekers find each other in today's dynamic employment landscape.</p>
        </div>
    </div>

    <!-- Mission & Vision -->
    <div class="section">
        <h2 class="section-title">Our Purpose</h2>
        <div class="mission-vision">
            <div class="mission-card">
                <i class="fas fa-bullseye card-icon"></i>
                <h3 class="card-title">Our Mission</h3>
                <p class="card-text">To bridge the gap between exceptional talent and outstanding career opportunities, creating meaningful connections that drive professional growth and organizational success.</p>
            </div>
            <div class="vision-card">
                <i class="fas fa-eye card-icon"></i>
                <h3 class="card-title">Our Vision</h3>
                <p class="card-text">To become the leading platform where careers flourish and companies thrive, powered by innovative technology and genuine human connections.</p>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <h2 class="section-title">HireZa by the Numbers</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <span class="stat-number">10K+</span>
                <span class="stat-label">Active Job Seekers</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">2K+</span>
                <span class="stat-label">Partner Companies</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">5K+</span>
                <span class="stat-label">Successful Placements</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">95%</span>
                <span class="stat-label">Satisfaction Rate</span>
            </div>
        </div>
    </div>

    <!-- What We Do -->
    <div class="section">
        <h2 class="section-title">What Makes Us Different</h2>
        <div class="content-card">
            <p style="font-size: 1.1rem; color: var(--text-muted); text-align: center; max-width: 800px; margin: 0 auto;">
                HireZa is more than just a job board. We're a comprehensive career ecosystem that leverages cutting-edge technology,
                data-driven insights, and personalized matching to create perfect career connections. Our platform empowers job seekers
                to showcase their unique skills while helping employers discover the talent that will drive their success forward.
            </p>
        </div>
    </div>

    <!-- Features -->
    <div class="section">
        <h2 class="section-title">Why Choose HireZa</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h4 class="feature-title">Smart Job Matching</h4>
                <p class="feature-text">Our advanced algorithms match candidates with roles that align perfectly with their skills, experience, and career goals.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h4 class="feature-title">Quality Network</h4>
                <p class="feature-text">Connect with top-tier companies and talented professionals across diverse industries and career levels.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-rocket"></i>
                </div>
                <h4 class="feature-title">Career Growth</h4>
                <p class="feature-text">Access resources, insights, and opportunities that accelerate professional development and career advancement.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h4 class="feature-title">Secure & Private</h4>
                <p class="feature-text">Your data and career information are protected with enterprise-grade security and privacy measures.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h4 class="feature-title">Real-Time Updates</h4>
                <p class="feature-text">Stay informed with instant notifications about new opportunities, application status, and industry insights.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-handshake"></i>
                </div>
                <h4 class="feature-title">Personal Support</h4>
                <p class="feature-text">Get dedicated support from our career specialists who understand your industry and aspirations.</p>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="cta-section">
        <h3>Ready to Transform Your Career?</h3>
        <p>Join thousands of professionals who've found their dream jobs through HireZa. Your next career milestone is just one click away.</p>
        <a href="${pageContext.request.contextPath}/search-jobs" class="cta-button">
            <i class="fas fa-arrow-right"></i>
            Explore Opportunities
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>