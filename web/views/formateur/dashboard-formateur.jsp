<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Formateur, java.util.List, entities.Formation, services.FormationService, services.InscriptionService" %>
<%
    Formateur formateur = (Formateur) session.getAttribute("user");
    if (formateur == null) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }

    FormationService formationService = new FormationService();
    InscriptionService inscriptionService = new InscriptionService();
    List<Formation> formations = formationService.findByFormateur(formateur.getId());
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Formateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-light: #a29bfe;
            --secondary: #4a3ce7;
            --accent: #00cec9;
            --dark: #2d3436;
            --light: #f8f9fa;
            --sidebar-bg: linear-gradient(135deg, #2d3436 0%, #6c5ce7 100%);
            --sidebar-text: rgba(255, 255, 255, 0.9);
            --glass: rgba(255, 255, 255, 0.08);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-hover: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --radius: 12px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            color: var(--dark);
            display: flex;
            min-height: 100vh;
            margin: 0;
            background-image: radial-gradient(circle at 10% 20%, rgba(166, 177, 255, 0.1) 0%, rgba(214, 214, 255, 0.1) 90%);
        }

        .sidebar {
            width: 280px;
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            height: 100vh;
            padding: 2rem 1.5rem;
            position: fixed;
            box-shadow: var(--shadow);
            z-index: 10;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass);
        }

        .sidebar h4 {
            font-weight: 600;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--glass);
            text-align: center;
            font-size: 1.3rem;
            letter-spacing: 0.5px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: var(--sidebar-text);
            padding: 1rem 1.5rem;
            text-decoration: none;
            margin-bottom: 0.5rem;
            border-radius: var(--radius);
            transition: var(--transition);
            background: var(--glass);
            backdrop-filter: blur(5px);
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .sidebar a.active {
            background: linear-gradient(90deg, var(--primary), rgba(108, 92, 231, 0.7));
            box-shadow: 0 10px 20px rgba(108, 92, 231, 0.3);
            font-weight: 500;
            transform: translateX(8px);
        }

        .sidebar a i {
            margin-right: 1rem;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 280px;
            padding: 3rem;
            flex: 1;
            transition: var(--transition);
        }

        .welcome-header {
            background: linear-gradient(90deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            position: relative;
        }

        .welcome-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }

        .section-title {
            color: var(--dark);
            font-weight: 600;
            margin: 2rem 0 1.5rem;
            position: relative;
            padding-left: 1.5rem;
        }

        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 8px;
            height: 8px;
            background: var(--primary);
            border-radius: 50%;
        }

        .card {
            border: none;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            transition: var(--transition);
            overflow: hidden;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
        }

        .card-title {
            color: var(--dark);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .card-text {
            color: #636e72;
            margin-bottom: 1.5rem;
        }

        .card-text strong {
            color: var(--dark);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: var(--radius);
            transition: var(--transition);
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            box-shadow: 0 4px 6px rgba(108, 92, 231, 0.3);
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            border-color: var(--secondary);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(108, 92, 231, 0.4);
        }

        .btn-secondary {
            background-color: #636e72;
            border-color: #636e72;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #2d3436;
            border-color: #2d3436;
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-info {
            background-color: var(--accent);
            border-color: var(--accent);
            color: white;
        }

        .btn-info:hover {
            background-color: #00a8a8;
            border-color: #00a8a8;
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(0, 206, 201, 0.4);
        }

        .alert {
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: none;
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }
            
            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .main-content {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .card {
            animation: float 6s ease-in-out infinite;
        }

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }

        /* Welcome Message Styles */
        .welcome-container {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: white;
            padding: 2.5rem;
            border-radius: var(--radius);
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .welcome-container::before {
            content: '';
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

        .welcome-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            position: relative;
            background: linear-gradient(90deg, #fff 20%, #f0f0f0 50%, #fff 80%);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: textShine 2s infinite;
        }

        @keyframes textShine {
            to { background-position: 200% center; }
        }

        .welcome-text {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
        }

        /* FAQ Styles */
        .faq-item {
            margin-bottom: 1rem;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: var(--transition);
        }

        .faq-item:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .faq-question {
            padding: 1.2rem;
            background: white;
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
            background: rgba(108, 92, 231, 0.03);
            transition: max-height 0.3s ease, padding 0.3s ease;
        }

        .faq-item.active .faq-answer {
            padding: 1.2rem;
            max-height: 500px;
        }

        .faq-item.active .faq-question i {
            transform: rotate(180deg);
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Espace Formateur</h4>
    <a href="<%= request.getContextPath() %>/formateur/dashboard" class="active">
        <i class="fas fa-home"></i> Tableau de bord
    </a>
    <a href="<%= request.getContextPath() %>/formateur/parametres">
        <i class="fas fa-cog"></i> Paramètres
    </a>
    <a href="<%= request.getContextPath() %>/logout.jsp">
        <i class="fas fa-sign-out-alt"></i> Déconnexion
    </a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="welcome-header">👋 Bienvenue, <%= formateur.getNom() %></h1>
    </div>

    <!-- Welcome Message -->
    <div class="welcome-container">
        <h2 class="welcome-title">Bienvenue sur votre espace Formateur</h2>
        <p class="welcome-text">
            Vous pouvez gérer vos formations, déposer du contenu pédagogique et suivre la progression de vos apprenants.
            Notre plateforme vous offre tous les outils nécessaires pour dispenser une formation de qualité.
        </p>
    </div>

    <h3 class="section-title">📚 Vos Formations</h3>
    <% if (formations != null && !formations.isEmpty()) { %>
        <div class="row">
            <% for (Formation f : formations) { %>
                <div class="col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><%= f.getTitre() %></h5>
                            <p class="card-text">
                                <strong>Description :</strong> <%= f.getDescription() %><br>
                                <strong>Durée :</strong> <%= f.getDuree() %> heures<br>
                                <strong>Apprenants inscrits :</strong> <%= inscriptionService.countByFormation(f.getId()) %>
                            </p>
                            <div class="d-flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/formateur/liste-apprenants?formationId=<%= f.getId() %>" class="btn btn-primary">
                                    <i class="fas fa-users"></i> Voir les Apprenants
                                </a>
                                <a href="<%= request.getContextPath() %>/formateur/depot?formationId=<%= f.getId() %>" class="btn btn-secondary">
                                    <i class="fas fa-file-upload"></i> Déposer Cours
                                </a>
                                <a href="<%= request.getContextPath() %>/formateur/liste-cours?formationId=<%= f.getId() %>" class="btn btn-info">
                                    <i class="fas fa-file-alt"></i> Voir les Cours
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="alert alert-warning">Vous n'avez aucune formation affectée.</div>
    <% } %>

    <!-- FAQ Section -->
    <div class="card">
        <div class="card-body">
            <h3 class="section-title">❓ Foire aux questions</h3>
            
            <div class="faq-item">
                <div class="faq-question">
                    <span>Comment déposer du contenu pour mes formations ?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Vous pouvez déposer du contenu en cliquant sur le bouton "Déposer Cours" dans chaque formation. Vous pourrez alors uploader des fichiers (PDF, vidéos, présentations) et ajouter des descriptions pour chaque ressource.</p>
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    <span>Comment suivre la progression de mes apprenants ?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Dans chaque formation, cliquez sur "Voir les Apprenants" pour accéder à un tableau de bord détaillé montrant la progression de chaque apprenant, leurs résultats aux évaluations et leur taux de complétion.</p>
                </div>
            </div>
            
            
            
            <div class="faq-item">
                <div class="faq-question">
                    <span>Comment communiquer avec mes apprenants ?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Notre plateforme offre un système de messagerie intégré. Vous pouvez envoyer des messages individuels ou collectifs à tous les apprenants d'une formation depuis la section "Voir les Apprenants".</p>
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question">
                    <span>Que faire en cas de problème technique ?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Notre équipe support est disponible 24/7. Vous pouvez nous contacter via le formulaire dans la section "Aide" ou directement par email à skillforge212@gmail.com . Nous répondons généralement dans les 24 heures.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add subtle animation to cards
    document.querySelectorAll('.card').forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.5s ease ' + (index * 0.1) + 's';
        
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 100);
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
</script>
</body>
</html>