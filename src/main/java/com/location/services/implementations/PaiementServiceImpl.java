package com.location.services.implementations;

import com.location.entities.Immeuble;
import com.location.entities.Paiement;
import com.location.repositories.implementations.PaiementRepositoryImpl;
import com.location.repositories.repositoryInterfaces.PaiementRepository;
import com.location.services.serviceInterfaces.PaiementService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public class PaiementServiceImpl implements PaiementService {

    private final PaiementRepository paiementRepo;

    public PaiementServiceImpl() {
        this.paiementRepo = new PaiementRepositoryImpl();
    }

    @Override
    public Paiement enregistrer(Paiement paiement) {
        if (paiement.getMontant() == null || paiement.getMontant().signum() <= 0) {
            throw new IllegalArgumentException("Le montant doit être positif.");
        }
        return paiementRepo.save(paiement);
    }

    @Override
    public Paiement valider(Long paiementId) {
        Paiement p = paiementRepo.findById(paiementId)
                .orElseThrow(() -> new IllegalArgumentException("Paiement introuvable."));
        p.setStatut(Paiement.StatutPaiement.VALIDE);
        return paiementRepo.update(p);
    }

    @Override
    public Paiement rejeter(Long paiementId) {
        Paiement p = paiementRepo.findById(paiementId)
                .orElseThrow(() -> new IllegalArgumentException("Paiement introuvable."));
        p.setStatut(Paiement.StatutPaiement.REJETE);
        return paiementRepo.update(p);
    }

    @Override
    public Optional<Paiement> findById(Long id) {
        return paiementRepo.findById(id);
    }

    @Override
    public List<Paiement> findByContrat(Long contratId) {
        return paiementRepo.findByContratId(contratId);
    }

    @Override
    public List<Paiement> findEnAttente() {
        return paiementRepo.findByStatut(Paiement.StatutPaiement.EN_ATTENTE);
    }

    @Override
    public List<Paiement> findByProprietaire(Long proprietaireId) {
        return paiementRepo.findByProprietaireId(proprietaireId);
    }

        @Override
    public List<Paiement> findAll() {
        return paiementRepo.findAll();
    }

    @Override
    public List<Paiement> findByLocataire(Long locataireId){
        return paiementRepo.findByLocataire(locataireId);
    }

    @Override
    public Map<String, Object> getStatsLocataire(Long locataireId){
        return paiementRepo.getStatsLocataire(locataireId);
    }

    @Override
    public List<Paiement> findAllWithDetails(){
        return paiementRepo.findAllWithDetails();
    }

    @Override
    public List<Paiement> findDerniersAvecDetails(int limit){
        return paiementRepo.findDerniersAvecDetails(limit);
    }
}
