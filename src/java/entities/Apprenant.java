package entities;

import javax.persistence.*;
import java.util.List;

@NamedQueries({
    @NamedQuery(
        name = "Apprenant.findByNom",
        query = "from Apprenant where nom like :nom"
    ),
    @NamedQuery(
        name = "Apprenant.findByEmail",
        query = "from Apprenant where email = :email"
    )
})
@NamedNativeQuery(
    name = "Apprenant.findFormationsByApprenant",
    query = "SELECT f.* FROM formations f INNER JOIN inscriptions i ON f.id = i.formation_id WHERE i.user_id = :id",
    resultClass = entities.Formation.class
)

@PrimaryKeyJoinColumn(name = "id")
@Entity
@Table(name = "apprenants")
public class Apprenant extends User {

    @OneToMany(mappedBy = "apprenant", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Inscription> inscriptions;

    public Apprenant() {
        super.setRole("apprenant"); // Définit le rôle par défaut
    }

    public Apprenant(String nom, String email, String motDePasse) {
        super(nom, email, motDePasse, "apprenant"); // Appel au constructeur User avec rôle
    }

    // Getters & Setters
    public List<Inscription> getInscriptions() {
        return inscriptions;
    }

    public void setInscriptions(List<Inscription> inscriptions) {
        this.inscriptions = inscriptions;
    }
}
