package com.location.repositories.repositoryInterfaces;

import java.util.List;
import java.util.Optional;

import com.location.entities.Utilisateur;

public interface UtilisateurRepository extends GenericRepository<Utilisateur, Long> {
    public Optional<Utilisateur> findByEmail(String email);
    public List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role);
    public boolean existsByEmail(String email);
}
