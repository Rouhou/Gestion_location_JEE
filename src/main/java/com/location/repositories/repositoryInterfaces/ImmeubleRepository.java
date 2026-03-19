package com.location.repositories.repositoryInterfaces;

import com.location.entities.Immeuble;
import java.util.List;

public interface ImmeubleRepository extends GenericRepository<Immeuble, Long> {
    List<Immeuble> findByProprietaireId(Long proprietaireId);
    List<Immeuble> findByVille(String ville);
}
