<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Formateur" %>
<%
    Formateur formateur = (Formateur) session.getAttribute("user");
    String role = (String) session.getAttribute("type");

    if (formateur == null || !"formateur".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Paramètres Formateur</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-light: #a29bfe;
            --secondary: #4a3ce7;
            --accent: #00cec9;
            --light: #f8f9fa;
            --dark: #2d3436;
            --card-bg: #ffffff;
            --text: #2d3436;
            --sidebar-bg: linear-gradient(135deg, #2d3436 0%, #6c5ce7 100%);
            --sidebar-text: rgba(255, 255, 255, 0.9);
            --sidebar-width: 280px;
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-hover: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --radius: 12px;
            --glass: rgba(255, 255, 255, 0.08);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f6fa;
            color: var(--text);
            display: flex;
            min-height: 100vh;
            background-image: radial-gradient(circle at 10% 20%, rgba(166, 177, 255, 0.1) 0%, rgba(214, 214, 255, 0.1) 90%);
        }

        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            box-shadow: var(--shadow);
            z-index: 10;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-right: 1px solid var(--glass);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--glass);
        }

        .sidebar-header img {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
        }

        .sidebar-header:hover img {
            transform: rotate(5deg) scale(1.05);
        }

        .sidebar-header div h3 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.2rem;
            letter-spacing: 0.5px;
        }

        .sidebar-header div p {
            font-size: 0.85rem;
            opacity: 0.9;
            color: var(--primary-light);
        }

        .sidebar-menu {
            list-style: none;
            margin-top: 2rem;
            padding-left: 0;
        }

        .sidebar-menu li {
            margin-bottom: 0.75rem;
            position: relative;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 0.9rem 1.2rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: var(--radius);
            font-size: 0.95rem;
            transition: var(--transition);
            background: var(--glass);
            backdrop-filter: blur(5px);
        }

        .sidebar-menu li a:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .sidebar-menu li a.active {
            background: linear-gradient(90deg, var(--primary), rgba(108, 92, 231, 0.7));
            box-shadow: 0 10px 20px rgba(108, 92, 231, 0.3);
            font-weight: 500;
            transform: translateX(8px);
        }

        .sidebar-menu li a i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        .logout-btn {
            color: #ff7675 !important;
            background: rgba(255, 118, 117, 0.1) !important;
        }

        .logout-btn:hover {
            background: rgba(255, 118, 117, 0.2) !important;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 3rem;
            transition: var(--transition);
        }

        .settings-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 2.5rem;
            box-shadow: var(--shadow);
            max-width: 800px;
            margin: 0 auto;
            border: none;
            position: relative;
            overflow: hidden;
            transition: var(--transition);
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
        }

        .settings-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .settings-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
        }

        .settings-card h2 {
            color: var(--dark);
            margin-bottom: 2rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 1rem;
            font-size: 1.8rem;
        }

        .settings-card h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary);
            border-radius: 2px;
        }

        .settings-card h2 i {
            color: var(--primary);
            margin-right: 1rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.75rem;
            display: block;
            font-size: 0.95rem;
        }

        .form-control {
            padding: 0.85rem 1.25rem;
            border-radius: var(--radius);
            border: 1px solid #dfe6e9;
            transition: var(--transition);
            font-size: 0.95rem;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.25);
            transform: translateY(-2px);
        }

        .btn {
            padding: 0.85rem 1.75rem;
            font-weight: 600;
            border-radius: var(--radius);
            transition: var(--transition);
            letter-spacing: 0.5px;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            box-shadow: 0 4px 6px rgba(108, 92, 231, 0.3);
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            border-color: var(--secondary);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(108, 92, 231, 0.4);
        }

        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 15px rgba(108, 92, 231, 0.4);
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

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                z-index: 1000;
            }
            
            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }
            
            .settings-card {
                padding: 1.5rem;
            }
        }

        /* Animation */
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

        .settings-card {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        /* Floating animation for sidebar items */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .sidebar-menu li {
            animation: float 4s ease-in-out infinite;
        }

        .sidebar-menu li:nth-child(1) { animation-delay: 0.1s; }
        .sidebar-menu li:nth-child(2) { animation-delay: 0.2s; }
        .sidebar-menu li:nth-child(3) { animation-delay: 0.3s; }
        .sidebar-menu li:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=<%= formateur.getNom()%>&background=random&color=fff" alt="Profile">
            <div>
                <h3><%= formateur.getNom()%></h3>
                <p>Formateur</p>
            </div>
        </div>

        <ul class="sidebar-menu">
            <li>
                <a href="<%= request.getContextPath() %>/formateur/dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    Tableau de bord
                </a>
            </li>
            
            
            <li>
                <a href="<%= request.getContextPath()%>/views/formateur/parametres.jsp" class="active">
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
    </div>

    <div class="main-content">
        <div class="settings-card">
            <h2><i class="fas fa-user-edit"></i> Modifier le profil</h2>
            <form action="<%= request.getContextPath() %>/UpdateFormateurProfileController" method="post">
                <div class="mb-4">
                    <label class="form-label">Nom complet</label>
                    <input type="text" class="form-control" name="nom" value="<%= formateur.getNom() %>" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Adresse email</label>
                    <input type="email" class="form-control" name="email" value="<%= formateur.getEmail() %>" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Mot de passe</label>
                    <button type="button" onclick="window.location.href='<%= request.getContextPath() %>/views/users/forgotPassword.jsp'" 
                            class="btn btn-outline-primary">
                        <i class="fas fa-key"></i> Changer le mot de passe
                    </button>
                </div>
                <div class="d-flex justify-content-end mt-4">
                    <a href="<%= request.getContextPath() %>/formateur/dashboard" class="btn btn-secondary me-3">
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
        // Add subtle animation to form elements
        document.querySelectorAll('.form-control').forEach((input, index) => {
            input.style.opacity = '0';
            input.style.transform = 'translateY(10px)';
            input.style.transition = 'all 0.5s ease ' + (index * 0.1) + 's';
            
            setTimeout(() => {
                input.style.opacity = '1';
                input.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>