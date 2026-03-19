package com.location.services.implementations;

import com.location.entities.UniteLocation;
import com.location.repositories.repositoryInterfaces.UniteLocationRepository;
import com.location.repositories.implementations.UniteLocationRepositoryImpl;
import com.location.services.serviceInterfaces.UniteLocationService;

import java.util.List;
import java.util.Optional;

public class UniteLocationServiceImpl implements UniteLocationService {

    private final UniteLocationRepository uniteRepo;

    public UniteLocationServiceImpl() {
        this.uniteRepo = new UniteLocationRepositoryImpl();
    }

    // Constructeur pour les tests (injection de dépendance)
    public UniteLocationServiceImpl(UniteLocationRepository uniteRepo) {
        this.uniteRepo = uniteRepo;
    }

    @Override
    public UniteLocation ajouter(UniteLocation unite) {
        if (unite.getNumero() == null || unite.getNumero().isBlank()) {
            throw new IllegalArgumentException("Le numéro de l'unité est obligatoire.");
        }
        if (unite.getLoyerMensuel() == null || unite.getLoyerMensuel().signum() <= 0) {
            throw new IllegalArgumentException("Le loyer mensuel doit être un montant positif.");
        }
        if (unite.getSuperficie() == null || unite.getSuperficie().signum() <= 0) {
            throw new IllegalArgumentException("La superficie doit être positive.");
        }
        if (unite.getNbPieces() <= 0) {
            throw new IllegalArgumentException("Le nombre de pièces doit être supérieur à 0.");
        }
        if (unite.getImmeuble() == null || unite.getImmeuble().getId() == null) {
            throw new IllegalArgumentException("L'unité doit être rattachée à un immeuble.");
        }
        unite.setDisponible(true);
        return uniteRepo.save(unite);
    }

    @Override
    public UniteLocation modifier(UniteLocation unite) {
        if (unite.getId() == null) {
            throw new IllegalArgumentException("Impossible de modifier une unité sans identifiant.");
        }
        return uniteRepo.update(unite);
    }

    @Override
    public void supprimer(Long id) {
        uniteRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Unité introuvable avec l'id : " + id));
        uniteRepo.delete(id);
    }

    @Override
    public Optional<UniteLocation> findById(Long id) {
        return uniteRepo.findById(id);
    }

    @Override
    public List<UniteLocation> findAll() {
        return uniteRepo.findAll();
    }

    @Override
    public List<UniteLocation> findDisponibles() {
        return uniteRepo.findDisponibles();
    }

    @Override
    public List<UniteLocation> findByImmeuble(Long immeubleId) {
        return uniteRepo.findByImmeubleId(immeubleId);
    }

     @Override
    public List<UniteLocation> findAllDisponibles() {
        return uniteRepo.findAllDisponibles();
    }

    @Override
    public List<UniteLocation> findByImmeubleWithDetails(Long immeubleId){
        return uniteRepo.findByImmeubleWithDetails(immeubleId);
    }
}
