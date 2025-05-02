package entities;

import javax.persistence.*;

@Entity
@Table(name = "tps")
public class Tp {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String sujet;

    @ManyToOne
    @JoinColumn(name = "formation_id")
    private Formation formation;

    // ✅ Constructeur par défaut
    public Tp() {}

    // ✅ Constructeur avec paramètres
    public Tp(String sujet, Formation formation) {
        this.sujet = sujet;
        this.formation = formation;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public String getSujet() {
        return sujet;
    }

    public void setSujet(String sujet) {
        this.sujet = sujet;
    }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }
}
