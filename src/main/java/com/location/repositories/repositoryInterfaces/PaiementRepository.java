package com.location.repositories.repositoryInterfaces;

import com.location.entities.Paiement;
import java.util.List;
import java.util.Map;

public interface PaiementRepository extends GenericRepository<Paiement, Long> {
    List<Paiement> findByContratId(Long contratId);
    List<Paiement> findByStatut(Paiement.StatutPaiement statut);
    List<Paiement> findByMoisConcerne(String moisConcerne);
    List<Paiement> findByProprietaireId(Long proprietaireId);
    List<Paiement> findByLocataire(Long locataireId);
    Map<String, Object> getStatsLocataire(Long locataireId);
    List<Paiement> findAllWithDetails();
    List<Paiement> findDerniersAvecDetails(int limit);
}
