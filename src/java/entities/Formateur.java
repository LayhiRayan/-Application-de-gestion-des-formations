package entities;

import javax.persistence.*;
import java.util.List;

@NamedQuery(
    name = "Formateur.findFormations",
    query = "select f from Formation f where f.formateur.id = :formateurId order by f.duree desc"
)
@PrimaryKeyJoinColumn(name = "id")
@Entity
@Table(name = "formateurs")
public class Formateur extends User {

    private String specialite;

    @OneToMany(mappedBy = "formateur", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Formation> formations;

    public Formateur() {
        super.setRole("formateur"); // Définit le rôle par défaut
    }

    public Formateur(String nom, String email, String motDePasse, String specialite) {
        super(nom, email, motDePasse, "formateur"); // Appel du constructeur avec le rôle
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
