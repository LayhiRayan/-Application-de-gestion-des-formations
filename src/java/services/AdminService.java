package services;

import dao.AdminDao;
import entities.Admin;

import java.util.List;

public class AdminService implements IService<Admin> {

    private final AdminDao dao;

    public AdminService() {
        this.dao = new AdminDao();
    }

    @Override
    public boolean create(Admin admin) {
        return dao.create(admin);
    }

    @Override
    public boolean delete(Admin admin) {
        return dao.delete(admin);
    }

    @Override
    public boolean update(Admin admin) {
        return dao.update(admin);
    }

    @Override
    public List<Admin> findAll() {
        return dao.findAll();
    }

    @Override
    public Admin findById(int id) {
        return dao.findById(id);
    }

    // Tu peux ajouter des méthodes spécifiques ici si besoin
    // Par exemple : affecter un formateur, inscrire un apprenant, etc.

}
