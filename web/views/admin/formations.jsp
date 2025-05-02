<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Formation, entities.Formateur" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="entities.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("user");
    String role = (String) session.getAttribute("type");

    if (admin == null || !"admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }
%>

<%
    List<Formation> formations = (List<Formation>) request.getAttribute("formations");
    if (formations == null) {
        formations = new java.util.ArrayList<Formation>();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>📚 Liste des Formations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --accent-color: #f6c23e;
            --dark-color: #5a5c69;
            --light-color: #f8f9fc;
            --sidebar-width: 250px;
            --sidebar-collapsed-width: 80px;
            --transition-speed: 0.3s;
        }
        
        body {
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--light-color);
            overflow-x: hidden;
        }
        
        /* Sidebar Styling - Identique aux autres pages */
        .sidebar {
            width: var(--sidebar-width);
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            background: linear-gradient(180deg, var(--primary-color) 0%, #224abe 100%);
            color: white;
            transition: all var(--transition-speed) ease;
            z-index: 1000;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
        }
        
        .sidebar.active {
            width: var(--sidebar-collapsed-width);
        }
        
        .sidebar.active .sidebar-header h3,
        .sidebar.active .sidebar-menu li a span,
        .sidebar.active .logout-container .logout-btn span {
            display: none;
        }
        
        .sidebar.active .sidebar-menu li a i,
        .sidebar.active .logout-container .logout-btn i {
            margin-right: 0;
            font-size: 1.5rem;
        }
        
        .sidebar-header {
            padding: 1.5rem 1.5rem 0.5rem;
            background: rgba(255, 255, 255, 0.1);
            margin-bottom: 1rem;
        }
        
        .sidebar-header h3 {
            font-weight: 800;
            font-size: 1.2rem;
            margin-bottom: 0;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar-menu li a {
            display: block;
            padding: 1rem 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }
        
        .sidebar-menu li a:hover {
            color: white;
            background: rgba(255, 255, 255, 0.1);
            border-left: 3px solid white;
        }
        
        .sidebar-menu li a.active {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            border-left: 3px solid white;
        }
        
        .sidebar-menu li a i {
            margin-right: 0.5rem;
            width: 1.5rem;
            text-align: center;
        }
        
        .logout-container {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .logout-btn {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.2s;
            padding: 0.5rem;
            border-radius: 0.35rem;
        }
        
        .logout-btn:hover {
            color: white;
            background: rgba(255, 255, 255, 0.1);
        }
        
        .logout-btn i {
            margin-right: 0.5rem;
        }
        
        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            transition: margin-left var(--transition-speed) ease;
            padding: 2rem;
            min-height: 100vh;
        }
        
        .sidebar.active ~ .main-content {
            margin-left: var(--sidebar-collapsed-width);
        }
        
        .dashboard-header {
            padding: 1rem 0;
            margin-bottom: 2rem;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .menu-toggle {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-right: 1rem;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        
        .menu-toggle:hover {
            transform: rotate(90deg);
        }
        
        /* Page Specific Styling */
        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            position: relative;
            display: inline-block;
            margin-bottom: 2rem;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }
        
        .formation-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            background: white;
            position: relative;
        }
        
        .formation-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .formation-card:hover .card-img-top {
            transform: scale(1.05);
        }
        
        .card-img-top {
            height: 180px;
            object-fit: cover;
            border-bottom: 4px solid var(--primary-color);
            transition: transform 0.5s ease;
        }
        
        .card-body {
            padding: 1.5rem;
            position: relative;
        }
        
        .card-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }
        
        .card-text {
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .duration-badge {
            background: linear-gradient(135deg, var(--primary-color), #3a56e8);
            color: white;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 8px rgba(78, 115, 223, 0.2);
        }
        
        .trainer-info {
            display: flex;
            align-items: center;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px dashed #e0e0e0;
        }
        
        .trainer-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--secondary-color), #17a673);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            flex-shrink: 0;
            box-shadow: 0 4px 8px rgba(28, 200, 138, 0.2);
        }
        
        .no-trainer {
            color: #dc3545;
            font-style: italic;
            display: flex;
            align-items: center;
        }
        
        .formation-tag {
            position: absolute;
            top: -10px;
            right: 20px;
            background: var(--accent-color);
            color: #fff;
            padding: 0.25rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            box-shadow: 0 4px 8px rgba(246, 194, 62, 0.3);
            z-index: 1;
        }
        
        .alert-warning {
            background-color: #fff3cd;
            border-color: #ffeeba;
            color: #856404;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.1);
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .main-content {
                padding: 1.5rem;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                left: -100%;
            }
            
            .sidebar.active {
                left: 0;
                width: 100%;
            }
            
            .main-content {
                margin-left: 0;
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
        
        .animate-card {
            animation: fadeInUp 0.6s ease forwards;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header" data-aos="fade-right">
        <h3><i class="fas fa-user-shield"></i> Administration</h3>
    </div>

    <ul class="sidebar-menu">
        <li data-aos="fade-right" data-aos-delay="100">
            <a href="<%= request.getContextPath() %>/admin/dashboard-admin">
                <i class="fas fa-tachometer-alt"></i> <span>Tableau de bord</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="150">
            <a href="<%= request.getContextPath() %>/admin/affecter-apprenant">
                <i class="fas fa-users"></i> <span>Affecter Apprenant</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="200">
            <a href="<%= request.getContextPath() %>/admin/formateurs">
                <i class="fas fa-chalkboard-teacher"></i> <span>Affectation</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="250">
            <a href="<%= request.getContextPath() %>/admin/formations" class="active">
                <i class="fas fa-book-open"></i> <span>Formations</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="300">
            <a href="<%= request.getContextPath() %>/admin/statistiques">
                <i class="fas fa-chart-pie"></i> <span>Statistiques</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="350">
            <a href="<%= request.getContextPath() %>/admin/parametres">
                <i class="fas fa-cog"></i> <span>Paramètres</span>
            </a>
        </li>
        <li>
                <a href="<%= request.getContextPath()%>/logout.jsp" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Déconnexion
                </a>
            </li>
    </ul>

    <div class="logout-container" data-aos="fade-up" data-aos-delay="400">
        <a href="<%= request.getContextPath() %>/logout.jsp" class="btn logout-btn">
            <i class="fas fa-sign-out-alt"></i> <span>Déconnexion</span>
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <div class="dashboard-header" data-aos="fade-down">
        <div class="d-flex align-items-center">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <div>
                <h1 class="h3 mb-0">
                    <i class="fas fa-book-open text-primary me-2"></i> Liste des Formations
                </h1>
                <p class="mb-0 opacity-75">Gestion complète du catalogue de formations</p>
            </div>
        </div>
        <div>
            <span class="badge bg-light text-dark">
                <i class="fas fa-user-shield me-1"></i> <%= admin.getNom() %>
            </span>
        </div>
    </div>

    <% if (formations.isEmpty()) { %>
        <div class="alert alert-warning text-center animate-card" data-aos="zoom-in">
            <i class="fas fa-exclamation-circle me-2"></i> Aucune formation disponible pour le moment.
        </div>
    <% } else { %>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <% for (Formation formation : formations) { %>
        <div class="col" data-aos="fade-up" data-aos-delay="<%= (formations.indexOf(formation) % 6) * 50 %>">
            <div class="formation-card h-100 animate-card">
                <span class="formation-tag">
                    <i class="fas fa-certificate me-1"></i> Formation
                </span>
                
                <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80" 
                     class="card-img-top" 
                     alt="Image de formation">
                
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="fas fa-graduation-cap me-2"></i> <%= formation.getTitre() %>
                    </h5>
                    <p class="card-text">
                        <i class="fas fa-info-circle me-2 text-primary"></i> <%= formation.getDescription() %>
                    </p>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="duration-badge">
                            <i class="fas fa-clock me-1"></i> <%= formation.getDuree() %> heures
                        </span>
                    </div>
                    
                    <div class="trainer-info">
                        <% if (formation.getFormateur() != null) { %>
                            <div class="trainer-icon">
                                <i class="fas fa-chalkboard-teacher"></i>
                            </div>
                            <div>
                                <strong>Formateur:</strong> <%= formation.getFormateur().getNom() %>
                            </div>
                        <% } else { %>
                            <div class="no-trainer">
                                <i class="fas fa-exclamation-triangle me-1"></i> Formateur non affecté
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // Initialize AOS (Animate On Scroll)
    AOS.init({
        duration: 800,
        easing: 'ease-in-out',
        once: true
    });

    // Sidebar toggle
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // Add ripple effect to cards
    document.querySelectorAll('.formation-card').forEach(card => {
        card.addEventListener('click', function(e) {
            if (e.target.tagName !== 'A' && e.target.tagName !== 'BUTTON') {
                let x = e.clientX - e.currentTarget.getBoundingClientRect().left;
                let y = e.clientY - e.currentTarget.getBoundingClientRect().top;
                
                let ripples = document.createElement('span');
                ripples.style.left = x + 'px';
                ripples.style.top = y + 'px';
                this.appendChild(ripples);
                
                setTimeout(() => {
                    ripples.remove();
                }, 1000);
            }
        });
    });
</script>
</body>
</html>