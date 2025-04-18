package services;

import dao.FormateurDao;
import entities.Formateur;
import java.util.List;

public class FormateurService implements IService<Formateur> {

    private final FormateurDao dao;

    public FormateurService() {
        this.dao = new FormateurDao();
    }

    @Override
    public boolean create(Formateur o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Formateur o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Formateur o) {
        return dao.update(o);
    }

    @Override
    public List<Formateur> findAll() {
        return dao.findAll();
    }

    @Override
    public Formateur findById(int id) {
        return dao.findById(id);
    }

    // Méthode spécifique à Formateur
    public List<Formateur> findBySpecialite(String specialite) {
        return dao.findBySpecialite(specialite); // Utilisation de la méthode spécifique du DAO
    }
}
