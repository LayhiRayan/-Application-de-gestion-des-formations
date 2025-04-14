package test;

import dao.ApprenantDao;
import dao.FormateurDao;
import dao.FormationDao;
import dao.InscriptionDao;
import entities.Apprenant;
import entities.Formateur;
import entities.Formation;
import entities.Inscription;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TestInsertion {

    public static void main(String[] args) {

        // DAOs
        FormateurDao formateurDao = new FormateurDao();
        FormationDao formationDao = new FormationDao();
        ApprenantDao apprenantDao = new ApprenantDao();
        InscriptionDao inscriptionDao = new InscriptionDao();

        // -------- 1. Création des formateurs --------
        Formateur f1 = new Formateur("Dr. Karim", "karim@gmail.com", "pass123", "Sécurité informatique");
        Formateur f2 = new Formateur("Mme. Sarah", "sarah@gmail.com", "pass456", "Base de données");
        formateurDao.create(f1);
        formateurDao.create(f2);

        // -------- 2. Création des formations --------
        Formation cyber = new Formation("Cybersécurité", "Intro à la sécurité réseau", 40);
        Formation sql = new Formation("SQL Avancé", "Requêtes complexes et optimisation", 30);
        cyber.setFormateur(f1);
        sql.setFormateur(f2);
        formationDao.create(cyber);
        formationDao.create(sql);

        // -------- 3. Création des apprenants --------
        Apprenant a1 = new Apprenant("Ahmed", "ahmed@gmail.com", "1234");
        Apprenant a2 = new Apprenant("Leila", "leila@gmail.com", "abcd");
        Apprenant a3 = new Apprenant("Yassine", "yassine@gmail.com", "secure");
        apprenantDao.create(a1);
        apprenantDao.create(a2);
        apprenantDao.create(a3);

        // -------- 4. Inscriptions --------
        List<Inscription> inscriptions = Arrays.asList(
            new Inscription(new Date(), cyber, a1),
            new Inscription(new Date(), cyber, a2),
            new Inscription(new Date(), sql, a2),
            new Inscription(new Date(), sql, a3)
        );
        for (Inscription insc : inscriptions) {
            inscriptionDao.create(insc);
        }

        // -------- 5. Affichage des inscriptions --------
        List<Apprenant> apprenants = Arrays.asList(a1, a2, a3);

        for (Apprenant apprenant : apprenants) {
            Apprenant fetched = apprenantDao.findById(apprenant.getId());
            System.out.println("\n📋 Inscriptions de " + fetched.getNom() + " :");
            if (fetched.getInscriptions() != null && !fetched.getInscriptions().isEmpty()) {
                for (Inscription insc : fetched.getInscriptions()) {
                    System.out.println("➡ " + insc.getFormation().getTitre() + " | Date : " + insc.getDateInscription());
                }
            } else {
                System.out.println("❌ Aucune inscription trouvée.");
            }
        }
    }
}
