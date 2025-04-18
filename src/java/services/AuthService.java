package services;

import entities.User;
import entities.Apprenant;
import entities.Formateur;
import dao.UserDao;

public class AuthService {

    private final UserDao userDao;

    public AuthService() {
        this.userDao = new UserDao();  // DAO pour interagir avec la table des utilisateurs
    }

    public User authenticate(String email, String motDePasse) {
        User user = userDao.findByEmail(email);  // Recherche de l'utilisateur par email

        if (user != null && user.getMotDePasse().equals(motDePasse)) {  // Comparaison des mots de passe
            return user;  // Si l'authentification réussit, retourner l'utilisateur
        }

        return null;  // Si l'authentification échoue, retourner null
    }



    public String getUserType(User user) {
        if (user instanceof Apprenant) {
            return "apprenant";
        } else if (user instanceof Formateur) {
            return "formateur";
        }
        return "unknown";  // Pour d'autres types d'utilisateurs si nécessaire
    }
}
