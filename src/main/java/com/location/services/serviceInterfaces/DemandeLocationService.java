package com.location.services.serviceInterfaces;

import java.util.List;
import java.util.Optional;

import com.location.entities.DemandeLocation;

public interface DemandeLocationService {
    public DemandeLocation soumettre(DemandeLocation demande);
    public void accepter(Long id);
    public void refuser(Long id);
    public void annuler(Long id);
    public Optional<DemandeLocation> findById(Long id);
    public List<DemandeLocation> findByLocataireId(Long locataireId);
    public List<DemandeLocation> findByProprietaire(Long proprietaireId);
    public List<DemandeLocation> findEnAttente();

}
