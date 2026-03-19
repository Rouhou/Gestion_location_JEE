package com.location.services.implementations;

import com.location.entities.Immeuble;
import com.location.repositories.implementations.ImmeubleRepositoryImpl;
import com.location.repositories.repositoryInterfaces.ImmeubleRepository;
import com.location.services.serviceInterfaces.ImmeubleService;

import java.util.List;
import java.util.Optional;

public class ImmeubleServiceImpl implements ImmeubleService {

    private final ImmeubleRepository immeubleRepo;

    public ImmeubleServiceImpl() {
        this.immeubleRepo = new ImmeubleRepositoryImpl();
    }

    public ImmeubleServiceImpl(ImmeubleRepository immeubleRepo) {
        this.immeubleRepo = immeubleRepo;
    }

    @Override
    public Immeuble ajouter(Immeuble immeuble) {
        if (immeuble.getNom() == null || immeuble.getNom().isBlank()) {
            throw new IllegalArgumentException("Le nom de l'immeuble est obligatoire.");
        }
        return immeubleRepo.save(immeuble);
    }

    @Override
    public Immeuble modifier(Immeuble immeuble) {
        return immeubleRepo.update(immeuble);
    }

    @Override
    public void supprimer(Long id) {
        immeubleRepo.delete(id);
    }

    @Override
    public Optional<Immeuble> findById(Long id) {
        return immeubleRepo.findById(id);
    }

    @Override
    public List<Immeuble> findAll() {
        return immeubleRepo.findAll();
    }

    @Override
    public List<Immeuble> findByProprietaire(Long proprietaireId) {
        return immeubleRepo.findByProprietaireId(proprietaireId);
    }
}
