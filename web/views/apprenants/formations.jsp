<%@page import="entities.Inscription"%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Apprenant" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Formation" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
    <title>Mes Formations</title>
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

        .form-search {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border-radius: 50px;
            padding: 0.3rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .dark-mode .form-search {
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        .form-search input {
            border: none;
            background: transparent;
            padding: 0.5rem 1rem;
            width: 200px;
            color: var(--text);
        }

        .form-search input:focus {
            outline: none;
        }

        .form-search button {
            background: var(--primary);
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
        }

        .empty-state {
            padding: 3rem 2rem;
            text-align: center;
            color: var(--text);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            opacity: 0.7;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .empty-state p {
            opacity: 0.8;
            margin-bottom: 1.5rem;
        }

        .formation-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            padding: 1.5rem;
        }

        .formation-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            opacity: 0;
            transform: translateY(20px);
        }

        .formation-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px) !important;
        }

        .formation-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .formation-content {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .formation-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text);
        }

        .formation-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 0.85rem;
            color: var(--text);
            opacity: 0.8;
        }

        .formation-meta i {
            margin-right: 0.3rem;
            color: var(--primary);
        }

        .formation-id {
            font-size: 0.75rem;
            color: var(--accent);
            background: rgba(67, 97, 238, 0.1);
            padding: 0.2rem 0.6rem;
            border-radius: 50px;
            font-weight: 500;
        }

        .formation-description {
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            color: var(--text);
            opacity: 0.9;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .formation-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .formation-duration {
            font-size: 0.85rem;
            color: var(--primary);
            font-weight: 500;
        }

        .formation-duration i {
            margin-right: 0.3rem;
        }

        .formation-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }

        .btn i {
            margin-right: 0.4rem;
        }

        .btn-primary {
            background: var(--primary);
            border: none;
            color: white;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
        }

        /* No results styles */
        .no-results {
            grid-column: 1 / -1;
            text-align: center;
            padding: 2rem;
            display: none;
        }

        .no-results i {
            font-size: 2rem;
            color: var(--danger);
            margin-bottom: 1rem;
        }

        .no-results h4 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .no-results p {
            opacity: 0.8;
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

            .formation-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.5rem;
            }

            .formation-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
                <a href="<%= request.getContextPath() %>/views/apprenants/dashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i>
                    Tableau de bord
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/formations.jsp" class="active">
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
            <h1><i class="fas fa-book-open"></i> Mes Formations</h1>
            <button class="toggle-dark" id="toggleDark">
                <i class="fas fa-moon"></i>
            </button>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-book"></i> Formations inscrites</h3>
                <div class="form-search">
                    <input type="text" id="searchInput" placeholder="Rechercher une formation...">
                    <button type="button" id="searchButton"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <% if (inscriptions == null || inscriptions.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-book"></i>
                    <h3>Aucune formation inscrite</h3>
                    <p>Vous n'êtes actuellement inscrit à aucune formation.</p>
                    <a href="#" class="btn btn-primary" style="margin-top: 1rem;">
                        <i class="fas fa-plus"></i> Parcourir les formations
                    </a>
                </div>
            <% } else { %>
                <div class="formation-grid">
                    <div class="no-results">
                        <i class="fas fa-search-minus"></i>
                        <h4>Aucun résultat trouvé</h4>
                        <p>Aucune formation ne correspond à votre recherche.</p>
                    </div>
                    <% for (Inscription ins : inscriptions) { 
                        Formation f = ins.getFormation();
                    %>
                    <div class="formation-card">
                        <img src="${pageContext.request.contextPath}/img/formation.jpg" alt="<%= f.getTitre()%>" class="formation-image">
                        <div class="formation-content">
                            <h3 class="formation-title"><%= f.getTitre()%></h3>
                            <div class="formation-meta">
                                <span><i class="far fa-calendar-alt"></i> Inscrit le <%= dateFormat.format(ins.getDateInscription()) %></span>
                                <span class="formation-id"><i class="fas fa-hashtag"></i> <%= f.getId() %></span>
                            </div>
                            <p class="formation-description"><%= f.getDescription()%></p>
                            <div class="formation-footer">
                                <span class="formation-duration">
                                    <i class="far fa-clock"></i> <%= f.getDuree()%> heures
                                </span>
                                <div class="formation-actions">
                                    <a href="<%= request.getContextPath() %>/formationDetails?id=<%= f.getId() %>" class="btn btn-primary">
                                        <i class="fas fa-play"></i> Continuer
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
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
        
        // Add animation to cards when they come into view
        const cards = document.querySelectorAll('.formation-card');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }, index * 100);
                }
            });
        }, { threshold: 0.1 });
        
        cards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            observer.observe(card);
        });

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const searchButton = document.getElementById('searchButton');
        const formationCards = document.querySelectorAll('.formation-card');
        const noResults = document.querySelector('.no-results');

        function filterFormations() {
            const searchTerm = searchInput.value.toLowerCase();
            let visibleCount = 0;
            
            formationCards.forEach(card => {
                const title = card.querySelector('.formation-title').textContent.toLowerCase();
                const description = card.querySelector('.formation-description').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || description.includes(searchTerm)) {
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            if (visibleCount === 0 && searchTerm !== '') {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }
        }

        searchButton.addEventListener('click', filterFormations);
        searchInput.addEventListener('keyup', filterFormations);

        // Reset search when clicking on empty state button (if exists)
        const browseButton = document.querySelector('.empty-state .btn');
        if (browseButton) {
            browseButton.addEventListener('click', () => {
                searchInput.value = '';
                filterFormations();
            });
        }
    </script>
</body>
</html>