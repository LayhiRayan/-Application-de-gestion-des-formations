package services;

import dao.ApprenantDao;
import entities.Apprenant;
import entities.Formation;
import java.util.List;

public class ApprenantService implements IService<Apprenant> {

    private final ApprenantDao dao;

    public ApprenantService() {
        this.dao = new ApprenantDao();
    }

    @Override
    public boolean create(Apprenant o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Apprenant o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Apprenant o) {
        return dao.update(o);
    }

    @Override
    public List<Apprenant> findAll() {
        return dao.findAll();
    }

    @Override
    public Apprenant findById(int id) {
        return dao.findById(id);
    }

    // Méthode spécifique à Apprenant
    public List<Apprenant> findByNom(String nom) {
        return dao.findByNom(nom); // Utilisation de la méthode spécifique du DAO
    }
    public List<Formation> findFormationsByApprenant(int apprenantId) {
    return dao.findFormationsByApprenant(apprenantId);
}

}
