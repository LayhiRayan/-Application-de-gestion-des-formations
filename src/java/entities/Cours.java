package entities;

import javax.persistence.*;

@Entity
@Table(name = "cours")
public class Cours {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titre;

    private String contenu;

    private String lienVideo;  // ✅ Ajout du lien vidéo

    private String pdfPath;    // ✅ Ajout du chemin du fichier PDF

    @ManyToOne
    @JoinColumn(name = "formation_id")
    private Formation formation;

    // Constructeurs
    public Cours() {}

    public Cours(String titre, String contenu, Formation formation) {
        this.titre = titre;
        this.contenu = contenu;
        this.formation = formation;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getTitre() { return titre; }
    public String getContenu() { return contenu; }
    public Formation getFormation() { return formation; }
    public String getLienVideo() { return lienVideo; }
    public String getPdfPath() { return pdfPath; }

    public void setTitre(String titre) { this.titre = titre; }
    public void setContenu(String contenu) { this.contenu = contenu; }
    public void setFormation(Formation formation) { this.formation = formation; }
    public void setLienVideo(String lienVideo) { this.lienVideo = lienVideo; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }
}
