package services;

import dao.TpDao;
import entities.Formation;
import entities.Tp;

import java.util.List;

public class TpService implements IService<Tp> {

    private final TpDao dao;

    public TpService() {
        this.dao = new TpDao();
    }

    @Override
    public boolean create(Tp o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Tp o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Tp o) {
        return dao.update(o);
    }

    @Override
    public List<Tp> findAll() {
        return dao.findAll();
    }

    @Override
    public Tp findById(int id) {
        return dao.findById(id);
    }
    public List<Tp> findByFormation(Formation f) {
    return dao.findByFormation(f);
}

}
