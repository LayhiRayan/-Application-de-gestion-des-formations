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
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private User user;

    public Inscription() {}

    public Inscription(Date dateInscription, Formation formation, User user) {
        this.dateInscription = dateInscription;
        this.formation = formation;
        this.user = user;
        this.id = new InscriptionPK(user.getId(), formation.getId());
    }

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
