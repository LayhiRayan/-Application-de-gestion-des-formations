package entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Objects;

@Embeddable // Indique que cette classe peut être utilisée comme une clé primaire composite
public class InscriptionPK implements Serializable {

    private int userId; // Identifiant de l'Apprenant
    private int formationId; // Identifiant de la Formation

    // Constructeur par défaut nécessaire pour JPA
    public InscriptionPK() {}

    // Constructeur avec paramètres pour initialiser la clé composite
    public InscriptionPK(int userId, int formationId) {
        this.userId = userId;
        this.formationId = formationId;
    }

    // Getters & Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFormationId() {
        return formationId;
    }

    public void setFormationId(int formationId) {
        this.formationId = formationId;
    }

    // Surcharge de equals pour comparer correctement les instances de la clé composite
    @Override
    public boolean equals(Object o) {
        if (this == o) return true; // Vérifie si c'est le même objet
        if (!(o instanceof InscriptionPK)) return false; // Vérifie que l'objet est de type InscriptionPK
        InscriptionPK that = (InscriptionPK) o;
        return userId == that.userId && formationId == that.formationId; // Compare les attributs
    }

    // Surcharge de hashCode pour garantir que les objets avec les mêmes clés ont le même hash
    @Override
    public int hashCode() {
        return Objects.hash(userId, formationId); // Génère un hash basé sur les deux attributs
    }
}
