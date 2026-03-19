package com.location.services.serviceInterfaces;

import com.location.entities.Immeuble;
import java.util.List;
import java.util.Optional;

public interface ImmeubleService {
    Immeuble ajouter(Immeuble immeuble);
    Immeuble modifier(Immeuble immeuble);
    void supprimer(Long id);
    Optional<Immeuble> findById(Long id);
    List<Immeuble> findAll();
    List<Immeuble> findByProprietaire(Long proprietaireId);
}
