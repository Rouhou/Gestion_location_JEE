package com.location.repositories.implementations;

import com.location.entities.ContratLocation;
import com.location.repositories.repositoryInterfaces.ContratLocationRepository;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.Optional;

public class ContratLocationRepositoryImpl
        extends AbstractRepository<ContratLocation, Long>
        implements ContratLocationRepository {

    @Override
    public List<ContratLocation> findByLocataireId(Long locataireId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT c FROM ContratLocation c
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble
                WHERE c.locataire.id = :lid
            """;

            return em.createQuery(jpql, ContratLocation.class)
                    .setParameter("lid", locataireId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findByUniteId(Long uniteId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM ContratLocation c WHERE c.unite.id = :uid", ContratLocation.class)
                    .setParameter("uid", uniteId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findActifs() {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT c FROM ContratLocation c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble
                WHERE c.statut = 'ACTIF'
            """;
            return em.createQuery(jpql, ContratLocation.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findByProprietaireId(Long proprietaireId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT c FROM ContratLocation c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble i
                WHERE i.proprietaire.id = :pid
            """;
            return em.createQuery(jpql, ContratLocation.class)
                    .setParameter("pid", proprietaireId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
            SELECT c FROM ContratLocation c
            JOIN FETCH c.locataire
            JOIN FETCH c.unite u
            JOIN FETCH u.immeuble i
            JOIN FETCH i.proprietaire
             """;
            return em.createQuery(jpql, ContratLocation.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<ContratLocation> findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT c FROM ContratLocation c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble i
                JOIN FETCH i.proprietaire
                LEFT JOIN FETCH c.paiements
                WHERE c.id = :id
            """;

            ContratLocation contrat = em.createQuery(jpql, ContratLocation.class)
                    .setParameter("id", id)
                    .getSingleResult();

            return Optional.ofNullable(contrat);

        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findAllWithDetails() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT c FROM ContratLocation c
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble i
                JOIN FETCH i.proprietaire
                JOIN FETCH c.locataire
            """;

            return em.createQuery(jpql, ContratLocation.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ContratLocation> findByLocataireWithPaiements(Long locataireId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT c FROM ContratLocation c
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble
                LEFT JOIN FETCH c.paiements
                WHERE c.locataire.id = :lid
            """;
            return em.createQuery(jpql, ContratLocation.class)
                    .setParameter("lid", locataireId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
