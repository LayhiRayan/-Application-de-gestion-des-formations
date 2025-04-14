package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "formations")
public class Formation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titre;
    private String description;
    private int duree;

    @OneToMany(mappedBy = "formation", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Inscription> inscriptions;
    @ManyToOne
@JoinColumn(name = "formateur_id")
private Formateur formateur;


    public Formation() {}

    public Formation(String titre, String description, int duree) {
        this.titre = titre;
        this.description = description;
        this.duree = duree;
    }

    // Getters & Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public List<Inscription> getInscriptions() {
        return inscriptions;
    }
    public Formateur getFormateur() {
    return formateur;
}

public void setFormateur(Formateur formateur) {
    this.formateur = formateur;
}


    public void setInscriptions(List<Inscription> inscriptions) {
        this.inscriptions = inscriptions;
    }


    
}
