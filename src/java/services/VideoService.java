package services;

import dao.VideoDao;
import entities.Formation;
import entities.Video;

import java.util.List;

public class VideoService implements IService<Video> {

    private final VideoDao dao;

    public VideoService() {
        this.dao = new VideoDao();
    }

    @Override
    public boolean create(Video o) {
        return dao.create(o);
    }

    @Override
    public boolean delete(Video o) {
        return dao.delete(o);
    }

    @Override
    public boolean update(Video o) {
        return dao.update(o);
    }

    @Override
    public List<Video> findAll() {
        return dao.findAll();
    }

    @Override
    public Video findById(int id) {
        return dao.findById(id);
    }

    // ✅ Méthode personnalisée : pour trouver les vidéos liées à une formation
    public List<Video> findByFormation(Formation f) {
        return dao.findByFormation(f);
    }
}
