package controllers;

import entities.Cours;
import entities.Formation;
import services.CoursService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "UploadCoursController", urlPatterns = {"/UploadCoursController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 10 * 1024 * 1024) // max 10 Mo
public class UploadCoursController extends HttpServlet {

    private final CoursService coursService = new CoursService();
    private final FormationService formationService = new FormationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int formationId = Integer.parseInt(request.getParameter("formationId"));
            String titre = request.getParameter("titre");
            String contenu = request.getParameter("contenu");
            String lienVideo = request.getParameter("lienVideo");

            Part filePart = request.getPart("pdf");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Corriger le chemin : récupère le chemin absolu vers le dossier /uploads
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // Enregistre le fichier dans le dossier
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Récupère la formation et crée le cours
            Formation formation = formationService.findById(formationId);
            Cours cours = new Cours();
            cours.setTitre(titre);
            cours.setContenu(contenu); // pas juste le nom du fichier
            cours.setFormation(formation);
            cours.setPdfPath("uploads/" + fileName); // relative path enregistré

            if (lienVideo != null && !lienVideo.isEmpty()) {
                cours.setLienVideo(lienVideo);
            }

            coursService.create(cours);

            // Redirige vers la liste des cours
            response.sendRedirect(request.getContextPath() + "/formateur/liste-cours?formationId=" + formationId);

        } catch (Exception e) {
    e.printStackTrace(); // très important
    response.setContentType("text/plain");
    response.getWriter().write("Erreur serveur : " + e.getMessage());
}

    }
}
