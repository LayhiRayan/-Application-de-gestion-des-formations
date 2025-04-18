<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | Plateforme Formation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-light: #a29bfe;
            --secondary: #fd79a8;
            --success: #00b894;
            --danger: #d63031;
            --warning: #fdcb6e;
            --dark: #2d3436;
            --light: #f8f9fa;
            --gradient: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #dfe6e9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 2;
        }

        .brand-section {
            text-align: center;
            margin-bottom: 2.5rem;
            animation: fadeInDown 0.8s ease;
        }

        .brand-icon {
            font-size: 4.5rem;
            background: var(--gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            filter: drop-shadow(0 5px 15px rgba(108, 92, 231, 0.3));
            margin-bottom: 1rem;
            display: inline-block;
            animation: bounce 2s infinite alternate;
        }

        @keyframes bounce {
            0% { transform: translateY(0) scale(1); }
            100% { transform: translateY(-15px) scale(1.05); }
        }

        .brand-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -1px;
        }

        .brand-subtitle {
            color: #636e72;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: none;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        }

        .login-header {
            background: var(--gradient);
            color: white;
            padding: 1.8rem;
            text-align: center;
            position: relative;
        }

        .login-header h3 {
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
        }

        .login-body {
            padding: 2.5rem;
        }

        .form-group {
            position: relative;
            margin-bottom: 1.8rem;
        }

        .form-label {
            position: absolute;
            top: 15px;
            left: 15px;
            color: #636e72;
            font-weight: 500;
            transition: all 0.3s ease;
            pointer-events: none;
            background: white;
            padding: 0 5px;
            border-radius: 5px;
            z-index: 2;
        }

        .form-control {
            height: 55px;
            border-radius: 12px;
            border: 2px solid #dfe6e9;
            padding: 0 20px;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            background: white;
            position: relative;
            z-index: 1;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
        }

        .form-control:focus + .form-label,
        .form-control:not(:placeholder-shown) + .form-label {
            top: -10px;
            left: 15px;
            font-size: 0.85rem;
            color: var(--primary);
            background: white;
            z-index: 3;
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
            color: #b2bec3;
            cursor: pointer;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--primary);
            transform: translateY(-50%) scale(1.1);
        }

        .role-select {
            margin-bottom: 2rem;
        }

        .form-select {
            height: 55px;
            border-radius: 12px;
            border: 2px solid #dfe6e9;
            padding: 0 20px;
            font-size: 1rem;
            font-weight: 500;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%236c5ce7' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 16px 12px;
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
        }

        .btn-login {
            background: var(--gradient);
            border: none;
            height: 55px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            transition: all 0.5s ease;
            box-shadow: 0 5px 20px rgba(108, 92, 231, 0.3);
            width: 100%;
            margin-bottom: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(108, 92, 231, 0.4);
        }

        .btn-login:active {
            transform: translateY(1px);
        }

        .btn-login::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-login:hover::after {
            left: 100%;
        }

        .login-links {
            display: flex;
            justify-content: space-between;
        }

        .login-link {
            color: #636e72;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link:hover {
            color: var(--primary);
        }

        .login-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: all 0.3s ease;
        }

        .login-link:hover::after {
            width: 100%;
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.5s ease;
        }

        /* Floating particles background */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            background: rgba(108, 92, 231, 0.15);
            border-radius: 50%;
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(100vh) translateX(0); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100px) translateX(100px); opacity: 0; }
        }

        /* Focus effect */
        .focus-effect {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 10px;
            background: rgba(108, 92, 231, 0.1);
            transform: scale(0.9);
            opacity: 0;
            transition: all 0.4s ease;
            pointer-events: none;
            z-index: 0;
        }

        .form-group.focused .focus-effect {
            transform: scale(1);
            opacity: 1;
        }
    </style>
</head>
<body>
<!-- Floating particles background -->
<div class="particles" id="particles"></div>

<div class="login-container animate__animated animate__fadeIn">
    <!-- Brand section -->
    <div class="brand-section">
        <i class="fas fa-graduation-cap brand-icon"></i>
        <h1 class="brand-title">SkillForge</h1>
        <p class="brand-subtitle">formations professionnelles</p>
    </div>

    <!-- Login card -->
    <div class="login-card">
        <div class="login-header">
            <h3><i class="fas fa-lock"></i> Connexion</h3>
        </div>
        
        <div class="login-body">
            <!-- Alert messages -->
            <c:if test="${param.success == 'reset'}">
                <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> Mot de passe modifié avec succès. Vous pouvez maintenant vous connecter.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.error == 'auth'}">
                <div class="alert alert-danger alert-custom" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> Email ou mot de passe incorrect
                </div>
            </c:if>
            
            <c:if test="${param.error == 'type'}">
                <div class="alert alert-warning alert-custom" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> Type d'utilisateur inconnu
                </div>
            </c:if>

            <c:if test="${not empty param.msg}">
                <div class="alert alert-danger alert-custom" role="alert">
                    <i class="fas fa-times-circle me-2"></i> ${param.msg}
                </div>
            </c:if>

            <!-- Login form -->
            <form action="${pageContext.request.contextPath}/LoginController" method="post">
                <!-- Email field -->
                <div class="form-group">
                    <input type="email" class="form-control" id="email" name="email" placeholder=" " required>
                    <label for="email" class="form-label">Adresse email</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Password field -->
                <div class="form-group">
                    <input type="password" class="form-control" id="password" name="mdp" placeholder=" " required>
                    <label for="password" class="form-label">Mot de passe</label>
                    <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                    <div class="focus-effect"></div>
                </div>

                <!-- Role selection -->
                <div class="form-group role-select">
                    <label class="form-label">Rôle</label>
                    <select name="role" class="form-select" required>
                        <option value="" selected disabled>Choisissez votre rôle</option>
                        <option value="apprenant">Apprenant</option>
                        <option value="formateur">Formateur</option>
                        <option value="admin">Administrateur</option>
                    </select>
                    <div class="focus-effect"></div>
                </div>

                <!-- Submit button -->
                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                </button>

                <!-- Links -->
                <div class="login-links">
                    <a href="${pageContext.request.contextPath}/views/users/inscription.jsp" class="login-link">
                        <i class="fas fa-user-plus me-1"></i>Créer un compte
                    </a>
                    <a href="${pageContext.request.contextPath}/views/users/forgotPassword.jsp" class="login-link">
                        <i class="fas fa-key me-1"></i>Mot de passe oublié ?
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize particles background
    document.addEventListener('DOMContentLoaded', function() {
        const particlesContainer = document.getElementById('particles');
        const particleCount = 20;
        
        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            
            // Random size between 5 and 15px
            const size = Math.random() * 10 + 5;
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;
            
            // Random position
            particle.style.left = `${Math.random() * 100}%`;
            particle.style.bottom = `-${size}px`;
            
            // Random animation duration and delay
            const duration = Math.random() * 15 + 10;
            const delay = Math.random() * 10;
            particle.style.animation = `float ${duration}s ${delay}s infinite linear`;
            
            particlesContainer.appendChild(particle);
        }

        // Toggle password visibility
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');
        
        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye-slash');
            this.classList.toggle('fa-eye');
        });

        // Focus effects
        const formGroups = document.querySelectorAll('.form-group');
        
        formGroups.forEach(group => {
            const input = group.querySelector('.form-control, .form-select');
            
            input.addEventListener('focus', function() {
                group.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                group.classList.remove('focused');
            });
        });

        // Auto-focus on email field
        document.getElementById('email').focus();

        // Button hover effect
        const loginBtn = document.querySelector('.btn-login');
        loginBtn.addEventListener('mouseenter', function() {
            this.querySelector('i').classList.add('animate__animated', 'animate__rubberBand');
        });
        
        loginBtn.addEventListener('mouseleave', function() {
            this.querySelector('i').classList.remove('animate__animated', 'animate__rubberBand');
        });
    });
</script>
</body>
</html>