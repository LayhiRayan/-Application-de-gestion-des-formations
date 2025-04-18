package services;

import dao.InscriptionDao;
import dao.ApprenantDao;
import entities.Inscription;
import entities.Apprenant;
import java.util.List;

public class InscriptionService implements IService<Inscription> {

    private final InscriptionDao dao;
    private final ApprenantDao apprenantDao;

    public InscriptionService() {
        this.dao = new InscriptionDao();
        this.apprenantDao = new ApprenantDao(); // Ajout du DAO Apprenant pour récupérer l'objet Apprenant
    }

    @Override
    public boolean create(Inscription o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Inscription o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Inscription o) {
        return dao.update(o);
    }

    @Override
    public List<Inscription> findAll() {
        return dao.findAll();
    }

    @Override
    public Inscription findById(int id) {
        return dao.findById(id);
    }

    // Méthode spécifique à Inscription : trouver les inscriptions pour un apprenant par son ID
    public List<Inscription> findByApprenant(int apprenantId) {
        Apprenant apprenant = apprenantDao.findById(apprenantId); // Récupère l'objet Apprenant par ID
        if (apprenant != null) {
            return dao.findByApprenant(apprenant); // Passe l'objet Apprenant à la méthode du DAO
        }
        return null; // Si l'apprenant n'existe pas, retourne null
    }
}
