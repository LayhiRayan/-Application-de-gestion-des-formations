<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Formation" %>

<%
    List<Formation> formations = (List<Formation>) request.getAttribute("formations");
%>

<h2>📘 Formations disponibles</h2>

<% if (formations != null && !formations.isEmpty()) { %>
    <ul>
    <% for (Formation f : formations) { %>
        <li>
            <strong><%= f.getTitre() %></strong> - <%= f.getDescription() %> - <%= f.getDuree() %>h
            <form action="<%= request.getContextPath() %>/inscrireFormation" method="post" style="display:inline;">
                <input type="hidden" name="formationId" value="<%= f.getId() %>"/>
                <button type="submit">S'inscrire</button>
            </form>
        </li>
    <% } %>
    </ul>
<% } else { %>
    <p>Aucune formation disponible à l’inscription.</p>
<% } %>
