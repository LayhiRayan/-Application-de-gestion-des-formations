package test;

import dao.FormateurDao;
import dao.FormationDao;
import dao.UserDao;
import dao.InscriptionDao;
import entities.Formateur;
import entities.Formation;
import entities.User;
import entities.Inscription;
import java.util.Date;

public class TestInsertion {

    public static void main(String[] args) {

        // DAO
        FormateurDao formateurDao = new FormateurDao();
        FormationDao formationDao = new FormationDao();
        UserDao userDao = new UserDao();
        InscriptionDao inscriptionDao = new InscriptionDao();

        // 1. Créer un formateur
        Formateur formateur = new Formateur("Dr. Karim", "Sécurité informatique");
        formateurDao.create(formateur);

        // 2. Créer une formation liée au formateur
        Formation formation = new Formation("Cybersécurité", "Introduction à la sécurité réseau", 40);
        formation.setFormateur(formateur); // Lien entre formation et formateur
        formationDao.create(formation);

        // 3. Créer un utilisateur
        User user = new User("Ahmed", "ahmed@gmail.com", "1234");
        userDao.create(user);

        // 4. Créer une inscription (Ahmed s’inscrit à la formation)
        Inscription inscription = new Inscription(new Date(), formation, user);
        inscriptionDao.create(inscription);

        // 5. Afficher les inscriptions de l'utilisateur
        User fetchedUser = userDao.findById(user.getId());
        System.out.println("📋 Inscriptions de " + fetchedUser.getNom() + " :");
        for (Inscription insc : fetchedUser.getInscriptions()) {
            System.out.println("➡ " + insc.getFormation().getTitre() + " le " + insc.getDateInscription());
        }
    }
}
