package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "formateurs")
public class Formateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nom;
    private String specialite;

    @OneToMany(mappedBy = "formateur", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Formation> formations;

    public Formateur() {}

    public Formateur(String nom, String specialite) {
        this.nom = nom;
        this.specialite = specialite;
    }

    // Getters & Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public List<Formation> getFormations() {
        return formations;
    }

    public void setFormations(List<Formation> formations) {
        this.formations = formations;
    }
}
