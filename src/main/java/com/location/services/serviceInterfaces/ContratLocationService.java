package com.location.services.serviceInterfaces;

import com.location.entities.ContratLocation;
import java.util.List;
import java.util.Optional;

public interface ContratLocationService {
    ContratLocation creerContrat(ContratLocation contrat);
    ContratLocation modifier(ContratLocation contrat);
    void resilier(Long id);
    Optional<ContratLocation> findById(Long id);
    List<ContratLocation> findByLocataire(Long locataireId);
    List<ContratLocation> findByProprietaire(Long proprietaireId);
    List<ContratLocation> findActifs();
    List<ContratLocation> findAll();
    List<ContratLocation> findAllWithDetails();
    List<ContratLocation> findByLocataireWithPaiements(Long locataireId);
}
