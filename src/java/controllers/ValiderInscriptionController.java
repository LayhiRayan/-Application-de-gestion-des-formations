/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Apprenant;
import entities.Formation;
import entities.Inscription;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.ApprenantService;
import services.FormationService;
import services.InscriptionService;

/**
 *
 * @author HP-PC
 */
@WebServlet(name = "ValiderInscriptionController", urlPatterns = {"/ValiderInscriptionController"})
public class ValiderInscriptionController extends HttpServlet {

    private final InscriptionService inscriptionService = new InscriptionService();
    private final FormationService formationService = new FormationService();
    private final ApprenantService apprenantService = new ApprenantService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int formationId = Integer.parseInt(request.getParameter("formationId"));
        int apprenantId = Integer.parseInt(request.getParameter("apprenantId"));

        Formation formation = formationService.findById(formationId);
        Apprenant apprenant = apprenantService.findById(apprenantId);

        if (formation != null && apprenant != null) {
            Inscription i = new Inscription();
            i.setFormation(formation);
            i.setApprenant(apprenant);
            i.setDateInscription(new java.sql.Date(System.currentTimeMillis()));
            inscriptionService.create(i);
        }

        response.sendRedirect("dashboard.jsp");
    }
}
