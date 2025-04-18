<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Apprenant, entities.Formateur, entities.Formation" %>
<%@ page pageEncoding="UTF-8" %>
<%
    List<Apprenant> apprenants = (List<Apprenant>) request.getAttribute("apprenants");
    List<Formateur> formateurs = (List<Formateur>) request.getAttribute("formateurs");
    List<Formation> formations = (List<Formation>) request.getAttribute("formations");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            --sidebar-bg: #2b2d42;
            --sidebar-text: #ffffff;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background-color: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 1.5rem;
            position: fixed;
            height: 100vh;
            transition: transform 0.3s;
            z-index: 1000;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding-bottom: 1rem;
            margin-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h3 {
            color: white;
            font-weight: 600;
            display: flex;
            align-items: center;
            margin: 0;
        }

        .sidebar-header i {
            margin-right: 10px;
            color: var(--accent);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar-menu i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .logout-container {
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logout-btn {
            color: var(--danger);
            background-color: rgba(247, 37, 133, 0.1);
            width: 100%;
        }

        .logout-btn:hover {
            background-color: rgba(247, 37, 133, 0.2);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
            transition: margin-left 0.3s;
        }

        /* Header */
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            border-radius: 10px 10px 0 0 !important;
            font-weight: 600;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
        }

        .card-header i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Tables */
        .table {
            margin-bottom: 0;
        }

        .table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            background-color: rgba(67, 97, 238, 0.1);
            padding: 1rem;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
        }

        /* Buttons */
        .btn-sm {
            padding: 0.35rem 0.75rem;
            font-size: 0.85rem;
            border-radius: 6px;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .stats-card i {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .stats-card h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stats-card p {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #dee2e6;
        }

        /* Form Elements */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            border: 1px solid #e0e0e0;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .menu-toggle {
                display: block !important;
            }
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            margin-right: 1rem;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h3><i class="fas fa-user-shield"></i> Administration</h3>
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
                <i class="fas fa-users"></i>
                Apprenants
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-chalkboard-teacher"></i>
                Formateurs
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-book-open"></i>
                Formations
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-cog"></i>
                Paramètres
            </a>
        </li>
    </ul>

    <div class="logout-container">
        <a href="<%= request.getContextPath() %>/logout.jsp" class="btn logout-btn">
            <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <div class="dashboard-header d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <div>
                <h1 class="h3 mb-0">Tableau de Bord Admin</h1>
                <p class="mb-0 opacity-75">Gestion complète de la plateforme</p>
            </div>
        </div>
        <div>
            <span class="badge bg-light text-dark">
                <i class="fas fa-user-shield me-1"></i> Administrateur
            </span>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="stats-container">
        <div class="stats-card">
            <i class="fas fa-users text-primary"></i>
            <h3><%= apprenants.size() %></h3>
            <p>Apprenants</p>
        </div>
        <div class="stats-card">
            <i class="fas fa-chalkboard-teacher text-secondary"></i>
            <h3><%= formateurs.size() %></h3>
            <p>Formateurs</p>
        </div>
        <div class="stats-card">
            <i class="fas fa-book-open text-success"></i>
            <h3><%= formations.size() %></h3>
            <p>Formations</p>
        </div>
    </div>

    <!-- Apprenants Section -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <i class="fas fa-users"></i> Apprenants
        </div>
        <div class="card-body">
            <% if (apprenants.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-user-slash"></i>
                    <h5>Aucun apprenant inscrit</h5>
                    <p>Commencez par ajouter des apprenants</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Inscrit le</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Apprenant a : apprenants) { %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-circle fa-lg me-2"></i>
                                            <strong><%= a.getNom() %></strong>
                                        </div>
                                    </td>
                                    <td><%= a.getEmail() %></td>
                                    <td>15 Jan 2023</td>
                                    <td>
                                        <form action="admin" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="supprimerApprenant">
                                            <input type="hidden" name="id" value="<%= a.getId() %>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash"></i> Supprimer
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
    </div>

    <!-- Formateurs Section -->
    <div class="card">
        <div class="card-header bg-secondary text-white">
            <i class="fas fa-chalkboard-teacher"></i> Formateurs
        </div>
        <div class="card-body">
            <% if (formateurs.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <h5>Aucun formateur enregistré</h5>
                    <p>Ajoutez des formateurs pour créer des formations</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Spécialité</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Formateur f : formateurs) { %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-tie fa-lg me-2"></i>
                                            <strong><%= f.getNom() %></strong>
                                        </div>
                                    </td>
                                    <td><%= f.getEmail() %></td>
                                    <td>
                                        <span class="badge bg-info"><%= f.getSpecialite() %></span>
                                    </td>
                                    <td>
                                        <form action="admin" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="supprimerFormateur">
                                            <input type="hidden" name="id" value="<%= f.getId() %>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash"></i> Supprimer
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
    </div>

    <!-- Formations Section -->
    <div class="card">
        <div class="card-header bg-success text-white">
            <i class="fas fa-book-open"></i> Formations
        </div>
        <div class="card-body">
            <!-- Add Formation Form -->
            <form class="row g-3 mb-4" action="admin" method="post">
                <input type="hidden" name="action" value="ajouterFormation">
                <div class="col-md-4">
                    <input type="text" name="titre" class="form-control" placeholder="Titre" required>
                </div>
                <div class="col-md-4">
                    <input type="text" name="description" class="form-control" placeholder="Description" required>
                </div>
                <div class="col-md-2">
                    <input type="number" name="duree" class="form-control" placeholder="Durée (h)" required>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-success w-100">
                        <i class="fas fa-plus me-1"></i> Ajouter
                    </button>
                </div>
            </form>

            <!-- Formations List -->
            <% if (formations.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-book"></i>
                    <h5>Aucune formation disponible</h5>
                    <p>Créez votre première formation</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Titre</th>
                                <th>Description</th>
                                <th>Durée</th>
                                <th>Formateur</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Formation f : formations) { %>
                                <tr>
                                    <td><strong><%= f.getTitre() %></strong></td>
                                    <td><%= f.getDescription() %></td>
                                    <td>
                                        <span class="badge bg-light text-dark"><%= f.getDuree() %> h</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-tie me-2"></i>
                                            <%= f.getFormateur().getNom() %>
                                        </div>
                                    </td>
                                    <td>
                                        <form action="admin" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="supprimerFormation">
                                            <input type="hidden" name="id" value="<%= f.getId() %>">
                                            <button class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash"></i> Supprimer
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
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });
</script>
</body>
</html>