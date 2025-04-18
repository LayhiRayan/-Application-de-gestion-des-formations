package dao;

import entities.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.HibernateException;
import util.HibernateUtil;

public class UserDao extends AbstractDao<User> {

    public UserDao() {
        super(User.class);
    }

    // ✅ Méthode spécifique pour rechercher un utilisateur par email
    public User findByEmail(String email) {
        Session session = null;
        Transaction tx = null;
        User user = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            user = (User) session.createQuery("from User where email = :email")
                    .setParameter("email", email)
                    .uniqueResult();

            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return user;
    }
}
