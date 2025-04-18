package services;

import dao.FormationDao;
import entities.Formation;
import java.util.List;

public class FormationService implements IService<Formation> {

    private final FormationDao dao;

    public FormationService() {
        this.dao = new FormationDao();
    }

    @Override
    public boolean create(Formation o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Formation o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Formation o) {
        return dao.update(o);
    }

    @Override
    public List<Formation> findAll() {
        return dao.findAll();
    }

    @Override
    public Formation findById(int id) {
        return dao.findById(id);
    }

    // Méthode spécifique à Formation
    public List<Formation> findByTitre(String titre) {
        return dao.findByTitre(titre); // Utilisation de la méthode spécifique du DAO
    }
}
