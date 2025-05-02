/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Apprenant;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.ApprenantService;

/**
 *
 * @author HP-PC
 */
@WebServlet(name = "UpdateProfileController", urlPatterns = {"/UpdateProfileController"})
public class UpdateProfileController extends HttpServlet {

    private ApprenantService apprenantService;

    @Override
    public void init() {
        apprenantService = new ApprenantService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Apprenant apprenant = (Apprenant) session.getAttribute("user");

        if (apprenant != null) {
            String nouveauNom = request.getParameter("nom");
            String nouvelEmail = request.getParameter("email");

            apprenant.setNom(nouveauNom);
            apprenant.setEmail(nouvelEmail);
            apprenantService.update(apprenant);

            // Met à jour dans la session aussi
            session.setAttribute("user", apprenant);
        }

        response.sendRedirect(request.getContextPath() + "/views/apprenants/dashboard.jsp");
    }
}

