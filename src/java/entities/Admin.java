package entities;

import javax.persistence.*;

@Entity
@Table(name = "admins")
@PrimaryKeyJoinColumn(name = "id")
public class Admin extends User {

    public Admin() {
        super.setRole("admin"); // important pour initialiser le rôle
    }

    public Admin(String nom, String email, String motDePasse) {
        super(nom, email, motDePasse, "admin"); // utilise le constructeur avec 4 paramètres
    }

    
    
}
