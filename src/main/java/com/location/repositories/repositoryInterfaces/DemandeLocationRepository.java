package com.location.repositories.repositoryInterfaces;

import com.location.entities.DemandeLocation;
import java.util.List;

public interface DemandeLocationRepository extends GenericRepository<DemandeLocation, Long> {
    List<DemandeLocation> findByLocataireId(Long locataireId);
    List<DemandeLocation> findByUniteId(Long uniteId);
    List<DemandeLocation> findEnAttente();
}
