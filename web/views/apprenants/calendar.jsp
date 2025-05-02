<%@page import="entities.Inscription"%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Apprenant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
<html>
<head>
    <title>Calendrier des Formations</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #e0e7ff;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #560bad;
            --card-bg: #ffffff;
            --text: #333333;
            --sidebar-bg: linear-gradient(135deg, #3a0ca3 0%, #4361ee 100%);
            --sidebar-text: #ffffff;
            --sidebar-width: 280px;
            --header-height: 80px;
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            --shadow: 0 10px 20px rgba(0,0,0,0.08);
            --shadow-hover: 0 15px 30px rgba(0,0,0,0.12);
            --radius: 12px;
            --radius-sm: 8px;
        }

        .dark-mode {
            --light: #1a1a2e;
            --dark: #f8f9fa;
            --card-bg: #16213e;
            --text: #f0f0f0;
            --sidebar-bg: linear-gradient(135deg, #0f0c29 0%, #302b63 100%);
            --sidebar-text: #e6e6e6;
            --shadow: 0 10px 20px rgba(0,0,0,0.2);
            --shadow-hover: 0 15px 30px rgba(0,0,0,0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: var(--transition);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light);
            color: var(--text);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
            line-height: 1.6;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            z-index: 100;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            transform: translateX(0);
            transition: var(--transition);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 3px solid rgba(255,255,255,0.2);
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
            border-radius: var(--radius-sm);
            font-size: 0.95rem;
            font-weight: 500;
            opacity: 0.9;
        }

        .sidebar-menu li a i {
            margin-right: 0.8rem;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .sidebar-menu li a:hover, .sidebar-menu li a.active {
            background: rgba(255,255,255,0.1);
            opacity: 1;
            transform: translateX(5px);
        }

        .sidebar-menu li a.active {
            background: rgba(255,255,255,0.2);
            font-weight: 600;
        }

        .logout-btn {
            color: #ff6b6b !important;
        }

        .sidebar-info {
            margin-top: 2rem;
            padding: 1.2rem;
            background: rgba(255,255,255,0.1);
            border-radius: var(--radius-sm);
            position: relative;
            overflow: hidden;
        }

        .sidebar-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.05));
            z-index: 0;
        }

        .sidebar-info h4 {
            font-size: 0.9rem;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            position: relative;
        }

        .sidebar-info h4 i {
            margin-right: 0.6rem;
        }

        .sidebar-info p {
            font-size: 0.85rem;
            opacity: 0.9;
            position: relative;
        }

        .sidebar-info p strong {
            color: #fff;
            font-weight: 600;
        }

        .progress-container {
            margin-top: 1rem;
            height: 6px;
            background: rgba(255,255,255,0.1);
            border-radius: 3px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar {
            height: 100%;
            width: <%= inscriptions != null ? (inscriptions.size() > 0 ? "65%" : "0%") : "0%" %>;
            background: linear-gradient(90deg, #4cc9f0, #4895ef);
            border-radius: 3px;
            position: relative;
            animation: progressAnimation 2s ease-in-out;
        }

        @keyframes progressAnimation {
            0% { width: 0%; }
            100% { width: <%= inscriptions != null ? (inscriptions.size() > 0 ? "65%" : "0%") : "0%" %>; }
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: var(--transition);
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .dark-mode .header {
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--text);
            cursor: pointer;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
        }

        .header h1 i {
            margin-right: 1rem;
            color: var(--primary);
        }

        .toggle-dark {
            background: var(--card-bg);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: var(--shadow);
            color: var(--text);
        }

        .toggle-dark:hover {
            transform: scale(1.1);
        }

        /* Calendar Styles */
        #calendar {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: var(--shadow);
        }

        .fc-header-toolbar {
            background: var(--card-bg);
            padding: 1rem;
            border-radius: var(--radius-sm);
            margin-bottom: 1.5rem !important;
            border: none;
        }

        .fc-toolbar-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--text);
        }

        .fc-button {
            background: var(--primary) !important;
            border: none !important;
            color: white !important;
            padding: 0.5rem 1rem !important;
            border-radius: var(--radius-sm) !important;
            font-weight: 500 !important;
            text-transform: capitalize !important;
            box-shadow: var(--shadow) !important;
        }

        .fc-button:hover {
            background: var(--secondary) !important;
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-hover) !important;
        }

        .fc-button-primary:not(:disabled).fc-button-active {
            background: var(--secondary) !important;
        }

        .fc-daygrid-day {
            border: 1px solid rgba(0,0,0,0.05) !important;
        }

        .dark-mode .fc-daygrid-day {
            border: 1px solid rgba(255,255,255,0.05) !important;
        }

        .fc-day-today {
            background: rgba(67, 97, 238, 0.05) !important;
        }

        .fc-event {
            background: var(--primary) !important;
            border: none !important;
            padding: 0.5rem !important;
            border-radius: var(--radius-sm) !important;
            box-shadow: var(--shadow) !important;
        }

        .fc-event:hover {
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-hover) !important;
        }

        .fc-daygrid-event-dot {
            border-color: white !important;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .menu-toggle {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.5rem;
            }

            #calendar {
                padding: 1rem;
            }

            .fc-header-toolbar {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Floating animation for sidebar elements */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
            100% { transform: translateY(0px); }
        }

        .sidebar-info:hover {
            animation: float 3s ease-in-out infinite;
        }

        /* Pulse animation for active item */
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(67, 97, 238, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(67, 97, 238, 0); }
            100% { box-shadow: 0 0 0 0 rgba(67, 97, 238, 0); }
        }

        .sidebar-menu li a.active {
            animation: pulse 2s infinite;
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
                <a href="<%= request.getContextPath() %>/views/apprenants/calendar.jsp" class="active">
                    <i class="fas fa-calendar-alt"></i>
                    Calendrier
                </a>
            </li>
            
            <li>
                <a href="<%= request.getContextPath() %>/views/apprenants/parametres.jsp">
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
            <h4>
                <i class="fas fa-info-circle"></i>
                Informations
            </h4>
            <p>
                Vous avez <strong><%= inscriptions != null ? inscriptions.size() : 0%> formations</strong> en cours.
            </p>
            <div class="progress-container">
                <div class="progress-bar"></div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <button class="menu-toggle" id="menuToggle">
                <i class="fas fa-bars"></i>
            </button>
            <h1><i class="fas fa-calendar-alt"></i> Calendrier des Formations</h1>
            <button class="toggle-dark" id="toggleDark">
                <i class="fas fa-moon"></i>
            </button>
        </div>

        <div id="calendar"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/fr.min.js"></script>
    <script>
        // Toggle dark mode
        const toggleDark = document.getElementById('toggleDark');
        const body = document.body;
        
        // Check for saved user preference or use OS preference
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const currentTheme = localStorage.getItem('theme');
        
        if (currentTheme === 'dark' || (!currentTheme && prefersDark)) {
            body.classList.add('dark-mode');
            toggleDark.innerHTML = '<i class="fas fa-sun"></i>';
        }

        toggleDark.addEventListener('click', () => {
            body.classList.toggle('dark-mode');
            if (body.classList.contains('dark-mode')) {
                localStorage.setItem('theme', 'dark');
                toggleDark.innerHTML = '<i class="fas fa-sun"></i>';
            } else {
                localStorage.setItem('theme', 'light');
                toggleDark.innerHTML = '<i class="fas fa-moon"></i>';
            }
        });
        
        // Mobile menu toggle
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.querySelector('.sidebar');
        
        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 992 && !sidebar.contains(e.target) && e.target !== menuToggle) {
                sidebar.classList.remove('active');
            }
        });

        // Initialize FullCalendar
        document.addEventListener('DOMContentLoaded', function() {
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'fr',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                buttonText: {
                    today: 'Aujourd\'hui',
                    month: 'Mois',
                    week: 'Semaine',
                    day: 'Jour',
                    list: 'Liste'
                },
                navLinks: true,
                nowIndicator: true,
                events: [
                    <% for (Inscription ins : inscriptions) { %>
                        {
                            title: "<%= ins.getFormation().getTitre().replace("\"", "\\\"") %>",
                            start: "<%= new SimpleDateFormat("yyyy-MM-dd").format(ins.getDateInscription()) %>",
                            backgroundColor: 'var(--primary)',
                            borderColor: 'var(--primary)'
                        },
                    <% } %>
                ],
                eventClick: function(info) {
                    info.jsEvent.preventDefault();
                    // You can add custom event click behavior here
                }
            });
            calendar.render();
        });
    </script>
</body>
</html>