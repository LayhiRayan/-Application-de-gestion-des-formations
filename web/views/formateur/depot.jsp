<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Formation" %>
<%
    Formation formation = (Formation) request.getAttribute("formation");
    if (formation == null) {
        response.sendRedirect(request.getContextPath() + "/formateur/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>📁 Dépôt de Cours</title>
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

        .form-container {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2.5rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-title {
            color: var(--primary);
            margin-bottom: 2rem;
            font-weight: 600;
            position: relative;
            padding-bottom: 0.75rem;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }

        .form-label {
            font-weight: 500;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .form-control {
            padding: 0.8rem 1.2rem;
            border-radius: var(--radius);
            border: 1px solid #e0e0e0;
            transition: var(--transition);
            margin-bottom: 1.5rem;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(108, 92, 231, 0.2);
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
        }

        .btn-success {
            background-color: var(--accent);
            border-color: var(--accent);
        }

        .btn-success:hover {
            background-color: #00b7a8;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
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

        .file-upload {
            border: 2px dashed #e0e0e0;
            border-radius: var(--radius);
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
            transition: var(--transition);
            cursor: pointer;
        }

        .file-upload:hover {
            border-color: var(--primary);
            background-color: rgba(108, 92, 231, 0.05);
        }

        .file-upload i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
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
    <div class="form-container">
        <h3 class="form-title">
            <i class="fas fa-file-upload me-2"></i>Déposer un Cours
            <small class="d-block text-muted mt-2">Pour : <%= formation.getTitre() %></small>
        </h3>

        <form action="<%= request.getContextPath() %>/UploadCoursController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="formationId" value="<%= formation.getId() %>">

            <div class="mb-4">
                <label class="form-label">Titre du Cours</label>
                <input type="text" name="titre" class="form-control" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Contenu du Cours (description courte)</label>
                <textarea name="contenu" class="form-control" rows="3" required></textarea>
            </div>

            <div class="mb-4">
                <label class="form-label">Fichier PDF du cours</label>
                <div class="file-upload" id="fileUploadArea">
                    <input type="file" name="pdf" accept="application/pdf" class="d-none" id="fileInput" required>
                    <label for="fileInput" class="d-block">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <div class="mt-2">Glissez-déposez votre fichier ou cliquez pour sélectionner</div>
                        <small class="text-muted">Formats acceptés: PDF (max 10MB)</small>
                    </label>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Lien vers une vidéo explicative (YouTube ou autre)</label>
                <input type="url" name="lienVideo" class="form-control">
            </div>

            <div class="d-flex justify-content-end">
                <a href="<%= request.getContextPath() %>/formateur/dashboard" class="btn btn-secondary me-3">
                    <i class="fas fa-arrow-left me-2"></i>Retour
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-upload me-2"></i>Envoyer le Cours
                </button>
            </div>
        </form>
    </div>
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
        
        // File upload feedback
        const fileInput = document.getElementById('fileInput');
        const fileUploadArea = document.getElementById('fileUploadArea');
        
        fileInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const fileSizeMB = Math.round((this.files[0].size / (1024 * 1024) * 100) / 100;
                fileUploadArea.innerHTML = `
                    <i class="fas fa-check-circle text-success"></i>
                    <div class="mt-2">${this.files[0].name}</div>
                    <small class="text-muted">${fileSizeMB} MB</small>
                    <input type="file" name="pdf" accept="application/pdf" class="d-none" id="fileInput" required>
                `;
                fileUploadArea.style.borderColor = '#00cec9';
            }
        });
    });
</script>
</body>
</html>