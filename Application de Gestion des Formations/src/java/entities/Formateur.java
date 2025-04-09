package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "formateurs")
public class Formateur extends User {

    private String specialite;

    @OneToMany(mappedBy = "formateur", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Formation> formations;

    public Formateur() {}

    public Formateur(String nom, String email, String motDePasse, String specialite) {
        super(nom, email, motDePasse); // Appel au constructeur de User
        this.specialite = specialite;
    }

    // Getters & Setters

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
