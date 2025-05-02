package dao;

import entities.Inscription;
import entities.Apprenant;
import entities.Formation;
import java.util.ArrayList;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

import java.util.List;

public class InscriptionDao extends AbstractDao<Inscription> {

    public InscriptionDao() {
        super(Inscription.class);
    }

    /**
     * Trouve toutes les inscriptions d'un apprenant donné.
     */
    public List<Inscription> findByApprenant(Apprenant apprenant) {
        Session session = null;
        Transaction tx = null;
        List<Inscription> inscriptions = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Query query = session.createQuery("FROM Inscription i WHERE i.apprenant = :apprenant");
            query.setParameter("apprenant", apprenant);
            inscriptions = query.list();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return inscriptions;
    }
    public int countByFormation(int formationId) {
    Session session = null;
    Transaction tx = null;
    int count = 0;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        
        Query query = session.createQuery(
            "SELECT COUNT(i) FROM Inscription i WHERE i.formation.id = :formationId"
        );
        query.setParameter("formationId", formationId);

        Long result = (Long) query.uniqueResult();
        if (result != null) {
            count = result.intValue();
        }

        tx.commit();
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }

    return count;
}
    public List<Inscription> findByFormation(Formation formation) {
    Session session = HibernateUtil.getSessionFactory().openSession();
    Transaction tx = null;
    List<Inscription> inscriptions = null;

    try {
        tx = session.beginTransaction();
        inscriptions = session.createQuery("FROM Inscription i WHERE i.formation = :formation")
                              .setParameter("formation", formation)
                              .list();
        tx.commit();
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        session.close();
    }

    return inscriptions;
}


}
