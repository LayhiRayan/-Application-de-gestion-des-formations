package controllers;

import entities.Formation;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FormationsPageController", urlPatterns = {"/admin/formations"})
public class FormationsPageController extends HttpServlet {

    private FormationService formationService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Charger toutes les formations
        List<Formation> formations = formationService.findAll();
        request.setAttribute("formations", formations);

        // Forward vers la page JSP
        request.getRequestDispatcher("/views/admin/formations.jsp").forward(request, response);
    }
}
