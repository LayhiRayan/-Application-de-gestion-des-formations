package dao;

import entities.Inscription;
import entities.Apprenant;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class InscriptionDao extends AbstractDao<Inscription> {

    public InscriptionDao() {
        super(Inscription.class);
    }

    // Méthode personnalisée pour rechercher des inscriptions par Apprenant
    public List<Inscription> findByApprenant(Apprenant apprenant) {
        Session session = null;
        Transaction tx = null;
        List<Inscription> inscriptions = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            inscriptions = session
                .createQuery("from Inscription where apprenant = :apprenant")
                .setParameter("apprenant", apprenant)
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

        return inscriptions;
    }
}
