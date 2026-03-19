package com.location.services.serviceInterfaces;

import com.location.entities.Paiement;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface PaiementService {
    Paiement enregistrer(Paiement paiement);
    Paiement valider(Long paiementId);
    Paiement rejeter(Long paiementId);
    Optional<Paiement> findById(Long id);
    List<Paiement> findByContrat(Long contratId);
    List<Paiement> findByProprietaire(Long proprietaireId);
    List<Paiement> findEnAttente();
    List<Paiement> findAll();
    List<Paiement> findByLocataire(Long locataireId); 
    Map<String, Object> getStatsLocataire(Long locataireId);
    List<Paiement> findAllWithDetails();
    List<Paiement> findDerniersAvecDetails(int limit);
}
