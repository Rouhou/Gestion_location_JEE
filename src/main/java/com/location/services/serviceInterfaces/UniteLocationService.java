package com.location.services.serviceInterfaces;

import com.location.entities.UniteLocation;
import java.util.List;
import java.util.Optional;

public interface UniteLocationService {
    UniteLocation ajouter(UniteLocation unite);
    UniteLocation modifier(UniteLocation unite);
    void supprimer(Long id);
    Optional<UniteLocation> findById(Long id);
    List<UniteLocation> findAll();
    List<UniteLocation> findDisponibles();
    List<UniteLocation> findByImmeuble(Long immeubleId);
    List<UniteLocation> findAllDisponibles();
    List<UniteLocation> findByImmeubleWithDetails(Long immeubleId);
}
