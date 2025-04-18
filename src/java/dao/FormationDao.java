package dao;

import entities.Formation;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class FormationDao extends AbstractDao<Formation> {

    public FormationDao() {
        super(Formation.class);
    }

    // Méthode personnalisée pour rechercher une formation par titre
    public List<Formation> findByTitre(String titre) {
        Session session = null;
        Transaction tx = null;
        List<Formation> formations = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            formations = session
                .createQuery("from Formation where titre like :titre")
                .setParameter("titre", "%" + titre + "%")
                .list();

            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return formations;
    }
}
