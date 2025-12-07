<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign Up - HireLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f4f7fa;
            overflow: hidden;
            position: relative;
        }

        .dots-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .dot {
            position: absolute;
            width: 10px;
            height: 10px;
            background: rgba(42, 82, 152, 0.2);
            border-radius: 50%;
            animation: floatUp linear infinite;
        }

        @keyframes floatUp {
            0% {
                transform: translateY(100vh) scale(1);
                opacity: 1;
            }
            100% {
                transform: translateY(-10vh) scale(0.5);
                opacity: 0;
            }
        }

        .signup-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 2.5rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(30, 60, 114, 0.15);
            position: relative;
            z-index: 2;
        }

        .signup-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1e3c72;
            font-size: 2rem;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 600;
        }

        .form-group input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            border-color: #2a5298;
            outline: none;
        }

        .btn-submit {
            width: 100%;
            padding: 0.9rem;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #2a5298, #1e3c72);
        }

        .login-link {
            text-align: center;
            margin-top: 1.2rem;
            font-size: 0.95rem;
        }

        .login-link a {
            color: #2a5298;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 480px) {
            .signup-container {
                margin: 50px 20px;
                padding: 2rem;
            }
        }
    </style>
</head>
<body>

<!-- Floating Blue Dots Background -->
<div class="dots-bg" id="dots-bg"></div>

<div class="signup-container">
    <h2>Create Your Account</h2>
    <form action="#" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="fullname" name="fullname" required />
        </div>
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required />
        </div>
        <div class="form-group">
            <label for="password">Create Password</label>
            <input type="password" id="password" name="password" required />
        </div>
        <button type="submit" class="btn-submit">Sign Up</button>
        <div class="login-link">
            Already have an account? <a href="#">Sign In</a>
        </div>
    </form>
</div>

<!-- JS to generate dots -->
<script>
    const dotsContainer = document.getElementById('dots-bg');

    for (let i = 0; i < 30; i++) {
        const dot = document.createElement('div');
        dot.classList.add('dot');
        const size = Math.random() * 8 + 4;
        dot.style.width = `${size}px`;
        dot.style.height = `${size}px`;
        dot.style.left = `${Math.random() * 100}%`;
        dot.style.animationDuration = `${8 + Math.random() * 10}s`;
        dot.style.animationDelay = `${Math.random() * 10}s`;
        dotsContainer.appendChild(dot);
    }
</script>

</body>
</html>
