<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Apprenant, entities.Formateur, entities.Formation" %>
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
    List<Apprenant> apprenants = (List<Apprenant>) request.getAttribute("apprenants");
    List<Formation> formations = (List<Formation>) request.getAttribute("formations");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");

    if (apprenants == null) {
        apprenants = new java.util.ArrayList<Apprenant>();
    }
    if (formations == null) {
        formations = new java.util.ArrayList<Formation>();
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Affecter Apprenant à Formations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
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
        
        /* Sidebar Styling */
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
            padding: 1.5rem;
            min-height: 100vh;
        }
        
        .sidebar.active ~ .main-content {
            margin-left: var(--sidebar-collapsed-width);
        }
        
        .dashboard-header {
            padding: 1rem 0;
            margin-bottom: 2rem;
            border-bottom: 1px solid #e3e6f0;
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
        
        /* Search Bar */
        .search-container {
            margin-bottom: 2rem;
            background: white;
            border-radius: 0.35rem;
            padding: 1rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .search-input {
            border-radius: 0.35rem;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d3e2;
            transition: all 0.3s;
            width: 100%;
        }
        
        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
            outline: none;
        }
        
        /* Table Styling */
        .table-responsive {
            border-radius: 0.35rem;
            overflow: hidden;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .table {
            background-color: white;
            margin-bottom: 0;
        }
        
        .table thead th {
            background-color: var(--primary-color);
            color: white;
            border-bottom: none;
            font-weight: 600;
            padding: 1rem;
        }
        
        .table tbody tr {
            transition: all 0.2s;
        }
        
        .table tbody tr:hover {
            background-color: rgba(78, 115, 223, 0.05);
            transform: translateX(5px);
        }
        
        .table tbody td {
            vertical-align: middle;
            padding: 1rem;
        }
        
        /* Form Checkboxes */
        .form-check-input {
            width: 1.2em;
            height: 1.2em;
            margin-top: 0.2em;
        }
        
        .form-check-label {
            margin-left: 0.5em;
        }
        
        /* Buttons */
        .btn-success {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            transition: all 0.3s;
        }
        
        .btn-success:hover {
            background-color: #17a673;
            border-color: #17a673;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        /* Alerts */
        .alert {
            border-radius: 0.35rem;
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate-fade-in {
            animation: fadeIn 0.6s ease forwards;
        }
        
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        
        /* Responsive */
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
            
            .table-responsive {
                overflow-x: auto;
            }
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
            <a href="<%= request.getContextPath() %>/admin/affecter-apprenant" class="active">
                <i class="fas fa-users"></i> <span>Affecter Apprenant</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="200">
            <a href="<%= request.getContextPath() %>/admin/formateurs">
                <i class="fas fa-chalkboard-teacher"></i> <span>Affectation</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="250">
            <a href="<%= request.getContextPath() %>/admin/formations">
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
                <span>Déconnexion</span>
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
    <div class="dashboard-header d-flex justify-content-between align-items-center" data-aos="fade-down">
        <div class="d-flex align-items-center">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <div>
                <h1 class="h3 mb-0"> Affecter Apprenants à plusieurs Formations</h1>
                <p class="mb-0 opacity-75">Gestion des affectations apprenants-formations</p>
            </div>
        </div>
        <div>
            <span class="badge bg-light text-dark">
                <i class="fas fa-user-shield me-1"></i> <%= admin.getNom() %>
            </span>
        </div>
    </div>

    <!-- Affichage message de succès ou d'erreur -->
    <% if (successMessage != null) { %>
        <div class="alert alert-success text-center animate-fade-in" data-aos="zoom-in">
            <i class="fas fa-check-circle me-2"></i> <%= successMessage %>
        </div>
    <% } else if (errorMessage != null) { %>
        <div class="alert alert-danger text-center animate-fade-in" data-aos="zoom-in">
            <i class="fas fa-exclamation-circle me-2"></i> <%= errorMessage %>
        </div>
    <% } %>

    <% if (apprenants.isEmpty()) { %>
        <div class="alert alert-warning text-center animate-fade-in" data-aos="zoom-in">
            <i class="fas fa-exclamation-triangle me-2"></i> Aucun apprenant disponible.
        </div>
    <% } else if (formations.isEmpty()) { %>
        <div class="alert alert-warning text-center animate-fade-in" data-aos="zoom-in">
            <i class="fas fa-exclamation-triangle me-2"></i> Aucune formation disponible.
        </div>
    <% } else { %>

    <!-- Search Bar -->
    <div class="search-container mb-4" data-aos="fade-up">
        <div class="input-group">
            <span class="input-group-text bg-white border-end-0">
                <i class="fas fa-search text-muted"></i>
            </span>
            <input type="text" id="searchInput" class="form-control search-input border-start-0" placeholder="Rechercher un apprenant par nom ou email...">
            <button class="btn btn-primary" type="button" id="clearSearch">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <div class="table-responsive" data-aos="fade-up">
        <table class="table table-bordered align-middle" id="apprenantsTable">
            <thead class="table-dark">
                <tr>
                    <th>Nom Apprenant</th>
                    <th>Email</th>
                    <th>Choisir Formations</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Apprenant a : apprenants) { %>
                <tr data-aos="fade-up" data-aos-delay="<%= (apprenants.indexOf(a) % 5) * 50 %>">
                    <td class="apprenant-nom"><%= a.getNom() %></td>
                    <td class="apprenant-email"><%= a.getEmail() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/AffecterApprenantController" method="post">
                            <!-- Très important : ajouter op=create -->
                            <input type="hidden" name="op" value="create">
                            <input type="hidden" name="apprenantId" value="<%= a.getId() %>">
                            <div class="row">
                                <% for (Formation f : formations) { %>
                                    <div class="form-check col-md-6 mb-2">
                                        <input class="form-check-input" type="checkbox" 
                                               name="formationIds" 
                                               value="<%= f.getId() %>" 
                                               id="formation_<%= a.getId() %>_<%= f.getId() %>">
                                        <label class="form-check-label" for="formation_<%= a.getId() %>_<%= f.getId() %>">
                                            <i class="fas fa-book me-1 text-primary"></i> <%= f.getTitre() %>
                                        </label>
                                    </div>
                                <% } %>
                            </div>
                    </td>
                    <td class="text-center">
                        <button type="submit" class="btn btn-success btn-sm">
                            <i class="fas fa-check me-1"></i> Affecter
                        </button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
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

    // Add ripple effect to buttons
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function(e) {
            let x = e.clientX - e.target.getBoundingClientRect().left;
            let y = e.clientY - e.target.getBoundingClientRect().top;
            
            let ripples = document.createElement('span');
            ripples.style.left = x + 'px';
            ripples.style.top = y + 'px';
            this.appendChild(ripples);
            
            setTimeout(() => {
                ripples.remove();
            }, 1000);
        });
    });

    // Search functionality
    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = document.querySelectorAll('#apprenantsTable tbody tr');
        
        rows.forEach(row => {
            const nom = row.querySelector('.apprenant-nom').textContent.toLowerCase();
            const email = row.querySelector('.apprenant-email').textContent.toLowerCase();
            
            if (nom.includes(searchTerm) || email.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Clear search
    document.getElementById('clearSearch').addEventListener('click', function() {
        document.getElementById('searchInput').value = '';
        const rows = document.querySelectorAll('#apprenantsTable tbody tr');
        rows.forEach(row => row.style.display = '');
    });
</script>
</body>
</html>