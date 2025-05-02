package dao;

import entities.Formation;
import entities.Video;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Query;
import util.HibernateUtil;

import java.util.List;

public class VideoDao extends AbstractDao<Video> {

    public VideoDao() {
        super(Video.class);
    }

   public List<Video> findByFormation(Formation formation) {
    List<Video> result = null;
    Transaction tx = null;
    Session session = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        tx = session.beginTransaction();

        Query query = session.createQuery("FROM Video v WHERE v.formation = :formation");
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

}
