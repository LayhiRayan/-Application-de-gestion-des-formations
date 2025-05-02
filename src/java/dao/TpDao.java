package dao;

import entities.Formation;
import entities.Tp;
import java.util.List;
import org.hibernate.Query; // Ancienne version (non générique)
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class TpDao extends AbstractDao<Tp> {

    public TpDao() {
        super(Tp.class);
    }

    public List<Tp> findByFormation(Formation formation) {
        List<Tp> result = null;
        Transaction tx = null;
        Session session = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            // Utilisation de la version sans typage
            Query query = session.createQuery("FROM Tp t WHERE t.formation = :formation");
            query.setParameter("formation", formation);
            result = query.list(); // cast automatique dans AbstractDao

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return result;
    }
}
