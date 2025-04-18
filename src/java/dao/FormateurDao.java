package dao;

import entities.Formateur;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class FormateurDao extends AbstractDao<Formateur> {

    public FormateurDao() {
        super(Formateur.class);
    }

    // Méthode personnalisée pour rechercher un formateur par spécialité
    public List<Formateur> findBySpecialite(String specialite) {
        Session session = null;
        Transaction tx = null;
        List<Formateur> formateurs = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            formateurs = session
                .createQuery("from Formateur where specialite like :specialite")
                .setParameter("specialite", "%" + specialite + "%")
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

        return formateurs;
    }
}
