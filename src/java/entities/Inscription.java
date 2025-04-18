package entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "inscriptions")
public class Inscription {

    @EmbeddedId
    private InscriptionPK id;

    @Temporal(TemporalType.DATE)
    private Date dateInscription;

    @ManyToOne
    @MapsId("formationId")
    @JoinColumn(name = "formation_id")
    private Formation formation;

    @ManyToOne
    @MapsId("userId") // Utilisation de "userId" comme clé étrangère pour l'Apprenant
    @JoinColumn(name = "user_id")
    private Apprenant apprenant;

    public Inscription() {}

    public Inscription(Date dateInscription, Formation formation, Apprenant apprenant) {
        this.dateInscription = dateInscription;
        this.formation = formation;
        this.apprenant = apprenant;
        this.id = new InscriptionPK(apprenant.getId(), formation.getId());
    }

    // Getters & Setters

    public InscriptionPK getId() {
        return id;
    }

    public void setId(InscriptionPK id) {
        this.id = id;
    }

    public Date getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Date dateInscription) {
        this.dateInscription = dateInscription;
    }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }

    public Apprenant getApprenant() {
        return apprenant;
    }

    public void setApprenant(Apprenant apprenant) {
        this.apprenant = apprenant;
    }
}
