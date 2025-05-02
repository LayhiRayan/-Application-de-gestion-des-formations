package controllers;

import entities.Formation;
import entities.Cours;
import services.CoursService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet(name = "DepotController", urlPatterns = {"/formateur/depot"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 10 * 1024 * 1024,   // 10MB
                 maxRequestSize = 20 * 1024 * 1024) // 20MB
public class DepotController extends HttpServlet {

    private final FormationService formationService = new FormationService();
    private final CoursService coursService = new CoursService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int formationId = Integer.parseInt(request.getParameter("formationId"));
        String titre = request.getParameter("titre");
        String lienVideo = request.getParameter("lienVideo");

        Formation formation = formationService.findById(formationId);

        Part fichierPdf = request.getPart("coursPdf");

        String fileName = new File(fichierPdf.getSubmittedFileName()).getName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String filePath = uploadPath + File.separator + fileName;
        fichierPdf.write(filePath);

        // Enregistrement dans la base de données (ou logique métier)
        Cours cours = new Cours();
        cours.setTitre(titre);
        cours.setLienVideo(lienVideo);
        cours.setPdfPath("uploads/" + fileName);
        cours.setFormation(formation);

        coursService.create(cours);

        response.sendRedirect(request.getContextPath() + "/formateur/dashboard");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int formationId = Integer.parseInt(request.getParameter("formationId"));
        Formation formation = formationService.findById(formationId);

        request.setAttribute("formation", formation);
        request.getRequestDispatcher("/views/formateur/depot.jsp").forward(request, response);
    }
}
