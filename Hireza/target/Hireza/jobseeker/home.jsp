<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobPortal - Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            color: #333;
        }

        /* Navigation Bar */
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e3a8a!important;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover {
            color: #007bff !important; /* Highlight on hover */
        }


        .navbar-brand:hover {
            color: #0056b3 !important;
        }

        .nav-link {
            color: #333 !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            margin: 0 0.25rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: #f8f9fa;
            color: #007bff !important;
        }

        .custom-btn {
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-primary.custom-btn {
            border-color: #007bff;
            color: #007bff;
        }

        .btn-outline-primary.custom-btn:hover {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }

        .btn-primary.custom-btn {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary.custom-btn:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* Main Container */
        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* Search Section */
        .search-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .search-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .search-header h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 2;
            padding: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            padding: 1rem 2rem;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }

        .filters {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filter-select {
            padding: 0.8rem 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select:hover {
            border-color: #007bff;
        }

        /* Job Categories */
        .job-categories {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);  /* 2 cards per row */
            gap: 1rem;
            margin-top: 1.5rem;
        }

        /* Category Card */
        .category-card {
            position: relative;
            display: block;
            width: 100%;              /* Stays inside grid cell */
            height: 150px;            /* Fixed height */
            border-radius: 15px;
            text-align: center;
            color: white;
            text-decoration: none;
            padding: 1.5rem;
            background-image: var(--bg-img);  /* Dynamic background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        /* Optional dark overlay for readability */
        .category-card::before {
            content: "";
            position: absolute;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.3);  /* darken image */
            z-index: 0;
        }

        .category-card > * {
            position: relative;
            z-index: 1;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 123, 255, 0.3);
        }

        /* Icon inside the card */
        .category-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }


        /* Featured Jobs */
        .featured-jobs {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .job-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .job-card:hover {
            transform: translateY(-5px);
            border-color: #007bff;
        }

        .job-header {
            display: flex;
            justify-content: between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .job-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .job-company {
            color: #007bff;
            font-weight: 500;
        }

        .job-location {
            color: #666;
            font-size: 0.9rem;
            margin: 0.5rem 0;
        }

        .job-tags {
            display: flex;
            gap: 0.5rem;
            margin: 1rem 0;
            flex-wrap: wrap;
        }

        .job-tag {
            background: #e3f2fd;
            color: #007bff;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
        }

        .apply-btn {
            width: 100%;
            padding: 0.8rem;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 25px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .apply-btn:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }

        /* Recent Activity */
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #007bff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .activity-text {
            flex: 1;
        }

        .activity-time {
            color: #666;
            font-size: 0.8rem;
        }

        /* Footer */
        .footer {
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 3rem 2rem 2rem;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            color: #007bff;
        }

        .footer-section ul {
            list-style: none;
        }

        .footer-section a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #007bff;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 1rem 0;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #007bff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .social-link:hover {
            background: #0056b3;
            transform: translateY(-3px);
            color: white;
        }

        .footer-bottom {
            border-top: 1px solid #444;
            padding-top: 1rem;
            color: #ccc;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }

            .categories-grid {
                grid-template-columns: 1fr;
            }
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

        .main-container > * {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="images/home/logo.jpeg" alt="HireZa Logo" width="40" height="40" class="me-2" />
            HireZa
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="#home"> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#profile">My Applications</a></li>
                <li class="nav-item"><a class="nav-link" href="#jobs"> Search Jobs</a></li>
                <li class="nav-item"><a class="nav-link" href="#applications">My Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="#applications">About Us</a></li>
            </ul>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-primary me-2 custom-btn" href="#logout"> Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="main-container">

    <!-- Search Section -->
    <section class="search-section">
        <div class="search-header">
            <h2>🔍 Find Your Perfect Job</h2>
            <p>Search from thousands of opportunities</p>
        </div>
        <form class="search-form">
            <input type="text" class="search-input" placeholder="Job title, keywords, or company name...">
            <input type="text" class="search-input" placeholder="Location (city, state, or remote)">
            <button type="submit" class="search-btn">Search Jobs</button>
        </form>
        <div class="filters">
            <select class="filter-select">
                <option>All Categories</option>
                <option>IT & Technology</option>
                <option>Marketing</option>
                <option>Engineering</option>
                <option>Finance</option>
                <option>Healthcare</option>
            </select>
            <select class="filter-select">
                <option>Experience Level</option>
                <option>Entry Level</option>
                <option>Mid Level</option>
                <option>Senior Level</option>
                <option>Executive</option>
            </select>
            <select class="filter-select">
                <option>Salary Range</option>
                <option>$30k - $50k</option>
                <option>$50k - $75k</option>
                <option>$75k - $100k</option>
                <option>$100k+</option>
            </select>
        </div>
    </section>

    <!-- Job Categories -->
    <section class="job-categories">
        <h2>🎯 Browse by Category</h2>
        <div class="categories-grid">
            <a href="#" class="category-card" style="--bg-img: url('../images/home/it1.jpg')">
                <div class="category-icon">💻</div>
                <h3>IT Jobs</h3>
                <p>1,234 jobs</p>
            </a>
            <a href="#" class="category-card" style="--bg-img: url('../images/home/marketing.jpg')">
                <div class="category-icon">📈</div>
                <h3>Marketing</h3>
                <p>567 jobs</p>
            </a>
            <a href="#" class="category-card" style="--bg-img: url('../images/home/engineering.jpg')">
                <div class="category-icon">⚙️</div>
                <h3>Engineering</h3>
                <p>890 jobs</p>
            </a>
            <a href="#" class="category-card" style="--bg-img: url('../images/home/government.jpg')">
                <div class="category-icon">🏛️</div>
                <h3>Government</h3>
                <p>345 jobs</p>
            </a>
            <a href="#" class="category-card" style="--bg-img: url('../images/home/remote.jpg')">
                <div class="category-icon">🏠</div>
                <h3>Remote</h3>
                <p>678 jobs</p>
            </a>
            <a href="#" class="category-card" style="--bg-img: url('../images/home/healthhire.jpg')">
                <div class="category-icon">🩺</div>
                <h3>HealthHire</h3>
                <p>678 jobs</p>
            </a>
        </div>
    </section>

    <!-- Featured Jobs -->
    <section class="featured-jobs">
        <h2>⭐ Featured Jobs for You</h2>
        <div class="jobs-grid">
            <div class="job-card">
                <div class="job-header">
                    <div>
                        <div class="job-title">Senior Frontend Developer</div>
                        <div class="job-company">TechCorp Inc.</div>
                        <div class="job-location">📍 San Francisco, CA</div>
                    </div>
                </div>
                <div class="job-tags">
                    <span class="job-tag">React</span>
                    <span class="job-tag">TypeScript</span>
                    <span class="job-tag">Remote</span>
                </div>
                <button class="apply-btn">Quick Apply</button>
            </div>

            <div class="job-card">
                <div class="job-header">
                    <div>
                        <div class="job-title">Digital Marketing Manager</div>
                        <div class="job-company">Marketing Pro</div>
                        <div class="job-location">📍 New York, NY</div>
                    </div>
                </div>
                <div class="job-tags">
                    <span class="job-tag">SEO</span>
                    <span class="job-tag">PPC</span>
                    <span class="job-tag">Full-time</span>
                </div>
                <button class="apply-btn">Quick Apply</button>
            </div>

            <div class="job-card">
                <div class="job-header">
                    <div>
                        <div class="job-title">Data Scientist</div>
                        <div class="job-company">AI Solutions</div>
                        <div class="job-location">📍 Remote</div>
                    </div>
                </div>
                <div class="job-tags">
                    <span class="job-tag">Python</span>
                    <span class="job-tag">ML</span>
                    <span class="job-tag">Remote</span>
                </div>
                <button class="apply-btn">Quick Apply</button>
            </div>
        </div>
    </section>

    <!-- Recent Activity -->
    <section class="recent-activity">
        <h2>📈 Recent Activity</h2>
        <div class="activity-item">
            <div class="activity-icon">📧</div>
            <div class="activity-text">
                <strong>Application Update</strong><br>
                Your application for "Frontend Developer" at TechStart has been reviewed
            </div>
            <div class="activity-time">2 hours ago</div>
        </div>
        <div class="activity-item">
            <div class="activity-icon">💾</div>
            <div class="activity-text">
                <strong>Job Saved</strong><br>
                You saved "UX Designer" position at Creative Agency
            </div>
            <div class="activity-time">1 day ago</div>
        </div>
        <div class="activity-item">
            <div class="activity-icon">🎯</div>
            <div class="activity-text">
                <strong>Profile Match</strong><br>
                New job matches found based on your preferences
            </div>
            <div class="activity-time">2 days ago</div>
        </div>
    </section>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">How It Works</a></li>
                <li><a href="#">Success Stories</a></li>
                <li><a href="#">Career Advice</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>For Job Seekers</h3>
            <ul>
                <li><a href="#">Browse Jobs</a></li>
                <li><a href="#">Resume Builder</a></li>
                <li><a href="#">Salary Guide</a></li>
                <li><a href="#">Interview Tips</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>For Employers</h3>
            <ul>
                <li><a href="#">Post a Job</a></li>
                <li><a href="#">Find Candidates</a></li>
                <li><a href="#">Recruitment Solutions</a></li>
                <li><a href="#">Pricing</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Support</h3>
            <ul>
                <li><a href="#">Help Center</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#">Report Issue</a></li>
                <li><a href="#">Live Chat</a></li>
            </ul>
        </div>
    </div>



    <div class="footer-bottom">
        <p>&copy; 2024 HireZa. All rights reserved. |
            <a href="#">Privacy Policy</a> |
            <a href="#">Terms of Service</a> |
            <a href="#">Cookie Policy</a>
        </p>
    </div>
</footer>

<script>
    // Add interactive functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Add smooth scrolling for navigation links
        const navLinks = document.querySelectorAll('.nav-links a');
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // Remove active class from all links
                navLinks.forEach(l => l.classList.remove('active'));
                // Add active class to clicked link
                this.classList.add('active');
            });
        });

        // Add hover effects to job cards
        const jobCards = document.querySelectorAll('.job-card');
        jobCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
            });
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Add click functionality to category cards
        const categoryCards = document.querySelectorAll('.category-card');
        categoryCards.forEach(card => {
            card.addEventListener('click', function(e) {
                e.preventDefault();
                const category = this.querySelector('h3').textContent;
                alert(`Navigating to ${category} listings...`);
            });
        });

        // Add search functionality
        const searchForm = document.querySelector('.search-form');
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const keyword = this.querySelector('input[placeholder*="Job title"]').value;
            const location = this.querySelector('input[placeholder*="Location"]').value;

            if (keyword || location) {
                alert(`Searching for: ${keyword || 'All jobs'} in ${location || 'All locations'}`);
            } else {
                alert('Please enter a keyword or location to search.');
            }
        });

        // Add quick apply functionality
        const applyButtons = document.querySelectorAll('.apply-btn');
        applyButtons.forEach(button => {
            button.addEventListener('click', function() {
                const jobCard = this.closest('.job-card');
                const jobTitle = jobCard.querySelector('.job-title').textContent;
                const company = jobCard.querySelector('.job-company').textContent;

                if (confirm(`Apply for ${jobTitle} at ${company}?`)) {
                    this.textContent = 'Applied ✓';
                    this.style.background = '#28a745';
                    this.disabled = true;
                }
            });
        });

        // Update stats with animation
        function animateStats() {
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const finalValue = parseInt(stat.textContent);
                let currentValue = 0;
                const increment = finalValue / 20;

                const timer = setInterval(() => {
                    currentValue += increment;
                    if (currentValue >= finalValue) {
                        stat.textContent = finalValue;
                        clearInterval(timer);
                    } else {
                        stat.textContent = Math.floor(currentValue);
                    }
                }, 50);
            });
        }

        // Start stats animation after page load
        setTimeout(animateStats, 500);
    });
</script>
</body>
</html>