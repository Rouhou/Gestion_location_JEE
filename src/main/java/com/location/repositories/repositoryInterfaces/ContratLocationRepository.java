package com.location.repositories.repositoryInterfaces;

import com.location.entities.ContratLocation;

import java.util.List;

public interface ContratLocationRepository extends GenericRepository<ContratLocation, Long> {
    List<ContratLocation> findByLocataireId(Long locataireId);
    List<ContratLocation> findByUniteId(Long uniteId);
    List<ContratLocation> findActifs();
    List<ContratLocation> findByProprietaireId(Long proprietaireId);
    List<ContratLocation> findAllWithDetails();
    List<ContratLocation> findByLocataireWithPaiements(Long locataireId);
}
