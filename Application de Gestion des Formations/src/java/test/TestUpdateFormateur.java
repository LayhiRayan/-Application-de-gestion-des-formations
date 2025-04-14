package test;

import dao.FormateurDao;
import entities.Formateur;

public class TestUpdateFormateur {
    public static void main(String[] args) {
        FormateurDao dao = new FormateurDao();

        int idToUpdate = 1; // ➤ adapte selon la BDD
        Formateur f = dao.findById(idToUpdate);

        if (f != null) {
            System.out.println("✏️ Ancienne spécialité : " + f.getSpecialite());
            f.setSpecialite("Cloud & DevOps"); // 💡 exemple de mise à jour
            dao.update(f);
            System.out.println("✅ Formateur mis à jour : " + f.getNom());
        } else {
            System.out.println("⚠ Formateur introuvable (id = " + idToUpdate + ")");
        }
    }
}
