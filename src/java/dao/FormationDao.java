package dao;

import entities.Formation;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class FormationDao extends AbstractDao<Formation> {

    public FormationDao() {
        super(Formation.class);
    }

    // 🔍 Rechercher par titre (approximation)
    public List<Formation> findByTitre(String titre) {
        Session session = null;
        Transaction tx = null;
        List<Formation> formations = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Query query = session.createQuery("from Formation where titre like :titre");
            query.setParameter("titre", "%" + titre + "%");

            formations = query.list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return formations;
    }

    // 🔍 Recherche par mot-clé (titre ou description)
    public List<Formation> findByKeyword(String keyword) {
        Session session = null;
        Transaction tx = null;
        List<Formation> result = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Query query = session.createQuery(
                "FROM Formation f WHERE lower(f.titre) LIKE :kw OR lower(f.description) LIKE :kw"
            );
            query.setParameter("kw", "%" + keyword.toLowerCase() + "%");

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
    public List<Formation> findByFormateur(int formateurId) {
    Session session = null;
    Transaction tx = null;
    List<Formation> formations = null;
    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();
        Query query = session.createQuery("FROM Formation f WHERE f.formateur.id = :formateurId");
        query.setParameter("formateurId", formateurId);
        formations = query.list();
        tx.commit();
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }
    return formations;
}


    // 📌 Formations non inscrites par un apprenant
    public List<Formation> findFormationsNonInscrites(int apprenantId) {
    Session session = null;
    Transaction tx = null;
    List<Formation> formations = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        Query query = session.createQuery(
            "FROM Formation f WHERE f.id NOT IN " +
            "(SELECT i.formation.id FROM Inscription i WHERE i.apprenant.id = :apprenantId)"
        );
        query.setInteger("apprenantId", apprenantId); // ⚠️ Hibernate 4 = setInteger()

        formations = query.list();
        tx.commit();
    } catch (Exception e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }

    return formations;
}

}
