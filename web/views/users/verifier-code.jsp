<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vérification du code | Plateforme Formation</title>
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
            background: linear-gradient(135deg, #f5f7fa 0%, #dfe6e9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
        }

        .verification-container {
            width: 100%;
            max-width: 500px;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s ease;
        }

        .verification-card {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .verification-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background: var(--gradient);
            color: white;
            padding: 1.8rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: rotate 15s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .card-header h4 {
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .card-header i {
            margin-right: 12px;
            font-size: 1.8rem;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .card-body {
            padding: 2.5rem;
            color: var(--dark);
        }

        .code-input-container {
            display: flex;
            justify-content: center;
            margin: 2rem 0;
            gap: 10px;
        }

        .code-input {
            width: 50px;
            height: 60px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            border: 2px solid #dfe6e9;
            border-radius: 12px;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .code-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
            transform: translateY(-2px);
        }

        .btn-verify {
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

        .btn-verify i {
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .btn-verify:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(108, 92, 231, 0.4);
        }

        .btn-verify:hover i {
            transform: rotate(360deg);
        }

        .btn-verify:active {
            transform: translateY(1px);
        }

        .btn-verify::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-verify:hover::after {
            left: 100%;
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1rem 1.5rem;
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

        /* Shake animation for errors */
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .shake {
            animation: shake 0.5s ease;
        }
    </style>
</head>
<body>
<!-- Floating particles background -->
<div class="particles" id="particles"></div>

<div class="verification-container">
    <div class="verification-card">
        <div class="card-header">
            <h4><i class="fas fa-shield-alt"></i> Vérification du code</h4>
        </div>
        <div class="card-body">
            <!-- Messages d'erreur -->
            <c:if test="${param.error == 'code'}">
                <div class="alert alert-danger alert-custom shake">
                    <i class="fas fa-exclamation-circle me-2"></i> Code incorrect. Veuillez réessayer.
                </div>
            </c:if>
            <c:if test="${param.error == 'expired'}">
                <div class="alert alert-warning alert-custom">
                    <i class="fas fa-clock me-2"></i> Le code a expiré. Veuillez en demander un nouveau.
                </div>
            </c:if>

            <form id="codeForm" action="${pageContext.request.contextPath}/valider-code" method="post">
                <p class="text-center mb-4" style="font-size: 1.1rem;">Entrez le code à 6 chiffres reçu par email</p>
                
                <div class="code-input-container">
                    <input type="text" name="digit1" class="code-input animate__animated animate__fadeIn" maxlength="1" pattern="\d" required>
                    <input type="text" name="digit2" class="code-input animate__animated animate__fadeIn animate__delay-1s" maxlength="1" pattern="\d" required>
                    <input type="text" name="digit3" class="code-input animate__animated animate__fadeIn animate__delay-2s" maxlength="1" pattern="\d" required>
                    <input type="text" name="digit4" class="code-input animate__animated animate__fadeIn animate__delay-3s" maxlength="1" pattern="\d" required>
                    <input type="text" name="digit5" class="code-input animate__animated animate__fadeIn animate__delay-4s" maxlength="1" pattern="\d" required>
                    <input type="text" name="digit6" class="code-input animate__animated animate__fadeIn animate__delay-5s" maxlength="1" pattern="\d" required>
                </div>
                
                <!-- Champ caché pour envoyer le code complet -->
                <input type="hidden" name="code" id="fullCode">
                
                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-verify animate__animated animate__fadeInUp animate__delay-6s">
                        <i class="fas fa-check-circle"></i> Valider le code
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Create floating particles
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

    const inputs = document.querySelectorAll('.code-input');
    const form = document.getElementById('codeForm');
    const fullCodeInput = document.getElementById('fullCode');
    
    // Auto-focus et navigation entre les inputs
    inputs.forEach((input, index) => {
        // Focus sur le premier champ
        if (index === 0) input.focus();
        
        input.addEventListener('input', function() {
            // N'autoriser que les chiffres
            this.value = this.value.replace(/\D/g, '');
            
            // Passer au champ suivant si un chiffre est entré
            if (this.value.length === 1 && index < inputs.length - 1) {
                inputs[index + 1].focus();
            }
            
            // Ajouter une animation quand un chiffre est saisi
            if (this.value.length === 1) {
                this.classList.add('animate__animated', 'animate__pulse');
                setTimeout(() => {
                    this.classList.remove('animate__animated', 'animate__pulse');
                }, 1000);
            }
        });
        
        // Gérer les flèches et backspace
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
                inputs[index - 1].focus();
            }
            if (e.key === 'ArrowLeft' && index > 0) {
                inputs[index - 1].focus();
            }
            if (e.key === 'ArrowRight' && index < inputs.length - 1) {
                inputs[index + 1].focus();
            }
        });
    });
    
    // Combiner les chiffres avant soumission
    form.addEventListener('submit', function(e) {
        let code = '';
        inputs.forEach(input => {
            code += input.value;
        });
        fullCodeInput.value = code;
        
        // Validation supplémentaire
        if (code.length !== 6) {
            e.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-custom shake mb-4';
            alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i> Veuillez entrer un code à 6 chiffres complet';
            
            const existingAlert = document.querySelector('.alert-custom');
            if (existingAlert) {
                existingAlert.replaceWith(alertDiv);
            } else {
                form.prepend(alertDiv);
            }
        }
    });
});
</script>
</body>
</html>