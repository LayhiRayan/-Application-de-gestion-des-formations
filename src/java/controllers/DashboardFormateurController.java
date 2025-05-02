package controllers;

import entities.Formateur;
import entities.Formation;
import services.FormationService;
import services.InscriptionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardFormateurController", urlPatterns = {"/formateur/dashboard"})
public class DashboardFormateurController extends HttpServlet {

    private FormationService formationService;
    private InscriptionService inscriptionService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
        inscriptionService = new InscriptionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Formateur formateur = (Formateur) session.getAttribute("user");

        if (formateur == null) {
            response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
            return;
        }

        List<Formation> formations = formationService.findByFormateur(formateur.getId());

        request.setAttribute("formateur", formateur);
        request.setAttribute("formations", formations);

        request.getRequestDispatcher("/views/formateur/dashboard-formateur.jsp").forward(request, response);
    }
}
