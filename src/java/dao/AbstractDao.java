package dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import java.util.List;

public abstract class AbstractDao<T> implements IDao<T> {
    private final Class<T> entityClass;

    public AbstractDao(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected interface HibernateOperation<T> {
        T execute(Session session);
    }

    protected <R> R executeTransaction(HibernateOperation<R> operation) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            R result = operation.execute(session);
            tx.commit();
            return result;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean create(T o) {
        return executeTransaction(new HibernateOperation<Boolean>() {
            @Override
            public Boolean execute(Session session) {
                session.save(o);
                return true;
            }
        });
    }

    @Override
    public boolean update(T o) {
        return executeTransaction(new HibernateOperation<Boolean>() {
            @Override
            public Boolean execute(Session session) {
                session.update(o);
                return true;
            }
        });
    }

    @Override
    public boolean delete(T o) {
        return executeTransaction(new HibernateOperation<Boolean>() {
            @Override
            public Boolean execute(Session session) {
                session.delete(o);
                return true;
            }
        });
    }

    @Override
    public List<T> findAll() {
        return executeTransaction(new HibernateOperation<List<T>>() {
            @Override
            public List<T> execute(Session session) {
                return session.createQuery("FROM " + entityClass.getSimpleName()).list();
            }
        });
    }

    @Override
    public T findById(int id) {
        return executeTransaction(new HibernateOperation<T>() {
            @Override
            public T execute(Session session) {
                return (T) session.get(entityClass, id);
            }
        });
    }
}