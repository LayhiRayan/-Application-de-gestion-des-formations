package test;

import dao.ApprenantDao;
import dao.FormateurDao;
import dao.FormationDao;
import dao.InscriptionDao;
import entities.Apprenant;
import entities.Formateur;
import entities.Formation;
import entities.Inscription;

import java.util.Date;

public class TestInsertion {

    public static void main(String[] args) {

        // DAOs
        FormateurDao formateurDao = new FormateurDao();
        FormationDao formationDao = new FormationDao();
        ApprenantDao apprenantDao = new ApprenantDao();
        InscriptionDao inscriptionDao = new InscriptionDao();

        // 1. Créer un formateur
        Formateur formateur = new Formateur("Dr. Karim", "karim@gmail.com", "pass123", "Sécurité informatique");
        formateurDao.create(formateur);

        // 2. Créer une formation liée au formateur
        Formation formation = new Formation("Cybersécurité", "Introduction à la sécurité réseau", 40);
        formation.setFormateur(formateur); // Lien entre formation et formateur
        formationDao.create(formation);

        // 3. Créer un apprenant
        Apprenant apprenant = new Apprenant("Ahmed", "ahmed@gmail.com", "1234");
        apprenantDao.create(apprenant);

        // 4. Créer une inscription (Ahmed s’inscrit à la formation)
        Inscription inscription = new Inscription(new Date(), formation, apprenant);
        inscriptionDao.create(inscription);

        // 5. Afficher les inscriptions de l'apprenant
        Apprenant fetchedApprenant = apprenantDao.findById(apprenant.getId());
        System.out.println("📋 Inscriptions de " + fetchedApprenant.getNom() + " :");
        if (fetchedApprenant.getInscriptions() != null) {
            for (Inscription insc : fetchedApprenant.getInscriptions()) {
                System.out.println("➡ " + insc.getFormation().getTitre() + " le " + insc.getDateInscription());
            }
        } else {
            System.out.println("Aucune inscription trouvée.");
        }
    }
}
