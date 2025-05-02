<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("user");
    String role = (String) session.getAttribute("type");

    if (admin == null || !"admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Statistiques - Nombre d'apprenants par formation</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        
        /* Card Styling */
        .stat-card {
            border-radius: 0.5rem;
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: all 0.3s ease;
            background: white;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .stat-card-header {
            background-color: var(--primary-color);
            color: white;
            padding: 1rem;
            font-weight: 600;
            border-bottom: none;
        }
        
        .stat-card-body {
            padding: 1.5rem;
        }
        
        /* Chart Container */
        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
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
            <a href="<%= request.getContextPath() %>/admin/formations">
                <i class="fas fa-book-open"></i> <span>Formations</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="300">
            <a href="<%= request.getContextPath() %>/admin/statistiques" class="active">
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
    <div class="dashboard-header d-flex justify-content-between align-items-center" data-aos="fade-down">
        <div class="d-flex align-items-center">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <div>
                <h1 class="h3 mb-0">📊 Statistiques des formations</h1>
                <p class="mb-0 opacity-75">Visualisation des données des apprenants par formation</p>
            </div>
        </div>
        <div>
            <span class="badge bg-light text-dark">
                <i class="fas fa-user-shield me-1"></i> <%= admin.getNom() %>
            </span>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="row mb-4">
        <div class="col-12" data-aos="fade-up">
            <div class="stat-card">
                <div class="stat-card-header d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fas fa-chart-bar me-2"></i> Nombre d'apprenants par formation
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-filter me-1"></i> Filtres
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <li><a class="dropdown-item" href="#">Toutes les formations</a></li>
                            <li><a class="dropdown-item" href="#">Formations actives</a></li>
                            <li><a class="dropdown-item" href="#">Formations terminées</a></li>
                        </ul>
                    </div>
                </div>
                <div class="stat-card-body">
                    <div class="chart-container">
                        <canvas id="formationsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row" data-aos="fade-up" data-aos-delay="150">
        <div class="col-md-4 mb-4">
            <div class="stat-card h-100">
                <div class="stat-card-header">
                    <i class="fas fa-users me-2"></i> Total Apprenants
                </div>
                <div class="stat-card-body">
                    <h3 class="text-center display-4" id="totalApprenants">0</h3>
                    <p class="text-center text-muted mb-0">Toutes formations confondues</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="stat-card h-100">
                <div class="stat-card-header">
                    <i class="fas fa-book-open me-2"></i> Formations Actives
                </div>
                <div class="stat-card-body">
                    <h3 class="text-center display-4" id="activeFormations">0</h3>
                    <p class="text-center text-muted mb-0">Actuellement disponibles</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="stat-card h-100">
                <div class="stat-card-header">
                    <i class="fas fa-star me-2"></i> Formation Populaire
                </div>
                <div class="stat-card-body">
                    <h3 class="text-center" id="popularFormation">-</h3>
                    <p class="text-center text-muted mb-0">Avec le plus d'apprenants</p>
                </div>
            </div>
        </div>
    </div>
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

    // Load data and create chart
    document.addEventListener('DOMContentLoaded', function() {
        fetch('<%= request.getContextPath() %>/StatistiquesController')
            .then(response => response.json())
            .then(data => {
                const labels = Object.keys(data);
                const values = Object.values(data);
                
                // Update stats cards
                document.getElementById('totalApprenants').textContent = 
                    values.reduce((a, b) => a + b, 0);
                document.getElementById('activeFormations').textContent = labels.length;
                
                // Find most popular formation
                if (labels.length > 0) {
                    const maxIndex = values.indexOf(Math.max(...values));
                    document.getElementById('popularFormation').textContent = 
                        labels[maxIndex] + " (" + values[maxIndex] + ")";
                }
                
                // Create chart
                const ctx = document.getElementById('formationsChart').getContext('2d');
                const chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Nombre d\'apprenants',
                            data: values,
                            backgroundColor: 'rgba(78, 115, 223, 0.7)',
                            borderColor: 'rgba(78, 115, 223, 1)',
                            borderWidth: 1,
                            borderRadius: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 1,
                                    precision: 0
                                },
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.05)'
                                }
                            },
                            x: {
                                grid: {
                                    display: false
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: {
                                        size: 14
                                    },
                                    padding: 20
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                titleFont: {
                                    size: 14
                                },
                                bodyFont: {
                                    size: 14
                                },
                                padding: 12,
                                cornerRadius: 4,
                                displayColors: false,
                                callbacks: {
                                    label: function(context) {
                                        return context.parsed.y + ' apprenant(s)';
                                    }
                                }
                            }
                        },
                        animation: {
                            duration: 1500,
                            easing: 'easeOutQuart'
                        }
                    }
                });
            })
            .catch(error => console.error('Erreur chargement données:', error));
    });
</script>
</body>
</html>