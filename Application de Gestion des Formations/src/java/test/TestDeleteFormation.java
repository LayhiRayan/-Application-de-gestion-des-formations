package test;

import dao.FormationDao;
import entities.Formation;

public class TestDeleteFormation {
    public static void main(String[] args) {
        FormationDao dao = new FormationDao();

        int idToDelete = 1; // ➤ adapte selon les données existantes
        Formation formation = dao.findById(idToDelete);

        if (formation != null) {
            dao.delete(formation);
            System.out.println("🗑 Formation supprimée : " + formation.getTitre());
        } else {
            System.out.println("⚠ Formation introuvable (id = " + idToDelete + ")");
        }
    }
}
