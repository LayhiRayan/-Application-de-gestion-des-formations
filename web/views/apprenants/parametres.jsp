<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Apprenant" %>
<%@ page import="entities.Inscription" %>
<%@ page import="java.util.List" %>

<%
    Apprenant apprenant = (Apprenant) session.getAttribute("user");
    String role = (String) session.getAttribute("type");
    List<Inscription> inscriptions = (List<Inscription>) session.getAttribute("inscriptions");

    if (apprenant == null || !"apprenant".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Paramètres du compte</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            --card-bg: #ffffff;
            --text: #333333;
            --sidebar-bg: linear-gradient(135deg, #3a0ca3 0%, #4361ee 100%);
            --sidebar-text: #ffffff;
            --sidebar-width: 280px;
            --transition: all 0.3s ease;
            --shadow: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-hover: 0 10px 15px rgba(0,0,0,0.1);
            --radius: 10px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light);
            color: var(--text);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
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
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 2px solid rgba(255,255,255,0.2);
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
            border-radius: 5px;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .sidebar-menu li a:hover, 
        .sidebar-menu li a.active {
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }

        .sidebar-menu li a.active {
            background: rgba(255,255,255,0.2);
            font-weight: 500;
        }

        .sidebar-menu li a i {
            margin-right: 0.8rem;
            width: 20px;
            text-align: center;
        }

        .logout-btn {
            color: #ff6b6b !important;
        }

        .sidebar-info {
            margin-top: auto;
            padding: 1rem;
            background: rgba(255,255,255,0.1);
            border-radius: 5px;
            margin-top: 2rem;
        }

        .sidebar-info h4 {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }

        .sidebar-info h4 i {
            margin-right: 0.5rem;
        }

        .sidebar-info p {
            font-size: 0.85rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .header h1 i {
            margin-right: 1rem;
            color: var(--primary);
        }

        /* Settings Card */
        .settings-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: var(--shadow);
            max-width: 800px;
            margin: 0 auto;
        }

        .settings-card h2 {
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .settings-card h2 i {
            margin-right: 1rem;
            color: var(--primary);
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border-radius: 5px;
            padding: 0.75rem 1rem;
            border: 1px solid #ddd;
            transition: var(--transition);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        .btn-primary {
            background: var(--primary);
            border: none;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .btn-secondary {
            background: #f0f0f0;
            border: none;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }

        .change-password-btn {
            background: var(--primary-light);
            color: var(--primary);
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: var(--transition);
            border: none;
            cursor: pointer;
        }

        .change-password-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .change-password-btn i {
            margin-right: 0.5rem;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                transition: var(--transition);
                z-index: 1000;
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .settings-card {
            animation: fadeIn 0.3s ease-out;
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
                <a href="#">
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
                <a href="<%= request.getContextPath() %>/views/apprenants/settings.jsp" class="active">
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
            <h4><i class="fas fa-info-circle"></i> Informations</h4>
            <p>Vous avez <strong><%= inscriptions != null ? inscriptions.size() : 0%> formations</strong> en cours.</p>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-cog"></i> Paramètres du compte</h1>
        </div>

        <div class="settings-card">
            <h2><i class="fas fa-user-edit"></i> Modifier le profil</h2>
            <form action="<%= request.getContextPath() %>/UpdateProfileController" method="post">
                <div class="mb-4">
                    <label class="form-label">Nom complet</label>
                    <input type="text" class="form-control" name="nom" value="<%= apprenant.getNom() %>" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Adresse email</label>
                    <input type="email" class="form-control" name="email" value="<%= apprenant.getEmail() %>" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Mot de passe</label>
                    <button type="button" onclick="window.location.href='<%= request.getContextPath() %>/views/users/forgotPassword.jsp'" 
                            class="change-password-btn">
                        <i class="fas fa-key"></i> Changer le mot de passe
                    </button>
                </div>
                <div class="d-flex justify-content-end mt-4">
                    <a href="<%= request.getContextPath() %>/views/apprenants/dashboard.jsp" class="btn btn-secondary me-3">
                        <i class="fas fa-times"></i> Annuler
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Enregistrer
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mobile menu toggle
        document.addEventListener('DOMContentLoaded', function() {
            const menuToggle = document.createElement('button');
            menuToggle.className = 'btn btn-primary d-lg-none fixed-top m-3';
            menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            menuToggle.style.zIndex = '1001';
            document.body.prepend(menuToggle);
            
            const sidebar = document.querySelector('.sidebar');
            
            menuToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
            });
            
            // Close sidebar when clicking outside
            document.addEventListener('click', (e) => {
                if (!sidebar.contains(e.target) && e.target !== menuToggle) {
                    sidebar.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>