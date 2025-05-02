<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Formation, entities.Cours, java.util.List" %>
<%
    Formation formation = (Formation) request.getAttribute("formation");
    List<Cours> coursList = (List<Cours>) request.getAttribute("coursList");

    if (formation == null) {
        response.sendRedirect(request.getContextPath() + "/formateur/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des cours - <%= formation.getTitre() %></title>
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
            --transition: all 0.3s ease;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 30px rgba(0, 0, 0, 0.15);
            --radius: 10px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: var(--dark);
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        .sidebar {
            width: 280px;
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            box-shadow: var(--shadow);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--glass);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: var(--radius);
            transition: var(--transition);
        }

        .sidebar-menu a:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .sidebar-menu a i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 280px;
            padding: 3rem;
            flex: 1;
        }

        .page-header {
            color: var(--primary);
            margin-bottom: 2rem;
            font-weight: 600;
            position: relative;
            padding-bottom: 0.75rem;
        }

        .page-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }

        .table-container {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead th {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 500;
        }

        .table tbody tr {
            transition: var(--transition);
        }

        .table tbody tr:hover {
            background-color: rgba(108, 92, 231, 0.05);
        }

        .table tbody td {
            padding: 1rem 1.5rem;
            border-color: #f1f1f1;
            vertical-align: middle;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
        }

        .btn-secondary {
            background-color: #636e72;
            border-color: #636e72;
        }

        .btn-secondary:hover {
            background-color: #555f63;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .alert {
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: none;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
                padding: 2rem;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }
            
            .table thead {
                display: none;
            }
            
            .table tbody tr {
                display: block;
                margin-bottom: 1rem;
                border-radius: var(--radius);
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            
            .table tbody td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 1rem;
                border-bottom: 1px solid #f1f1f1;
            }
            
            .table tbody td::before {
                content: attr(data-label);
                font-weight: 600;
                color: var(--primary);
                margin-right: 1rem;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h4 class="mb-0">Espace Formateur</h4>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/formateur/dashboard">
                <i class="fas fa-home"></i> Tableau de bord
            </a>
        </li>
        
        <li>
            <a href="<%= request.getContextPath() %>/formateur/parametres">
                <i class="fas fa-cog"></i> Paramètres
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/logout.jsp">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-header">
            <i class="fas fa-book-open"></i> Cours de la formation : <%= formation.getTitre() %>
        </h2>
        <a href="<%= request.getContextPath() %>/formateur/dashboard" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Retour
        </a>
    </div>

    <% if (coursList != null && !coursList.isEmpty()) { %>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Titre</th>
                        <th>Contenu / Description</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Cours cours : coursList) { %>
                        <tr>
                            <td data-label="Titre"><%= cours.getTitre() %></td>
                            <td data-label="Description"><%= cours.getContenu() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } else { %>
        <div class="alert alert-info text-center">
            <i class="fas fa-info-circle"></i> Aucun cours n'a encore été déposé pour cette formation.
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Mobile sidebar toggle
    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.querySelector('.sidebar');
        const toggleBtn = document.createElement('button');
        toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
        toggleBtn.className = 'btn btn-primary position-fixed';
        toggleBtn.style.bottom = '20px';
        toggleBtn.style.right = '20px';
        toggleBtn.style.zIndex = '999';
        toggleBtn.style.borderRadius = '50%';
        toggleBtn.style.width = '50px';
        toggleBtn.style.height = '50px';
        toggleBtn.style.display = 'none';
        
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
        
        document.body.appendChild(toggleBtn);
        
        function checkScreenSize() {
            if (window.innerWidth < 768) {
                toggleBtn.style.display = 'flex';
                toggleBtn.style.alignItems = 'center';
                toggleBtn.style.justifyContent = 'center';
            } else {
                toggleBtn.style.display = 'none';
                sidebar.classList.remove('active');
            }
        }
        
        window.addEventListener('resize', checkScreenSize);
        checkScreenSize();
        
        // Responsive table setup
        document.querySelectorAll('tbody td').forEach(td => {
            const header = td.closest('table').querySelector('th:nth-child(' + (td.cellIndex + 1) + ')');
            if (header) td.setAttribute('data-label', header.textContent.trim());
        });
    });
</script>
</body>
</html>