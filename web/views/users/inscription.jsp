<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription | Plateforme Formation</title>
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

        .register-container {
            width: 100%;
            max-width: 500px;
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

        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: none;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .register-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        }

        .register-header {
            background: var(--gradient);
            color: white;
            padding: 1.8rem;
            text-align: center;
            position: relative;
        }

        .register-header h3 {
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-header i {
            margin-right: 12px;
        }

        .register-body {
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
            appearance: none;
        }

        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
        }

        .btn-register {
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-register i {
            margin-right: 10px;
        }

        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(108, 92, 231, 0.4);
        }

        .btn-register:active {
            transform: translateY(1px);
        }

        .btn-register::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-register:hover::after {
            left: 100%;
        }

        .login-link {
            text-align: center;
            color: #636e72;
            font-weight: 500;
            margin-top: 1.5rem;
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            position: relative;
        }

        .login-link a:hover {
            text-decoration: none;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: all 0.3s ease;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        .hidden {
            display: none;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
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

<div class="register-container animate__animated animate__fadeIn">
    <!-- Brand section -->
    <div class="brand-section">
        <i class="fas fa-graduation-cap brand-icon"></i>
        <h1 class="brand-title">SkillForge</h1>
        <p class="brand-subtitle">formations professionnelles</p>
    </div>

    <!-- Register card -->
    <div class="register-card">
        <div class="register-header">
            <h3><i class="fas fa-user-plus"></i> Créer un compte</h3>
        </div>
        
        <div class="register-body">
            <form action="${pageContext.request.contextPath}/InscriptionController" method="post">
                <!-- Nom complet -->
                <div class="form-group">
                    <input type="text" class="form-control" id="nom" name="nom" placeholder=" " required>
                    <label for="nom" class="form-label">Nom complet</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <input type="email" class="form-control" id="email" name="email" placeholder=" " required>
                    <label for="email" class="form-label">Adresse email</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Mot de passe -->
                <div class="form-group">
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse" placeholder=" " required>
                    <label for="motDePasse" class="form-label">Mot de passe</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Rôle -->
                <div class="form-group">
                    <select id="role" name="role" class="form-select" onchange="toggleSpecialite()" required>
                        <option value="" selected disabled> </option>
                        <option value="apprenant">Apprenant</option>
                        <option value="formateur">Formateur</option>
                    </select>
                    <label for="role" class="form-label">Rôle</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Spécialité (caché par défaut) -->
                <div id="specialiteDiv" class="form-group hidden">
                    <input type="text" class="form-control" id="specialite" name="specialite" placeholder=" ">
                    <label for="specialite" class="form-label">Spécialité</label>
                    <div class="focus-effect"></div>
                </div>

                <!-- Bouton d'inscription -->
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-check"></i> S'inscrire
                </button>
            </form>
            
            <div class="login-link">
                Déjà inscrit ? <a href="${pageContext.request.contextPath}/views/users/login.jsp">Connectez-vous</a>
            </div>
        </div>
    </div>
</div>

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

        // Auto-focus on first field
        document.getElementById('nom').focus();
    });

    function toggleSpecialite() {
        var role = document.getElementById("role").value;
        var specialiteDiv = document.getElementById("specialiteDiv");
        
        if (role === "formateur") {
            specialiteDiv.classList.remove("hidden");
            document.getElementById("specialite").required = true;
            // Animation when showing
            specialiteDiv.style.animation = 'fadeIn 0.5s ease';
        } else {
            specialiteDiv.classList.add("hidden");
            document.getElementById("specialite").required = false;
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>