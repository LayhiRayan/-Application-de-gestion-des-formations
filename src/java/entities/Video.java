package entities;

import javax.persistence.*;

@Entity
@Table(name = "videos")
public class Video {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titre;

    private String url;

    @ManyToOne
    @JoinColumn(name = "formation_id")
    private Formation formation;

    public Video() {}

    public Video(String titre, String url, Formation formation) {
        this.titre = titre;
        this.url = url;
        this.formation = formation;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getTitre() { return titre; }
    public String getUrl() { return url; }
    public Formation getFormation() { return formation; }

    public void setTitre(String titre) { this.titre = titre; }
    public void setUrl(String url) { this.url = url; }
    public void setFormation(Formation formation) { this.formation = formation; }
}
