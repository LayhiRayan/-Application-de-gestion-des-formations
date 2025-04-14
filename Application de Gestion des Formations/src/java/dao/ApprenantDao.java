package dao;

import entities.Apprenant;
import entities.Formation;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class ApprenantDao extends AbstractDao<Apprenant> {

    public ApprenantDao() {
        super(Apprenant.class);
    }
public List<Apprenant> findByNom(String nom) {
    Session session = null;
    Transaction tx = null;
    List<Apprenant> etudiants = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        etudiants = session
            .getNamedQuery("Apprenant.findByNom")
            .setParameter("nom", "%" + nom + "%")
            .list();

        tx.commit();
    } catch (HibernateException e) {
        if (tx != null) {
            tx.rollback();
        }
    } finally {
        if (session != null) {
            session.close();
        }
    }

    return etudiants;
}
public List<Formation> findFormationsByApprenant(int apprenantId) {
    Session session = null;
    Transaction tx = null;
    List<Formation> formations = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        formations = session
            .getNamedQuery("Apprenant.findFormationsByApprenant")
            .setParameter("id", apprenantId)
            .list();

        tx.commit();
    } catch (HibernateException e) {
        if (tx != null) tx.rollback();
        e.printStackTrace();
    } finally {
        if (session != null) session.close();
    }

    return formations;
}



}


