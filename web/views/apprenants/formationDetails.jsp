<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Formation, entities.Cours, entities.Tp, entities.Video, entities.Apprenant" %>
<%@ page import="java.util.List" %>

<%
    try {
        Formation formation = (Formation) request.getAttribute("formation");
        List<Cours> coursList = (List<Cours>) request.getAttribute("coursList");
        List<Tp> tpList = (List<Tp>) request.getAttribute("tpList");
        List<Video> videoList = (List<Video>) request.getAttribute("videoList");
        Apprenant apprenant = (Apprenant) session.getAttribute("user");

        if (apprenant == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><%= formation != null ? formation.getTitre() : "Détails de la formation" %> | Learning Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            width: 25%;
            background: linear-gradient(90deg, #4cc9f0, #4895ef);
            border-radius: 3px;
            position: relative;
            animation: progressAnimation 2s ease-in-out;
        }

        @keyframes progressAnimation {
            0% { width: 0%; }
            100% { width: 25%; }
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: var(--transition);
        }

        /* HEADER STYLING */
        .main-content h2 {
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 10px;
        }

        .main-content h2:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: var(--primary);
        }

        /* FORMATION INFO CARD */
        .formation-info {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            transition: var(--transition);
        }

        .formation-info:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px);
        }

        .formation-info p {
            margin-bottom: 10px;
        }

        .formation-info p strong {
            color: var(--primary);
        }

        /* SECTION NAVIGATION */
        .section-nav {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
            background: var(--card-bg);
            padding: 15px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .section-nav a {
            flex: 1;
            text-align: center;
            padding: 15px;
            color: var(--text);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            border-radius: var(--radius-sm);
        }

        .section-nav a:hover {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            transform: translateY(-3px);
        }

        .section-nav a i {
            display: block;
            font-size: 24px;
            margin-bottom: 10px;
            color: var(--primary);
        }

        /* SECTION STYLING */
        .content-section {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            transition: var(--transition);
            animation: fadeIn 0.5s ease-out forwards;
        }

        .content-section:hover {
            box-shadow: var(--shadow-hover);
        }

        .content-section h3 {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .dark-mode .content-section h3 {
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        /* LIST STYLING */
        .content-list {
            list-style: none;
            padding: 0;
        }

        .content-list li {
            padding: 15px;
            margin-bottom: 15px;
            background-color: rgba(67, 97, 238, 0.05);
            border-left: 4px solid var(--primary);
            border-radius: var(--radius-sm);
            transition: var(--transition);
            animation: fadeIn 0.5s ease-out forwards;
            animation-delay: calc(var(--i) * 0.1s);
        }

        .dark-mode .content-list li {
            background-color: rgba(67, 97, 238, 0.1);
        }

        .content-list li:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .content-list li strong {
            color: var(--primary);
            font-size: 1.1rem;
        }

        /* VIDEO LINK STYLING */
        .video-link a {
            background-color: var(--primary);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
        }

        .video-link a i {
            margin-right: 5px;
        }

        .video-link a:hover {
            background-color: var(--secondary);
            box-shadow: 0 3px 10px rgba(67, 97, 238, 0.3);
        }

        /* Badges */
        .badge {
            padding: 0.5rem 1rem;
            font-weight: 600;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
        }

        .badge i {
            margin-right: 5px;
        }

        /* Buttons */
        .btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            border: none;
            cursor: pointer;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        .btn-sm {
            padding: 0.3rem 0.8rem;
            font-size: 0.8rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #3aa076;
            transform: translateY(-2px);
        }

        /* Alerts */
        .alert {
            padding: 1rem;
            border-radius: var(--radius-sm);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .alert i {
            margin-right: 0.8rem;
            font-size: 1.2rem;
        }

        .alert-info {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--info);
        }

        .alert-danger {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--danger);
        }

        /* ANIMATIONS */
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

        /* RESPONSIVE ADJUSTMENTS */
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

            .section-nav {
                flex-direction: column;
            }

            .section-nav a {
                margin-bottom: 10px;
            }
        }

        @media (max-width: 768px) {
            .formation-info {
                padding: 15px;
            }

            .content-section {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="sidebar-header">
        <img src="https://ui-avatars.com/api/?name=<%= apprenant.getNom() != null ? apprenant.getNom() : "User" %>&background=random&color=fff" alt="Profile">
        <div>
            <h3><%= apprenant.getNom() != null ? apprenant.getNom() : "Utilisateur" %></h3>
            <p>Apprenant</p>
        </div>
    </div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/views/apprenants/dashboard.jsp">
                <i class="fas fa-tachometer-alt"></i>
                Tableau de bord
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/views/apprenants/mesFormations.jsp" class="active">
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
                <a href="#">
                    <i class="fas fa-chart-line"></i>
                    Progression
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/parametres.jsp">
                    <i class="fas fa-cog"></i>
                    Paramètres
                </a>
            </li>
        <li>
            <a href="<%= request.getContextPath() %>/logout.jsp" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Déconnexion
            </a>
        </li>
    </ul>

    <div class="sidebar-info">
        <h4>
            <i class="fas fa-info-circle"></i>
            Progression
        </h4>
        <p>
            Vous avez complété <strong>25%</strong> de cette formation.
        </p>
        <div class="progress-container">
            <div class="progress-bar"></div>
        </div>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <% if (formation != null) { %>
        <div class="formation-info">
            <h2><i class="fas fa-graduation-cap"></i> <%= formation.getTitre() != null ? formation.getTitre() : "Sans titre" %></h2>
            <p><strong><i class="fas fa-align-left"></i> Description :</strong> <%= formation.getDescription() != null ? formation.getDescription() : "Non disponible" %></p>
            <p><strong><i class="fas fa-clock"></i> Durée :</strong> <%= formation.getDuree() > 0 ? formation.getDuree() + " heures" : "Non spécifiée" %></p>
            
            <!-- Progress Bar -->
            <div class="progress-container">
                <div class="progress-label">
                    <span>Progression</span>
                    <span>25%</span>
                </div>
                <div class="progress">
                    <div class="progress-bar" style="width: 25%;"></div>
                </div>
            </div>
        </div>

        <!-- NAVIGATION ANCRE -->
        <div class="section-nav">
            <a href="#cours">
                <i class="fas fa-book"></i>
                Cours
            </a>
            <a href="#tp">
                <i class="fas fa-vials"></i>
                Travaux Pratiques
            </a>
            <a href="#videos">
                <i class="fas fa-video"></i>
                Vidéos
            </a>
        </div>

        <!-- COURS -->
        <div class="content-section" id="cours">
            <h3><i class="fas fa-book"></i> Cours</h3>
            <% if (coursList != null && !coursList.isEmpty()) { %>
                <ul class="content-list">
                    <% for (int i = 0; i < coursList.size(); i++) { 
                        Cours c = coursList.get(i);
                    %>
                        <li style="--i: <%= i %>;">
                            <strong><i class="fas fa-file-alt"></i> <%= c.getTitre() != null ? c.getTitre() : "Sans titre" %></strong>
                            <div class="mt-2">
                                <%= c.getContenu() != null ? c.getContenu() : "Contenu non disponible" %>
                            </div>
                            <div class="mt-2">
                                <span class="badge bg-success"><i class="fas fa-check-circle"></i> Complété</span>
                                <span class="badge bg-primary ms-2"><i class="fas fa-clock"></i> 30 min</span>
                            </div>
                        </li>
                    <% } %>
                </ul>
            <% } else { %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Aucun cours disponible pour cette formation.
                </div>
            <% } %>
        </div>

        <!-- TP -->
        <div class="content-section" id="tp">
            <h3><i class="fas fa-vials"></i> Travaux Pratiques</h3>
            <% if (tpList != null && !tpList.isEmpty()) { %>
                <ul class="content-list">
                    <% for (int i = 0; i < tpList.size(); i++) { 
                        Tp tp = tpList.get(i);
                    %>
                        <li style="--i: <%= i %>;">
                            <strong><i class="fas fa-tasks"></i> TP <%= i+1 %></strong>
                            <div class="mt-2">
                                <%= tp.getSujet() != null ? tp.getSujet() : "Sujet non spécifié" %>
                            </div>
                            <div class="mt-2">
                                <button class="btn btn-sm btn-primary"><i class="fas fa-download"></i> Télécharger</button>
                                <button class="btn btn-sm btn-success ms-2"><i class="fas fa-upload"></i> Soumettre</button>
                            </div>
                        </li>
                    <% } %>
                </ul>
            <% } else { %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Aucun TP disponible pour cette formation.
                </div>
            <% } %>
        </div>

        <!-- VIDEOS -->
        <div class="content-section" id="videos">
            <h3><i class="fas fa-video"></i> Vidéos</h3>
            <% if (videoList != null && !videoList.isEmpty()) { %>
                <ul class="content-list">
                    <% for (int i = 0; i < videoList.size(); i++) { 
                        Video v = videoList.get(i);
                    %>
                        <li style="--i: <%= i %>;">
                            <strong><i class="fas fa-play-circle"></i> <%= v.getTitre() != null ? v.getTitre() : "Sans titre" %></strong>
                            <div class="mt-2">
                                <% if (v.getUrl() != null) { %>
                                    <a href="<%= v.getUrl() %>" target="_blank" class="video-link">
                                        <i class="fas fa-play"></i> Regarder la vidéo
                                    </a>
                                <% } else { %>
                                    <span class="text-muted"><i class="fas fa-exclamation-circle"></i> Lien non disponible</span>
                                <% } %>
                            </div>
                            <div class="mt-2">
                                <span class="badge bg-secondary"><i class="fas fa-clock"></i> 15 min</span>
                                <span class="badge bg-warning text-dark ms-2"><i class="fas fa-star"></i> Important</span>
                            </div>
                        </li>
                    <% } %>
                </ul>
            <% } else { %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Aucune vidéo disponible pour cette formation.
                </div>
            <% } %>
        </div>

    <% } else { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-triangle"></i> Erreur : Formation non trouvée.
        </div>
    <% } %>
</div>

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    // Animation au chargement de la page
    $(document).ready(function() {
        // Smooth scroll pour les ancres
        $('a[href^="#"]').on('click', function(event) {
            var target = $(this.getAttribute('href'));
            if(target.length) {
                event.preventDefault();
                $('html, body').stop().animate({
                    scrollTop: target.offset().top - 20
                }, 1000);
            }
        });
        
        // Ajout d'une classe active lors du scroll
        $(window).scroll(function() {
            var scrollDistance = $(window).scrollTop() + 20;
            
            $('.content-section').each(function(i) {
                if ($(this).position().top <= scrollDistance) {
                    $('.section-nav a.active').removeClass('active');
                    $('.section-nav a').eq(i).addClass('active');
                }
            });
        }).scroll();

        // Mobile menu toggle
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (menuToggle) {
            menuToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
            });
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', (e) => {
                if (window.innerWidth <= 992 && !sidebar.contains(e.target) && e.target !== menuToggle) {
                    sidebar.classList.remove('active');
                }
            });
        }

        // Dark mode toggle
        const toggleDark = document.getElementById('toggleDark');
        const body = document.body;
        
        if (toggleDark) {
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
        }
    });
</script>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    }
%>