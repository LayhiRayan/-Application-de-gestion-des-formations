<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Apprenant" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Formation" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Apprenant apprenant = (Apprenant) session.getAttribute("user");
    String role = (String) session.getAttribute("type");
    List<Formation> formations = (List<Formation>) session.getAttribute("formations");

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
    <style>
        :root {
            --primary: #4361ee;
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
            --sidebar-bg: #2b2d42;
            --sidebar-text: #ffffff;
        }

        .dark-mode {
            --light: #212529;
            --dark: #f8f9fa;
            --card-bg: #2d3748;
            --text: #f0f0f0;
            --sidebar-bg: #1a1a2e;
            --sidebar-text: #e6e6e6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: background-color 0.3s, color 0.3s;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light);
            color: var(--text);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .sidebar {
            width: 280px;
            background-color: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 2rem 1rem;
            position: fixed;
            height: 100vh;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            transition: transform 0.3s;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 3px solid var(--accent);
        }

        .sidebar-header h3 {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .sidebar-header p {
            font-size: 0.8rem;
            opacity: 0.8;
        }

        .sidebar-menu {
            list-style: none;
            margin-top: 2rem;
        }

        .sidebar-menu li {
            margin-bottom: 1rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .sidebar-menu i {
            margin-right: 1rem;
            font-size: 1.1rem;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .dark-mode .header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .header h1 {
            font-size: 2rem;
            color: var(--primary);
            display: flex;
            align-items: center;
        }

        .header h1 i {
            margin-right: 1rem;
        }

        .toggle-dark {
            background: var(--dark);
            color: var(--light);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .toggle-dark:hover {
            transform: scale(1.1);
        }

        .card {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .dark-mode .card-header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .card-header h3 {
            font-size: 1.3rem;
            color: var(--primary);
            display: flex;
            align-items: center;
        }

        .card-header h3 i {
            margin-right: 0.8rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }

        .info-item {
            background-color: rgba(67, 97, 238, 0.1);
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid var(--primary);
        }

        .dark-mode .info-item {
            background-color: rgba(67, 97, 238, 0.2);
        }

        .info-item h4 {
            font-size: 0.9rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .info-item p {
            font-size: 1.1rem;
            font-weight: 500;
        }

        .formation-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .formation-card {
            background-color: var(--card-bg);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .formation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .formation-image {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .formation-content {
            padding: 1.5rem;
        }

        .formation-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }

        .formation-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 0.85rem;
            color: var(--text);
            opacity: 0.7;
        }

        .formation-description {
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            line-height: 1.5;
            color: var(--text);
        }

        .formation-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .dark-mode .formation-footer {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .formation-duration {
            font-size: 0.9rem;
            color: var(--accent);
            font-weight: 600;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.7rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #d1146a;
            transform: translateY(-2px);
        }

        .progress-container {
            width: 100%;
            background-color: rgba(0, 0, 0, 0.1);
            border-radius: 50px;
            height: 8px;
            margin-top: 0.5rem;
        }

        .dark-mode .progress-container {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .progress-bar {
            height: 100%;
            border-radius: 50px;
            background-color: var(--success);
            width: 65%;
        }

        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 3rem 1rem;
            text-align: center;
            color: var(--text);
            opacity: 0.7;
            width: 100%;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                width: 250px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .header h1 {
                font-size: 1.5rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .menu-toggle {
                display: block;
            }
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--text);
            font-size: 1.5rem;
            cursor: pointer;
            margin-right: 1rem;
        }

        .form-search {
            display: flex;
            margin-bottom: 1.5rem;
        }

        .form-search input {
            flex: 1;
            padding: 0.8rem 1rem;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px 0 0 8px;
            font-size: 1rem;
            outline: none;
        }

        .dark-mode .form-search input {
            border: 1px solid rgba(255, 255, 255, 0.1);
            background-color: var(--card-bg);
            color: var(--text);
        }

        .form-search button {
            padding: 0 1.5rem;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 0 8px 8px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-search button:hover {
            background-color: var(--secondary);
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=<%= apprenant.getNom() %>&background=random" alt="Profile">
            <div>
                <h3><%= apprenant.getNom() %></h3>
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
                <a href="#">
                    <i class="fas fa-book"></i>
                    Mes formations
                </a>
            </li>
            <li>
                <a href="#">
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
                <a href="#">
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
        
        <div style="margin-top: 2rem; padding: 1rem; background: rgba(255,255,255,0.1); border-radius: 8px;">
            <h4 style="font-size: 0.9rem; margin-bottom: 0.5rem; display: flex; align-items: center;">
                <i class="fas fa-info-circle" style="margin-right: 0.5rem;"></i>
                Informations
            </h4>
            <p style="font-size: 0.8rem; opacity: 0.8;">
                Vous avez <strong><%= formations != null ? formations.size() : 0 %> formations</strong> en cours.
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
        
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-user-graduate"></i> Profil Apprenant</h3>
                <span class="badge badge-primary">Actif</span>
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <h4>Nom complet</h4>
                    <p><%= apprenant.getNom() %></p>
                </div>
                <div class="info-item">
                    <h4>Email</h4>
                    <p><%= apprenant.getEmail() %></p>
                </div>
                <div class="info-item">
                    <h4>Rôle</h4>
                    <p><%= role %></p>
                </div>
                <div class="info-item">
                    <h4>Date d'inscription</h4>
                    <p>15 Jan 2023</p>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-book-open"></i> Formations inscrites</h3>
                <div class="form-search">
                    <input type="text" placeholder="Rechercher une formation...">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </div>
            </div>
            
            <%
                if (formations == null || formations.isEmpty()) {
            %>
                <div class="empty-state">
                    <i class="fas fa-book"></i>
                    <h3>Aucune formation inscrite</h3>
                    <p>Vous n'êtes actuellement inscrit à aucune formation.</p>
                    <a href="#" class="btn btn-primary" style="margin-top: 1rem;">
                        <i class="fas fa-plus"></i> Parcourir les formations
                    </a>
                </div>
            <%
                } else {
            %>
                <div class="formation-grid">
                    <%
                        for (Formation f : formations) {
                    %>
                    <div class="formation-card">
                            <img src="${pageContext.request.contextPath}/img/formation.jpg" alt="<%= f.getTitre() %>" class="formation-image">
                        <div class="formation-content">
                            <h3 class="formation-title"><%= f.getTitre() %></h3>
                            <div class="formation-meta">
                                <span><i class="far fa-calendar-alt"></i> Inscrit le 15 Jan 2023</span>
                                <span><i class="fas fa-chart-line"></i> <%= (int)(Math.random() * 100) %>% complété</span>
                            </div>
                            <p class="formation-description"><%= f.getDescription() %></p>
                            <div class="formation-footer">
                                <span class="formation-duration">
                                    <i class="far fa-clock"></i> <%= f.getDuree() %> heures
                                </span>
                                <a href="#" class="btn btn-primary">
                                    <i class="fas fa-play"></i> Continuer
                                </a>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            <%
                }
            %>
        </div>
    </div>

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
            if (window.innerWidth <= 768 && !sidebar.contains(e.target) && e.target !== menuToggle) {
                sidebar.classList.remove('active');
            }
        });
        
        // Add animation to cards when they come into view
        const cards = document.querySelectorAll('.formation-card');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.1 });
        
        cards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            observer.observe(card);
        });
    </script>
</body>
</html>