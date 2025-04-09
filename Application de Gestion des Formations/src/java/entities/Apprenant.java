package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "apprenants")
public class Apprenant extends User {

    @OneToMany(mappedBy = "apprenant", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Inscription> inscriptions;

    public Apprenant() {}

    public Apprenant(String nom, String email, String motDePasse) {
        super(nom, email, motDePasse); // Appel du constructeur de User
    }

    // Getters & Setters

    public List<Inscription> getInscriptions() {
        return inscriptions;
    }

    public void setInscriptions(List<Inscription> inscriptions) {
        this.inscriptions = inscriptions;
    }
}
