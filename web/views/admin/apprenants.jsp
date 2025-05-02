<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Apprenant, entities.Formation" %>
<%@ page pageEncoding="UTF-8" %>
<%
    List<Apprenant> apprenants = (List<Apprenant>) request.getAttribute("apprenants");
    List<Formation> formations = (List<Formation>) request.getAttribute("formations");
    if (apprenants == null) {
        apprenants = new java.util.ArrayList();
    }
    if (formations == null) {
        formations = new java.util.ArrayList();
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Affecter Apprenant à Formation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">🎯 Affecter Apprenants aux Formations</h2>

    <% if (apprenants.isEmpty()) { %>
        <div class="alert alert-warning">Aucun apprenant disponible.</div>
    <% } else if (formations.isEmpty()) { %>
        <div class="alert alert-warning">Aucune formation disponible.</div>
    <% } else { %>

    <div class="table-responsive">
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Nom Apprenant</th>
                    <th>Email</th>
                    <th>Choisir Formation</th>
                    <th>Affecter</th>
                </tr>
            </thead>
            <tbody>
                <% for (Apprenant a : apprenants) { %>
                <tr>
                    <td><%= a.getNom() %></td>
                    <td><%= a.getEmail() %></td>
                    <td>
                        <form action="AffecterApprenantController" method="post" class="d-flex gap-2">
                            <input type="hidden" name="apprenantId" value="<%= a.getId() %>">
                            <select name="formationId" class="form-select" required>
                                <option value="">-- Sélectionner --</option>
                                <% for (Formation f : formations) { %>
                                    <option value="<%= f.getId() %>"><%= f.getTitre() %></option>
                                <% } %>
                            </select>
                    </td>
                    <td>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-plus"></i> Affecter
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
