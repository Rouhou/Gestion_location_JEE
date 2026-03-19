package com.location.repositories.repositoryInterfaces;

import com.location.entities.UniteLocation;
import java.util.List;

public interface UniteLocationRepository extends GenericRepository<UniteLocation, Long> {
    List<UniteLocation> findByImmeubleId(Long immeubleId);
    List<UniteLocation> findDisponibles();
    List<UniteLocation> findByNbPiecesAndDisponible(int nbPieces);
    List<UniteLocation> findAllDisponibles();
    List<UniteLocation> findByImmeubleWithDetails(Long immeubleId);
}
