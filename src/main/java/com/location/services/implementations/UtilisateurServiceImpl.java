package com.location.services.implementations;

import com.location.entities.Utilisateur;
import com.location.repositories.implementations.UtilisateurRepositoryImpl;
import com.location.repositories.repositoryInterfaces.UtilisateurRepository;
import com.location.services.serviceInterfaces.UtilisateurService;
import com.location.util.PasswordUtil;

import java.util.List;
import java.util.Optional;

public class UtilisateurServiceImpl implements UtilisateurService {

    private final UtilisateurRepository utilisateurRepo;

    public UtilisateurServiceImpl() {
        this.utilisateurRepo = new UtilisateurRepositoryImpl();
    }

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepo) {
        this.utilisateurRepo = utilisateurRepo;
    }

    @Override
    public Utilisateur inscrire(Utilisateur utilisateur) {
        if (utilisateurRepo.existsByEmail(utilisateur.getEmail())) {
            throw new IllegalArgumentException("Un compte existe déjà avec cet email : " + utilisateur.getEmail());
        }
        // Hachage du mot de passe avant persistance
        utilisateur.setMotDePasse(PasswordUtil.hash(utilisateur.getMotDePasse()));
        return utilisateurRepo.save(utilisateur);
    }

    @Override
    public Optional<Utilisateur> authentifier(String email, String motDePasse) {
        return utilisateurRepo.findByEmail(email)
                .filter(u -> u.isActif() && PasswordUtil.matches(motDePasse, u.getMotDePasse()));
    }

    @Override
    public Utilisateur modifier(Utilisateur utilisateur) {
        return utilisateurRepo.update(utilisateur);
    }

    @Override
    public void supprimer(Long id) {
        utilisateurRepo.delete(id);
    }

    @Override
    public Optional<Utilisateur> findById(Long id) {
        return utilisateurRepo.findById(id);
    }

    @Override
    public List<Utilisateur> findAll() {
        return utilisateurRepo.findAll();
    }

    @Override
    public List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role) {
        return utilisateurRepo.findByRole(role);
    }
}
