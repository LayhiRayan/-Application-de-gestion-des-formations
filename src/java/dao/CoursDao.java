package dao;

import entities.Cours;
import entities.Formation;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class CoursDao extends AbstractDao<Cours> {

    public CoursDao() {
        super(Cours.class);
    }

    public List<Cours> findByFormation(Formation formation) {
        Session session = null;
        Transaction tx = null;
        List<Cours> result = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Query query = session.createQuery("FROM Cours c WHERE c.formation = :formation");
            query.setParameter("formation", formation);
            result = query.list();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return result;
    }

    public List<Cours> findByFormationId(int formationId) {
        Session session = null;
        Transaction tx = null;
        List<Cours> coursList = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Query query = session.createQuery("FROM Cours c WHERE c.formation.id = :formationId");
            query.setParameter("formationId", formationId);
            coursList = query.list();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return coursList;
    }
}
