<%@ page session="true" contentType="text/html;charset=UTF-8" %>
<%@ page import="entities.Formateur" %>
<%
    Formateur formateur = (Formateur) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de bord Formateur</title>
</head>
<body>
    <h2>Bienvenue, <%= formateur.getNom() %></h2>
    <p>Email : <%= formateur.getEmail() %></p>

    <a href="${pageContext.request.contextPath}/logout.jsp">Déconnexion</a>
</body>
</html>
