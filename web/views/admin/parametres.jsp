<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Paramètres Administrateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
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
        .settings-card {
            border-radius: 0.5rem;
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: all 0.3s ease;
            background: white;
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        .settings-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .settings-card-header {
            background-color: var(--primary-color);
            color: white;
            padding: 1.25rem;
            font-weight: 600;
            border-bottom: none;
            display: flex;
            align-items: center;
        }
        
        .settings-card-header i {
            margin-right: 0.75rem;
            font-size: 1.25rem;
        }
        
        .settings-card-body {
            padding: 2rem;
        }
        
        /* Form Elements */
        .form-label {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .form-control {
            border-radius: 0.35rem;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d3e2;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
        
        /* Buttons */
        .btn {
            border-radius: 0.35rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn i {
            margin-right: 0.5rem;
        }
        
        .btn-success {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .btn-success:hover {
            background-color: #17a673;
            border-color: #17a673;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .btn-warning {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
            color: #000;
        }
        
        .btn-warning:hover {
            background-color: #dda20a;
            border-color: #dda20a;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .btn-secondary {
            background-color: #858796;
            border-color: #858796;
        }
        
        .btn-secondary:hover {
            background-color: #6c6e7e;
            border-color: #6c6e7e;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        /* Divider */
        .divider {
            border-top: 1px solid #e3e6f0;
            margin: 1.5rem 0;
            position: relative;
        }
        
        .divider-text {
            position: absolute;
            top: -0.75rem;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            padding: 0 1rem;
            color: #b7b9cc;
            font-size: 0.875rem;
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
            <a href="<%= request.getContextPath() %>/admin/statistiques">
                <i class="fas fa-chart-pie"></i> <span>Statistiques</span>
            </a>
        </li>
        <li data-aos="fade-right" data-aos-delay="350">
            <a href="<%= request.getContextPath() %>/admin/parametres" class="active">
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
                <h1 class="h3 mb-0">⚙️ Paramètres du compte</h1>
                <p class="mb-0 opacity-75">Gérez vos informations personnelles et votre sécurité</p>
            </div>
        </div>
        <div>
            <span class="badge bg-light text-dark">
                <i class="fas fa-user-shield me-1"></i> <%= admin.getNom() %>
            </span>
        </div>
    </div>

    <!-- Settings Card -->
    <div class="settings-card" data-aos="fade-up">
        <div class="settings-card-header">
            <i class="fas fa-user-cog"></i> Informations du compte
        </div>
        <div class="settings-card-body">
            <form action="<%= request.getContextPath() %>/UpdateAdminProfileController" method="post">
                <div class="mb-4" data-aos="fade-up" data-aos-delay="100">
                    <label class="form-label">Nom complet</label>
                    <input type="text" name="nom" class="form-control" value="<%= admin.getNom() %>" required>
                </div>
                
                <div class="mb-4" data-aos="fade-up" data-aos-delay="150">
                    <label class="form-label">Adresse email</label>
                    <input type="email" name="email" class="form-control" value="<%= admin.getEmail() %>" required>
                </div>

                <div class="d-flex justify-content-between mt-4" data-aos="fade-up" data-aos-delay="200">
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='<%= request.getContextPath() %>/admin/dashboard-admin'">
                        <i class="fas fa-times"></i> Annuler
                    </button>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Enregistrer
                    </button>
                </div>
            </form>

            <div class="divider" data-aos="fade-in" data-aos-delay="250">
                <span class="divider-text">Sécurité</span>
            </div>

            <div class="text-center" data-aos="fade-up" data-aos-delay="300">
                <a href="<%= request.getContextPath() %>/views/users/forgotPassword.jsp" class="btn btn-warning">
                    <i class="fas fa-key"></i> Changer le mot de passe
                </a>
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
</script>
</body>
</html>