package com.location.services.implementations;

import com.location.entities.ContratLocation;
import com.location.entities.Immeuble;
import com.location.entities.UniteLocation;
import com.location.repositories.implementations.ContratLocationRepositoryImpl;
import com.location.repositories.implementations.UniteLocationRepositoryImpl;
import com.location.repositories.repositoryInterfaces.ContratLocationRepository;
import com.location.repositories.repositoryInterfaces.UniteLocationRepository;
import com.location.services.serviceInterfaces.ContratLocationService;

import java.util.List;
import java.util.Optional;

public class ContratLocationServiceImpl implements ContratLocationService {

    private final ContratLocationRepository contratRepo;
    private final UniteLocationRepository uniteRepo;

    public ContratLocationServiceImpl() {
        this.contratRepo = new ContratLocationRepositoryImpl();
        this.uniteRepo  = new UniteLocationRepositoryImpl();
    }

    @Override
    public ContratLocation creerContrat(ContratLocation contrat) {
        // Vérifier que l'unité est disponible
        UniteLocation unite = uniteRepo.findById(contrat.getUnite().getId())
                .orElseThrow(() -> new IllegalArgumentException("Unité introuvable."));
        if (!unite.isDisponible()) {
            throw new IllegalStateException("L'unité " + unite.getNumero() + " n'est plus disponible.");
        }
        // Rendre l'unité indisponible
        unite.setDisponible(false);
        uniteRepo.update(unite);
        return contratRepo.save(contrat);
    }

    @Override
    public ContratLocation modifier(ContratLocation contrat) {
        return contratRepo.update(contrat);
    }

    @Override
    public void resilier(Long id) {
        ContratLocation contrat = contratRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Contrat introuvable."));
        contrat.setStatut(ContratLocation.StatutContrat.RESILIE);
        contratRepo.update(contrat);
        // Remettre l'unité disponible
        UniteLocation unite = contrat.getUnite();
        unite.setDisponible(true);
        uniteRepo.update(unite);
    }

    @Override
    public Optional<ContratLocation> findById(Long id) {
        return contratRepo.findById(id);
    }

    @Override
    public List<ContratLocation> findByLocataire(Long locataireId) {
        return contratRepo.findByLocataireId(locataireId);
    }

    @Override
    public List<ContratLocation> findActifs() {
        return contratRepo.findActifs();
    }

        @Override
    public List<ContratLocation> findByProprietaire(Long proprietaireId) {
        return contratRepo.findByProprietaireId(proprietaireId);
    }

        @Override
    public List<ContratLocation> findAll() {
        return contratRepo.findAll();
    }

    @Override
    public List<ContratLocation> findAllWithDetails(){
        return contratRepo.findAllWithDetails();
    }

    @Override
    public List<ContratLocation> findByLocataireWithPaiements(Long locataireId){
        return contratRepo.findByLocataireWithPaiements(locataireId);
    }
}
