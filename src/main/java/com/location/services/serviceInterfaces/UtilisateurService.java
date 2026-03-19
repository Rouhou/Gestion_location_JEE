package com.location.services.serviceInterfaces;

import com.location.entities.Utilisateur;
import java.util.List;
import java.util.Optional;

public interface UtilisateurService {
    Utilisateur inscrire(Utilisateur utilisateur);
    Optional<Utilisateur> authentifier(String email, String motDePasse);
    Utilisateur modifier(Utilisateur utilisateur);
    void supprimer(Long id);
    Optional<Utilisateur> findById(Long id);
    List<Utilisateur> findAll();
    List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role);
}
