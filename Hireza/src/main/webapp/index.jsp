<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CareerHub - Your Gateway to Success</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/stylesheet.css">


</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="#">
      <img src="images/index/logo.jpeg" alt="HireZa Logo" width="40" height="40" class="me-2" />
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
        <a class="btn btn-outline-primary me-2 custom-btn" href="jobseeker/signin.jsp">Login</a>
        <a class="btn btn-primary custom-btn" href="jobseeker/signup.jsp">Sign Up</a>
      </div>


    </div>
  </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero-section">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-6">
        <div class="hero-content fade-in">
          <h1 class="hero-title">Find Your Dream Career Today</h1>
          <p class="hero-subtitle">Connect with top companies and discover opportunities that match your skills and ambitions. Your next career move starts here.</p>
          <div class="d-flex gap-3">
            <button class="btn btn-primary btn-lg">Browse Jobs</button>
            <button class="btn btn-outline-light btn-lg">Post a Job</button>
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
      <div class="col-lg-3 col-md-6">
        <div class="stat-card fade-in">
          <div class="stat-number">25K+</div>
          <div class="stat-label">Active Jobs</div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="stat-card fade-in delay-1">
          <div class="stat-number">15K+</div>
          <div class="stat-label">Companies</div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="stat-card fade-in delay-2">
          <div class="stat-number">500K+</div>
          <div class="stat-label">Job Seekers</div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="stat-card fade-in delay-3">
          <div class="stat-number">98%</div>
          <div class="stat-label">Success Rate</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Job Categories -->
<section id="categories" class="categories-section">
  <div class="container">
    <h2 class="section-title fade-in">Explore by Category</h2>
    <p class="section-subtitle fade-in">Find opportunities in your field of expertise</p>
    <div class="row">
      <div class="col-lg-3 col-md-6 mb-4">
        <div class="category-card fade-in" style="background-image: url('images/index/ict.jpg');">

          <h5 class="category-title">Technology</h5>
          <p class="category-jobs">5,234 jobs available</p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 mb-4">
        <div class="category-card fade-in" style="background-image: url('images/index/marketing.jpg');">

          <h5 class="category-title">Marketing</h5>
          <p class="category-jobs">3,456 jobs available</p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 mb-4">
        <div class="category-card fade-in" style="background-image: url('images/index/healthcare.jpg');">

          <h5 class="category-title">Healthcare</h5>
          <p class="category-jobs">2,789 jobs available</p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 mb-4">
        <div class="category-card fade-in" style="background-image: url('images/index/education.jpg');">

          <h5 class="category-title">Education</h5>
          <p class="category-jobs">3,789 jobs available</p>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- Featured Jobs -->
<section id="jobs" class="jobs-section">
  <div class="container">
    <h2 class="section-title fade-in">Featured Jobs</h2>
    <p class="section-subtitle fade-in">Hand-picked opportunities from top companies</p>
    <div class="row">
      <div class="col-lg-6 mb-4">
        <div class="job-card fade-in">
          <div class="d-flex align-items-start">
            <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Google" class="company-logo-img me-3">
            <div class="flex-grow-1">
              <h5 class="job-title">Senior Software Engineer</h5>
              <p class="company-name">Google Inc.</p>
              <div class="job-meta">
                <span><i class="fas fa-map-marker-alt me-1"></i>Mountain View, CA</span>
                <span><i class="fas fa-dollar-sign me-1"></i>$120k - $180k</span>
              </div>
              <span class="job-type full-time">Full Time</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="job-card fade-in delay-1">
          <div class="d-flex align-items-start">
            <img src="https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Microsoft" class="company-logo-img me-3">
            <div class="flex-grow-1">
              <h5 class="job-title">UX Designer</h5>
              <p class="company-name">Microsoft</p>
              <div class="job-meta">
                <span><i class="fas fa-map-marker-alt me-1"></i>Seattle, WA</span>
                <span><i class="fas fa-dollar-sign me-1"></i>$95k - $140k</span>
              </div>
              <span class="job-type full-time">Full Time</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="job-card fade-in delay-2">
          <div class="d-flex align-items-start">
            <img src="https://images.unsplash.com/photo-1611224923853-80b023f02d71?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Apple" class="company-logo-img me-3">
            <div class="flex-grow-1">
              <h5 class="job-title">Marketing Manager</h5>
              <p class="company-name">Apple Inc.</p>
              <div class="job-meta">
                <span><i class="fas fa-map-marker-alt me-1"></i>Cupertino, CA</span>
                <span><i class="fas fa-dollar-sign me-1"></i>$85k - $125k</span>
              </div>
              <span class="job-type part-time">Part Time</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6 mb-4">
        <div class="job-card fade-in delay-3">
          <div class="d-flex align-items-start">
            <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Netflix" class="company-logo-img me-3">
            <div class="flex-grow-1">
              <h5 class="job-title">Data Scientist</h5>
              <p class="company-name">Netflix</p>
              <div class="job-meta">
                <span><i class="fas fa-map-marker-alt me-1"></i>Los Gatos, CA</span>
                <span><i class="fas fa-dollar-sign me-1"></i>$110k - $160k</span>
              </div>
              <span class="job-type full-time">Full Time</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="text-center mt-4">
      <button class="btn btn-primary btn-lg">View All Jobs</button>
    </div>
  </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
  <div class="container">
    <h2 class="cta-title fade-in">Ready to Take the Next Step?</h2>
    <p class="cta-subtitle fade-in">Join thousands of professionals who found their dream job through CareerHub</p>
    <button class="btn btn-cta fade-in delay-1">Get Started Today</button>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 mb-4">
        <h5><i class="fas fa-briefcase me-2"></i>CareerHub</h5>
        <p>Your trusted partner in finding the perfect career opportunity. We connect talented professionals with leading companies worldwide.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
      </div>
      <div class="col-lg-2 col-md-6 mb-4">
        <h5>Job Seekers</h5>
        <ul class="list-unstyled">
          <li><a href="#">Browse Jobs</a></li>
          <li><a href="#">Career Advice</a></li>
          <li><a href="#">Resume Builder</a></li>
          <li><a href="#">Salary Guide</a></li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-6 mb-4">
        <h5>Employers</h5>
        <ul class="list-unstyled">
          <li><a href="#">Post a Job</a></li>
          <li><a href="#">Search Resumes</a></li>
          <li><a href="#">Pricing</a></li>
          <li><a href="#">Employer Branding</a></li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-6 mb-4">
        <h5>Company</h5>
        <ul class="list-unstyled">
          <li><a href="#">About Us</a></li>
          <li><a href="#">Careers</a></li>
          <li><a href="#">Press</a></li>
          <li><a href="#">Contact</a></li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-6 mb-4">
        <h5>Support</h5>
        <ul class="list-unstyled">
          <li><a href="#">Help Center</a></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="#">Cookie Policy</a></li>
        </ul>
      </div>
    </div>
    <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
    <div class="row align-items-center">
      <div class="col-md-6">
        <p class="mb-0">&copy; 2025 Hireza. All rights reserved.</p>
      </div>
      <div class="col-md-6 text-md-end">
        <p class="mb-0">Made with <i class="fas fa-heart text-danger"></i> for job seekers worldwide</p>
      </div>
    </div>
  </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Smooth scrolling for navigation links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });

  // Intersection Observer for animations
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.animationPlayState = 'running';
      }
    });
  }, observerOptions);

  document.querySelectorAll('.fade-in').forEach(el => {
    observer.observe(el);
  });

  // Navbar background change on scroll
  window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
      navbar.style.background = 'rgba(255, 255, 255, 0.98)';
    } else {
      navbar.style.background = 'rgba(255, 255, 255, 0.95)';
    }
  });

  // Counter animation for stats
  function animateCounter(element, target) {
    let current = 0;
    const increment = target / 100;
    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        element.textContent = target.toLocaleString() + (element.textContent.includes('%') ? '%' : element.textContent.includes('K') ? 'K+' : '+');
        clearInterval(timer);
      } else {
        element.textContent = Math.floor(current).toLocaleString() + (element.textContent.includes('%') ? '%' : element.textContent.includes('K') ? 'K+' : '+');
      }
    }, 20);
  }

  // Trigger counter animation when stats section is visible
  const statsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const numbers = entry.target.querySelectorAll('.stat-number');
        numbers.forEach(num => {
          const target = parseInt(num.textContent.replace(/[^0-9]/g, ''));
          animateCounter(num, target);
        });
        statsObserver.unobserve(entry.target);
      }
    });
  });

  document.querySelector('.stats-section') && statsObserver.observe(document.querySelector('.stats-section'));
</script>
</body>
</html>