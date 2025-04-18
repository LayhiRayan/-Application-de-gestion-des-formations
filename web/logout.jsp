<%@ page session="true" %>
<%
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
%>
