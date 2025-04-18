<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🔐 Nouveau mot de passe | Plateforme Formation</title>
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

        .password-container {
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s ease;
        }

        .password-card {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .password-card:hover {
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

        .form-group {
            position: relative;
            margin-bottom: 1.8rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
            transition: all 0.3s ease;
        }

        .form-control {
            width: 100%;
            height: 50px;
            border-radius: 12px;
            border: 2px solid #dfe6e9;
            padding: 0 20px;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.2);
            transform: translateY(-2px);
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            color: #b2bec3;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--primary);
            transform: translateY(-50%) scale(1.1);
        }

        .btn-reset {
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

        .btn-reset i {
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .btn-reset:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(108, 92, 231, 0.4);
        }

        .btn-reset:hover i {
            transform: rotate(360deg);
        }

        .btn-reset:active {
            transform: translateY(1px);
        }

        .btn-reset::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        .btn-reset:hover::after {
            left: 100%;
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1rem 1.5rem;
            animation: fadeIn 0.5s ease;
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

        /* Password strength indicator */
        .password-strength {
            height: 5px;
            background: #f1f1f1;
            border-radius: 5px;
            margin-top: 5px;
            overflow: hidden;
        }

        .strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
<div class="password-container">
    <div class="password-card">
        <div class="card-header">
            <h4><i class="fas fa-key"></i> Nouveau mot de passe</h4>
        </div>
        <div class="card-body">
            <!-- Erreur si mots de passe différents -->
            <c:if test="${param.error == 'confirm'}">
                <div class="alert alert-danger alert-custom shake">
                    <i class="fas fa-exclamation-circle me-2"></i> Les mots de passe ne correspondent pas.
                </div>
            </c:if>

            <form id="resetForm" action="${pageContext.request.contextPath}/reset-password" method="post">
                <div class="form-group">
                    <label for="newPassword" class="form-label">Nouveau mot de passe :</label>
                    <div class="position-relative">
                        <input type="password" name="newPassword" id="newPassword" class="form-control" required>
                        <i class="fas fa-eye password-toggle" id="togglePassword1"></i>
                    </div>
                    <div class="password-strength">
                        <div class="strength-bar" id="strengthBar"></div>
                    </div>
                    <small class="text-muted">Minimum 8 caractères avec majuscule, minuscule et chiffre</small>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Confirmer le mot de passe :</label>
                    <div class="position-relative">
                        <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required>
                        <i class="fas fa-eye password-toggle" id="togglePassword2"></i>
                    </div>
                </div>

                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-reset">
                        <i class="fas fa-sync-alt"></i> Réinitialiser le mot de passe
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Toggle password visibility
    const togglePassword1 = document.getElementById('togglePassword1');
    const togglePassword2 = document.getElementById('togglePassword2');
    const password1 = document.getElementById('newPassword');
    const password2 = document.getElementById('confirmPassword');
    
    togglePassword1.addEventListener('click', function() {
        const type = password1.getAttribute('type') === 'password' ? 'text' : 'password';
        password1.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
        this.classList.toggle('fa-eye');
    });
    
    togglePassword2.addEventListener('click', function() {
        const type = password2.getAttribute('type') === 'password' ? 'text' : 'password';
        password2.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
        this.classList.toggle('fa-eye');
    });

    // Password strength indicator
    password1.addEventListener('input', function() {
        const strengthBar = document.getElementById('strengthBar');
        const strength = checkPasswordStrength(this.value);
        
        // Update strength bar
        strengthBar.style.width = `${strength.percentage}%`;
        strengthBar.style.backgroundColor = strength.color;
    });

    function checkPasswordStrength(password) {
        let strength = 0;
        
        // Length check
        if (password.length >= 8) strength += 25;
        if (password.length >= 12) strength += 15;
        
        // Complexity checks
        if (/[A-Z]/.test(password)) strength += 20;
        if (/[a-z]/.test(password)) strength += 20;
        if (/[0-9]/.test(password)) strength += 10;
        if (/[^A-Za-z0-9]/.test(password)) strength += 10;
        
        // Determine color
        let color;
        if (strength < 50) color = '#ff5252'; // Red
        else if (strength < 75) color = '#ffb142'; // Orange
        else color = '#05c46b'; // Green
        
        return { percentage: Math.min(strength, 100), color };
    }

    // Form validation
    const form = document.getElementById('resetForm');
    form.addEventListener('submit', function(e) {
        const p1 = password1.value;
        const p2 = password2.value;
        
        if (p1 !== p2) {
            e.preventDefault();
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger alert-custom shake mb-4';
            alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i> Les mots de passe ne correspondent pas';
            
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