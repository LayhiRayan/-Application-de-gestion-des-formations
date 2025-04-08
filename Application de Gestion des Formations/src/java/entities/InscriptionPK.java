package entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Objects;

@Embeddable
public class InscriptionPK implements Serializable {

    private int userId;
    private int formationId;

    public InscriptionPK() {}

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof InscriptionPK)) return false;
        InscriptionPK that = (InscriptionPK) o;
        return userId == that.userId && formationId == that.formationId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, formationId);
    }
}
