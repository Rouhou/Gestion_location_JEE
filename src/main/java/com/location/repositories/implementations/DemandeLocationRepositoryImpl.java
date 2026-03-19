package com.location.repositories.implementations;

import com.location.entities.DemandeLocation;
import com.location.repositories.repositoryInterfaces.DemandeLocationRepository;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.util.List;

public class DemandeLocationRepositoryImpl
        extends AbstractRepository<DemandeLocation, Long>
        implements DemandeLocationRepository {

        @Override
    public List<DemandeLocation> findByLocataireId(Long locataireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT d FROM DemandeLocation d
                JOIN FETCH d.unite u
                JOIN FETCH u.immeuble i
                WHERE d.locataire.id = :lid
            """;

            return em.createQuery(jpql, DemandeLocation.class)
                    .setParameter("lid", locataireId)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<DemandeLocation> findByUniteId(Long uniteId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT d FROM DemandeLocation d WHERE d.unite.id = :uid",
                    DemandeLocation.class)
                    .setParameter("uid", uniteId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<DemandeLocation> findEnAttente() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT d FROM DemandeLocation d WHERE d.statut = 'EN_ATTENTE' ORDER BY d.dateDemande ASC",
                    DemandeLocation.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
