package test;

import dao.ApprenantDao;
import entities.Apprenant;

import java.util.List;

public class TestFiltrageApprenant {
    public static void main(String[] args) {
        ApprenantDao dao = new ApprenantDao();

        String nomRecherche = "Ah"; // 🔍 nom partiel possible
        List<Apprenant> results = dao.findByNom(nomRecherche);

        if (!results.isEmpty()) {
            System.out.println("🔍 Apprenants avec '" + nomRecherche + "' :");
            for (Apprenant a : results) {
                System.out.println("✔ " + a.getNom() + " | " + a.getEmail());
            }
        } else {
            System.out.println("❌ Aucun apprenant trouvé avec '" + nomRecherche + "'");
        }
    }
}
