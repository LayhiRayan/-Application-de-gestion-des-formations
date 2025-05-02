package services;

import dao.InscriptionDao;
import dao.ApprenantDao;
import entities.Inscription;
import entities.Apprenant;
import entities.Formation;
import java.util.ArrayList;
import org.hibernate.Session;
import org.hibernate.Query; // ⚡ Important pour Hibernate 4 et NetBeans 8
import util.HibernateUtil;

import java.util.List;
import org.hibernate.Transaction;

public class InscriptionService implements IService<Inscription> {
    private final FormationService formationService = new FormationService();

    private final InscriptionDao dao;
    private final ApprenantDao apprenantDao;

    public InscriptionService() {
        this.dao = new InscriptionDao();
        this.apprenantDao = new ApprenantDao();
    }

    @Override
    public boolean create(Inscription inscription) {
        return dao.create(inscription);
    }

    @Override
    public boolean delete(Inscription inscription) {
        return dao.delete(inscription);
    }

    @Override
    public boolean update(Inscription inscription) {
        return dao.update(inscription);
    }

    @Override
    public List<Inscription> findAll() {
        return dao.findAll();
    }

    @Override
    public Inscription findById(int id) {
        return dao.findById(id);
    }
    public int countByFormation(int formationId) {
    return dao.countByFormation(formationId);
}


    /**
     * Retourne toutes les inscriptions liées à un apprenant donné par son ID
     */
    public List<Inscription> findByApprenant(int apprenantId) {
        Apprenant apprenant = apprenantDao.findById(apprenantId);
        return (apprenant != null) ? dao.findByApprenant(apprenant) : null;
    }

    /**
     * Vérifie si un apprenant est déjà inscrit à une formation (compatible Hibernate 4 / NetBeans 8)
     */
    public boolean isApprenantInscrit(int apprenantId, int formationId) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            String hql = "SELECT COUNT(i) FROM Inscription i WHERE i.apprenant.id = :apprenantId AND i.formation.id = :formationId";
            Query query = session.createQuery(hql);
            query.setParameter("apprenantId", apprenantId);
            query.setParameter("formationId", formationId);
            Long count = (Long) query.uniqueResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return false;
    }
    public List<Apprenant> findApprenantsByFormation(int formationId) {
    List<Apprenant> apprenants = new ArrayList<>();
    Session session = null;
    Transaction tx = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        String hql = "SELECT i.apprenant FROM Inscription i WHERE i.formation.id = :formationId";
        Query query = session.createQuery(hql);
        query.setParameter("formationId", formationId);
        apprenants = query.list();

        tx.commit();
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }
    return apprenants;
}
    public List<Inscription> findByFormation(int formationId) {
    Formation formation = formationService.findById(formationId);
    return (formation != null) ? dao.findByFormation(formation) : new ArrayList<>();
}




}
