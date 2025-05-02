<%@page import="entities.Inscription"%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Apprenant" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Formation" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Apprenant apprenant = (Apprenant) session.getAttribute("user");
    String role = (String) session.getAttribute("type");
    List<Inscription> inscriptions = (List<Inscription>) session.getAttribute("inscriptions");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");

    if (apprenant == null || !"apprenant".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Tableau de bord Apprenant</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #e0e7ff;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #560bad;
            --card-bg: #ffffff;
            --text: #333333;
            --sidebar-bg: linear-gradient(135deg, #3a0ca3 0%, #4361ee 100%);
            --sidebar-text: #ffffff;
            --sidebar-width: 280px;
            --header-height: 80px;
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            --shadow: 0 10px 20px rgba(0,0,0,0.08);
            --shadow-hover: 0 15px 30px rgba(0,0,0,0.12);
            --radius: 12px;
            --radius-sm: 8px;
        }

        .dark-mode {
            --light: #1a1a2e;
            --dark: #f8f9fa;
            --card-bg: #16213e;
            --text: #f0f0f0;
            --sidebar-bg: linear-gradient(135deg, #0f0c29 0%, #302b63 100%);
            --sidebar-text: #e6e6e6;
            --shadow: 0 10px 20px rgba(0,0,0,0.2);
            --shadow-hover: 0 15px 30px rgba(0,0,0,0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: var(--transition);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light);
            color: var(--text);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            z-index: 100;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            transform: translateX(0);
            transition: var(--transition);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 3px solid rgba(255,255,255,0.2);
        }

        .sidebar-header div h3 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.2rem;
        }

        .sidebar-header div p {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .sidebar-menu {
            list-style: none;
            margin-top: 2rem;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: var(--radius-sm);
            font-size: 0.95rem;
            font-weight: 500;
            opacity: 0.9;
        }

        .sidebar-menu li a i {
            margin-right: 0.8rem;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .sidebar-menu li a:hover, .sidebar-menu li a.active {
            background: rgba(255,255,255,0.1);
            opacity: 1;
            transform: translateX(5px);
        }

        .sidebar-menu li a.active {
            background: rgba(255,255,255,0.2);
            font-weight: 600;
        }

        .logout-btn {
            color: #ff6b6b !important;
        }

        .sidebar-info {
            margin-top: 2rem;
            padding: 1.2rem;
            background: rgba(255,255,255,0.1);
            border-radius: var(--radius-sm);
            position: relative;
            overflow: hidden;
        }

        .sidebar-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.05));
            z-index: 0;
        }

        .sidebar-info h4 {
            font-size: 0.9rem;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            position: relative;
        }

        .sidebar-info h4 i {
            margin-right: 0.6rem;
        }

        .sidebar-info p {
            font-size: 0.85rem;
            opacity: 0.9;
            position: relative;
        }

        .sidebar-info p strong {
            color: #fff;
            font-weight: 600;
        }

        .progress-container {
            margin-top: 1rem;
            height: 6px;
            background: rgba(255,255,255,0.1);
            border-radius: 3px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar {
            height: 100%;
            width: <%= inscriptions != null ? (inscriptions.size() > 0 ? "65%" : "0%") : "0%" %>;
            background: linear-gradient(90deg, #4cc9f0, #4895ef);
            border-radius: 3px;
            position: relative;
            animation: progressAnimation 2s ease-in-out;
        }

        @keyframes progressAnimation {
            0% { width: 0%; }
            100% { width: <%= inscriptions != null ? (inscriptions.size() > 0 ? "65%" : "0%") : "0%" %>; }
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: var(--transition);
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .dark-mode .header {
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--text);
            cursor: pointer;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
        }

        .header h1 i {
            margin-right: 1rem;
            color: var(--primary);
        }

        .toggle-dark {
            background: var(--card-bg);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: var(--shadow);
            color: var(--text);
        }

        .toggle-dark:hover {
            transform: scale(1.1);
        }

        /* Card Styles */
        .card {
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            overflow: hidden;
            transition: var(--transition);
        }

        .card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px);
        }

        .card-header {
            padding: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .dark-mode .card-header {
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .card-header h3 {
            font-size: 1.3rem;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .card-header h3 i {
            margin-right: 0.8rem;
            color: var(--primary);
        }

        .badge {
            padding: 0.5rem 1rem;
            font-weight: 600;
            border-radius: 50px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            padding: 1.5rem;
        }

        .info-item {
            background: rgba(67, 97, 238, 0.05);
            padding: 1.2rem;
            border-radius: var(--radius-sm);
            transition: var(--transition);
        }

        .dark-mode .info-item {
            background: rgba(67, 97, 238, 0.1);
        }

        .info-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .info-item h4 {
            font-size: 0.9rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .info-item p {
            font-size: 1rem;
            font-weight: 500;
        }

        /* Welcome Message */
        .welcome-message {
            text-align: center;
            padding: 2rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            border-radius: var(--radius);
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
        }

        .welcome-message {
    position: relative;
    text-align: center;
    padding: 4rem 2rem;
    background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
    color: white;
    border-radius: var(--radius);
    margin-bottom: 2rem;
    box-shadow: var(--shadow);
    overflow: hidden;
}

/* Glow effect */
.glow-effect {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 10%, transparent 70%);
    transform: rotate(45deg);
    animation: glowAnimation 8s infinite alternate;
}

@keyframes glowAnimation {
    0% { transform: rotate(45deg) scale(1); }
    100% { transform: rotate(45deg) scale(1.2); }
}

/* Text animation */
.text-animation {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    background: linear-gradient(90deg, #fff 20%, #f0f0f0 50%, #fff 80%);
    background-size: 200% auto;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: textShine 2s infinite;
}

@keyframes textShine {
    to {
        background-position: 200% center;
    }
}

/* Subtitle animation */
.subtitle-animation {
    font-size: 1.2rem;
    opacity: 0.9;
    max-width: 800px;
    margin: 0 auto;
    position: relative;
    animation: fadeInUp 1.5s ease-in-out;
}

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

/* Particles effect */
.particles {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

.particles::before,
.particles::after {
    content: '';
    position: absolute;
    width: 20px;
    height: 20px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    animation: particleFloat 10s infinite alternate;
}

.particles::before {
    top: 10%;
    left: 20%;
    animation-delay: 0s;
}

.particles::after {
    top: 60%;
    right: 30%;
    animation-delay: 2s;
}

@keyframes particleFloat {
    0% {
        transform: translate(0, 0) scale(1);
        opacity: 0.8;
    }
    100% {
        transform: translate(10px, -10px) scale(1.2);
        opacity: 0.2;
    }
}

        /* FAQ Styles */
        .faq-container {
            padding: 1.5rem;
        }

        .faq-item {
            margin-bottom: 1rem;
            border-radius: var(--radius-sm);
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: var(--transition);
        }

        .dark-mode .faq-item {
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .faq-item:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .faq-question {
            padding: 1.2rem;
            background: var(--card-bg);
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            font-weight: 500;
            border-left: 4px solid var(--primary);
        }

        .faq-question i {
            transition: var(--transition);
        }

        .faq-answer {
            padding: 0;
            max-height: 0;
            overflow: hidden;
            background: rgba(67, 97, 238, 0.03);
            transition: max-height 0.3s ease, padding 0.3s ease;
        }

        .dark-mode .faq-answer {
            background: rgba(67, 97, 238, 0.1);
        }

        .faq-item.active .faq-answer {
            padding: 1.2rem;
            max-height: 500px;
        }

        .faq-item.active .faq-question i {
            transform: rotate(180deg);
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .menu-toggle {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.5rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .welcome-message h2 {
                font-size: 2rem;
            }

            .welcome-message p {
                font-size: 1rem;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Floating animation for sidebar elements */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .sidebar-info:hover {
            animation: float 3s ease-in-out infinite;
        }

        /* Pulse animation for active item */
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(67, 97, 238, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(67, 97, 238, 0); }
            100% { box-shadow: 0 0 0 0 rgba(67, 97, 238, 0); }
        }

        .sidebar-menu li a.active {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=<%= apprenant.getNom()%>&background=random&color=fff" alt="Profile">
            <div>
                <h3><%= apprenant.getNom()%></h3>
                <p>Apprenant</p>
            </div>
        </div>

        <ul class="sidebar-menu">
            <li>
                <a href="#" class="active">
                    <i class="fas fa-tachometer-alt"></i>
                    Tableau de bord
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/formations.jsp">
                    <i class="fas fa-book"></i>
                    Mes formations
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/calendar.jsp">
                    <i class="fas fa-calendar-alt"></i>
                    Calendrier
                </a>
            </li>
            
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/parametres.jsp">
                    <i class="fas fa-cog"></i>
                    Paramètres
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath()%>/logout.jsp" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Déconnexion
                </a>
            </li>
        </ul>

        <div class="sidebar-info">
            <h4>
                <i class="fas fa-info-circle"></i>
                Informations
            </h4>
            <p>
                Vous avez <strong><%= inscriptions != null ? inscriptions.size() : 0%> formations</strong> en cours.
            </p>
            <div class="progress-container">
                <div class="progress-bar"></div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1><i class="fas fa-graduation-cap"></i> Tableau de bord Apprenant</h1>
            <button class="toggle-dark" id="toggleDark">
                <i class="fas fa-moon"></i>
            </button>
        </div>

        <!-- Welcome Message -->
        <div class="welcome-message" id="welcomeMessage">
    <div class="glow-effect"></div>
    <h2 class="text-animation">Bienvenue sur SkillForge</h2>
    <p class="subtitle-animation">Développez vos compétences et forgez votre avenir avec nos formations personnalisées.</p>
    <div class="particles"></div>
</div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-user-graduate"></i> Profil Apprenant</h3>
                <span class="badge bg-primary">Actif</span>
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <h4>Nom complet</h4>
                    <p><%= apprenant.getNom()%></p>
                </div>
                <div class="info-item">
                    <h4>Email</h4>
                    <p><%= apprenant.getEmail()%></p>
                </div>
                <div class="info-item">
                    <h4>Rôle</h4>
                    <p><%= role%></p>
                </div>
                
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-question-circle"></i> Foire aux questions</h3>
            </div>
            <div class="faq-container">
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Comment accéder à mes formations ?</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Vous pouvez accéder à toutes vos formations en cours depuis l'onglet "Mes formations" dans le menu de navigation. Une fois connecté, cliquez simplement sur le bouton "Continuer" pour reprendre là où vous vous étiez arrêté.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Comment suivre ma progression ?</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Votre progression est visible dans la section "Progression" de votre tableau de bord. Vous y trouverez des statistiques détaillées sur votre avancement dans chaque formation, ainsi que des indicateurs de performance.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Puis-je télécharger du contenu pour le consulter hors ligne ?</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Oui, la plupart de nos formations proposent des ressources téléchargeables (PDF, fichiers d'exercices, etc.). Ces ressources sont disponibles dans la section "Ressources" de chaque formation.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Comment obtenir un certificat de formation ?</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Les certificats sont automatiquement générés lorsque vous terminez une formation avec un score minimum de 80%. Vous pouvez télécharger votre certificat depuis la page de la formation complétée, dans la section "Certificat".</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question">
                        <span>Que faire en cas de problème technique ?</span>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Notre équipe support est disponible 24/7. Vous pouvez nous contacter via le formulaire dans la section "Aide" ou directement par email à support@skillforge.com. Nous répondons généralement dans les 24 heures.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle dark mode
        const toggleDark = document.getElementById('toggleDark');
        const body = document.body;
        
        // Check for saved user preference or use OS preference
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const currentTheme = localStorage.getItem('theme');
        
        if (currentTheme === 'dark' || (!currentTheme && prefersDark)) {
            body.classList.add('dark-mode');
            toggleDark.innerHTML = '<i class="fas fa-sun"></i>';
        }

        toggleDark.addEventListener('click', () => {
            body.classList.toggle('dark-mode');
            if (body.classList.contains('dark-mode')) {
                localStorage.setItem('theme', 'dark');
                toggleDark.innerHTML = '<i class="fas fa-sun"></i>';
            } else {
                localStorage.setItem('theme', 'light');
                toggleDark.innerHTML = '<i class="fas fa-moon"></i>';
            }
        });
        
        // Mobile menu toggle
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.querySelector('.sidebar');
        
        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 992 && !sidebar.contains(e.target) && e.target !== menuToggle) {
                sidebar.classList.remove('active');
            }
        });
        
        // FAQ accordion functionality
        const faqItems = document.querySelectorAll('.faq-item');
        faqItems.forEach(item => {
            const question = item.querySelector('.faq-question');
            question.addEventListener('click', () => {
                // Close all other items
                faqItems.forEach(otherItem => {
                    if (otherItem !== item) {
                        otherItem.classList.remove('active');
                    }
                });
                
                // Toggle current item
                item.classList.toggle('active');
            });
        });

        // Add ripple effect to buttons
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                let x = e.clientX - e.target.getBoundingClientRect().left;
                let y = e.clientY - e.target.getBoundingClientRect().top;
                
                let ripple = document.createElement('span');
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 1000);
            });
        });
    </script>
</body>
</html>