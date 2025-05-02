package services;

import dao.CoursDao;
import entities.Cours;
import entities.Formation;

import java.util.List;

public class CoursService implements IService<Cours> {

    private final CoursDao dao;

    public CoursService() {
        this.dao = new CoursDao();
    }

    @Override
    public boolean create(Cours o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Cours o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Cours o) {
        return dao.update(o);
    }

    @Override
    public List<Cours> findAll() {
        return dao.findAll();
    }

    @Override
    public Cours findById(int id) {
        return dao.findById(id);
    }

    public List<Cours> findByFormation(Formation formation) {
        return dao.findByFormation(formation);
    }

    public List<Cours> findByFormationId(int idFormation) {
        return dao.findByFormationId(idFormation);
    }
}
