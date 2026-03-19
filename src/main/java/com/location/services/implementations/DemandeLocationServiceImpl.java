package com.location.services.implementations;

import com.location.entities.DemandeLocation;
import com.location.entities.UniteLocation;
import com.location.repositories.repositoryInterfaces.DemandeLocationRepository;
import com.location.repositories.repositoryInterfaces.UniteLocationRepository;
import com.location.repositories.implementations.DemandeLocationRepositoryImpl;
import com.location.repositories.implementations.UniteLocationRepositoryImpl;
import com.location.services.serviceInterfaces.DemandeLocationService;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class DemandeLocationServiceImpl implements DemandeLocationService {

    private final DemandeLocationRepository demandeRepo;
    private final UniteLocationRepository   uniteRepo;

    public DemandeLocationServiceImpl() {
        this.demandeRepo = new DemandeLocationRepositoryImpl();
        this.uniteRepo   = new UniteLocationRepositoryImpl();
    }

    public DemandeLocationServiceImpl(DemandeLocationRepository demandeRepo,
                                      UniteLocationRepository uniteRepo) {
        this.demandeRepo = demandeRepo;
        this.uniteRepo   = uniteRepo;
    }

    @Override
    public DemandeLocation soumettre(DemandeLocation demande) {
        if (demande.getUnite() == null || demande.getUnite().getId() == null) {
            throw new IllegalArgumentException("L'unité est obligatoire.");
        }
        if (demande.getLocataire() == null || demande.getLocataire().getId() == null) {
            throw new IllegalArgumentException("Le locataire est obligatoire.");
        }
        UniteLocation unite = uniteRepo.findById(demande.getUnite().getId())
                .orElseThrow(() -> new IllegalArgumentException("Unité introuvable."));
        if (!unite.isDisponible()) {
            throw new IllegalStateException("Cette unité n'est plus disponible.");
        }
        demande.setStatut(DemandeLocation.StatutDemande.EN_ATTENTE);
        return demandeRepo.save(demande);
    }

    @Override
    public void accepter(Long id) {
        DemandeLocation demande = demandeRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Demande introuvable : " + id));
        if (demande.getStatut() != DemandeLocation.StatutDemande.EN_ATTENTE) {
            throw new IllegalStateException("Seules les demandes en attente peuvent être acceptées.");
        }
        demande.setStatut(DemandeLocation.StatutDemande.ACCEPTEE);
        demandeRepo.update(demande);

        // Marquer l'unité comme non disponible
        UniteLocation unite = demande.getUnite();
        unite.setDisponible(false);
        uniteRepo.update(unite);

        // Refuser automatiquement les autres demandes en attente sur la même unité
        demandeRepo.findByUniteId(unite.getId()).stream()
                .filter(d -> d.getStatut() == DemandeLocation.StatutDemande.EN_ATTENTE
                          && !d.getId().equals(id))
                .forEach(d -> {
                    d.setStatut(DemandeLocation.StatutDemande.REFUSEE);
                    demandeRepo.update(d);
                });
    }

    @Override
    public void refuser(Long id) {
        DemandeLocation demande = demandeRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Demande introuvable : " + id));
        if (demande.getStatut() != DemandeLocation.StatutDemande.EN_ATTENTE) {
            throw new IllegalStateException("Seules les demandes en attente peuvent être refusées.");
        }
        demande.setStatut(DemandeLocation.StatutDemande.REFUSEE);
        demandeRepo.update(demande);
    }

    @Override
    public void annuler(Long id) {
        DemandeLocation demande = demandeRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Demande introuvable : " + id));
        if (demande.getStatut() != DemandeLocation.StatutDemande.EN_ATTENTE) {
            throw new IllegalStateException("Seules les demandes en attente peuvent être annulées.");
        }
        demandeRepo.delete(id);
    }

    @Override
    public Optional<DemandeLocation> findById(Long id) {
        return demandeRepo.findById(id);
    }

    @Override
    public List<DemandeLocation> findByLocataireId(Long locataireId) {
        return demandeRepo.findByLocataireId(locataireId);
    }

    // @Override
    // public List<DemandeLocation> findByProprietaire(Long proprietaireId) {
    //     // Filtrer les demandes dont l'unité appartient à un immeuble du propriétaire
    //     return demandeRepo.findAll().stream()
    //             .filter(d -> {
    //                 UniteLocation u = d.getUnite();
    //                 return u != null
    //                     && u.getImmeuble() != null
    //                     && u.getImmeuble().getProprietaire() != null
    //                     && u.getImmeuble().getProprietaire().getId().equals(proprietaireId);
    //             })
    //             .collect(Collectors.toList());
    // }

    @Override
    public List<DemandeLocation> findByProprietaire(Long proprietaireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT d FROM DemandeLocation d
                JOIN FETCH d.locataire
                JOIN FETCH d.unite u
                JOIN FETCH u.immeuble i
                JOIN FETCH i.proprietaire p
                WHERE p.id = :pid
            """;


            return em.createQuery(jpql, DemandeLocation.class)
                    .setParameter("pid", proprietaireId)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<DemandeLocation> findEnAttente() {
        return demandeRepo.findEnAttente();
    }
}
