<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🔐 Mot de passe oublié | Plateforme Formation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-light: #a29bfe;
            --secondary: #fd79a8;
            --dark: #2d3436;
            --light: #f8f9fa;
            --gradient: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
            color: white;
        }

        .password-container {
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 2;
        }

        .password-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .password-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .password-header {
            background: var(--gradient);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .password-header h4 {
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .password-header i {
            margin-right: 12px;
            font-size: 1.8rem;
        }

        .password-body {
            padding: 2.5rem;
            color: var(--dark);
        }

        .form-group {
            position: relative;
            margin-bottom: 1.8rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            height: 55px;
            border-radius: 12px;
            border: 2px solid #dfe6e9;
            padding: 0 20px;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            background: white;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
        }

        .btn-send {
            background: var(--gradient);
            border: none;
            height: 55px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            transition: all 0.5s ease;
            box-shadow: 0 5px 20px rgba(108, 92, 231, 0.3);
            width: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-send i {
            margin-right: 10px;
        }

        .btn-send:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(108, 92, 231, 0.4);
        }

        .btn-send:active {
            transform: translateY(1px);
        }

        .btn-send::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-send:hover::after {
            left: 100%;
        }

        .back-link {
            text-align: center;
            margin-top: 1.5rem;
        }

        .back-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            position: relative;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            color: var(--secondary);
        }

        .back-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--secondary);
            transition: all 0.3s ease;
        }

        .back-link a:hover::after {
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
            background: rgba(108, 92, 231, 0.1);
            border-radius: 50%;
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% { transform: translateY(100vh) translateX(0); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100px) translateX(100px); opacity: 0; }
        }
    </style>
</head>
<body>
<!-- Floating particles background -->
<div class="particles" id="particles"></div>

<div class="password-container animate__animated animate__fadeIn">
    <div class="password-card">
        <div class="password-header">
            <h4><i class="fas fa-key"></i> Réinitialisation du mot de passe</h4>
        </div>
        
        <div class="password-body">
            <!-- Message d'erreur -->
            <c:if test="${param.error == 'email'}">
                <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> Adresse email introuvable. Veuillez réessayer.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Formulaire -->
            <form action="${pageContext.request.contextPath}/send-code" method="post" novalidate>
                <div class="form-group">
                    <label for="email" class="form-label">Adresse email</label>
                    <input type="email" class="form-control" name="email" id="email" required
                           placeholder="exemple@email.com" autocomplete="email">
                </div>
                <button type="submit" class="btn btn-send">
                    <i class="fas fa-paper-plane"></i> Envoyer le code
                </button>
            </form>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/views/users/login.jsp">
                    <i class="fas fa-arrow-left me-1"></i> Retour à la connexion
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize particles background
    document.addEventListener('DOMContentLoaded', function() {
        const particlesContainer = document.getElementById('particles');
        const particleCount = 15;
        
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

        // Auto-focus on email field
        document.getElementById('email').focus();
    });
</script>
</body>
</html>