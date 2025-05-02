package controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "StatistiquesPageController", urlPatterns = {"/admin/statistiques"})
public class StatistiquesPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ✅ Affiche la page JSP statistiques
        request.getRequestDispatcher("/views/admin/statistiques.jsp").forward(request, response);
    }
}
