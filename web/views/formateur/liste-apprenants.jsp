<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Inscription, entities.Apprenant, entities.Formation" %>
<%@ page import="java.util.List" %>
<%
    Formation formation = (Formation) request.getAttribute("formation");
    List<Inscription> inscriptions = (List<Inscription>) request.getAttribute("inscriptions");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Apprenants de la Formation</title>
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
            animation: fadeIn 0.6s ease-out forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-header {
            background: linear-gradient(90deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 700;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            position: relative;
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

        .table-container {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            padding: 0;
            margin-bottom: 2rem;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
        }

        .table thead th {
            border: none;
            padding: 1.25rem 1.5rem;
            font-weight: 600;
        }

        .table tbody tr {
            transition: var(--transition);
        }

        .table tbody tr:hover {
            background-color: rgba(108, 92, 231, 0.05);
            transform: translateX(5px);
        }

        .table tbody td {
            padding: 1.25rem 1.5rem;
            vertical-align: middle;
            border-color: #f1f1f1;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .alert {
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: none;
            padding: 1.25rem;
        }

        .badge-count {
            background: var(--primary);
            color: white;
            border-radius: 50px;
            padding: 0.35rem 0.75rem;
            font-size: 0.85rem;
            font-weight: 600;
            margin-left: 0.5rem;
        }

        /* Search filter styles */
        .search-container {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .search-box {
            position: relative;
            max-width: 400px;
        }

        .search-box input {
            padding-left: 3rem;
            border-radius: 50px;
            border: 1px solid #e0e0e0;
            height: 50px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: var(--transition);
        }

        .search-box input:focus {
            border-color: var(--primary-light);
            box-shadow: 0 5px 15px rgba(108, 92, 231, 0.1);
        }

        .search-box i {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            display: none;
        }

        .no-results i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .no-results h4 {
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .no-results p {
            color: #636e72;
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

        @media (max-width: 768px) {
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

            .search-box {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Espace Formateur</h4>
    <a href="<%= request.getContextPath() %>/formateur/dashboard">
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
        <h3 class="page-header">
            <i class="fas fa-users"></i> Apprenants inscrits à : <%= formation.getTitre() %>
            <span class="badge-count"><%= inscriptions != null ? inscriptions.size() : 0 %></span>
        </h3>
        <a href="<%= request.getContextPath() %>/formateur/dashboard" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Retour
        </a>
    </div>

    <!-- Search Filter -->
    <div class="search-container">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" class="form-control" placeholder="Rechercher un apprenant...">
        </div>
    </div>

    <% if (inscriptions != null && !inscriptions.isEmpty()) { %>
        <div class="table-container">
            <table class="table" id="apprenantsTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th><i class="fas fa-user"></i> Nom</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-calendar-alt"></i> Date d'inscription</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1;
                       for (Inscription insc : inscriptions) {
                           Apprenant a = insc.getApprenant(); %>
                        <tr>
                            <td data-label="#"><%= i++ %></td>
                            <td data-label="Nom"><%= a.getNom() %></td>
                            <td data-label="Email"><%= a.getEmail() %></td>
                            <td data-label="Date"><%= insc.getDateInscription() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <div class="no-results" id="noResults">
            <i class="fas fa-search-minus"></i>
            <h4>Aucun résultat trouvé</h4>
            <p>Aucun apprenant ne correspond à votre recherche.</p>
        </div>
    <% } else { %>
        <div class="alert alert-warning">
            <i class="fas fa-exclamation-circle me-2"></i> Aucun apprenant inscrit à cette formation.
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Responsive table setup
    document.querySelectorAll('tbody td').forEach(td => {
        const header = td.closest('table').querySelector('th:nth-child(' + (td.cellIndex + 1) + ')');
        if (header) td.setAttribute('data-label', header.textContent.trim());
    });

    // Toggle sidebar on mobile
    document.addEventListener('DOMContentLoaded', function() {
        const sidebar = document.querySelector('.sidebar');
        const sidebarToggle = document.createElement('button');
        sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
        sidebarToggle.className = 'btn btn-primary d-lg-none position-fixed';
        sidebarToggle.style.zIndex = '1000';
        sidebarToggle.style.bottom = '20px';
        sidebarToggle.style.right = '20px';
        sidebarToggle.style.borderRadius = '50%';
        sidebarToggle.style.width = '50px';
        sidebarToggle.style.height = '50px';
        sidebarToggle.style.display = 'flex';
        sidebarToggle.style.alignItems = 'center';
        sidebarToggle.style.justifyContent = 'center';
        
        sidebarToggle.addEventListener('click', function() {
            sidebar.style.transform = sidebar.style.transform === 'translateX(0px)' ? 'translateX(-100%)' : 'translateX(0)';
        });
        
        document.body.appendChild(sidebarToggle);
    });

    // Search functionality
    const searchInput = document.getElementById('searchInput');
    const tableRows = document.querySelectorAll('#apprenantsTable tbody tr');
    const noResults = document.getElementById('noResults');

    function filterApprenants() {
        const searchTerm = searchInput.value.toLowerCase();
        let visibleCount = 0;

        tableRows.forEach(row => {
            const name = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            const email = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
            
            if (name.includes(searchTerm) || email.includes(searchTerm)) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        if (visibleCount === 0 && searchTerm.length > 0) {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
        }
    }

    searchInput.addEventListener('input', filterApprenants);
</script>
</body>
</html>