package com.location.repositories.implementations;

import com.location.entities.UniteLocation;
import com.location.repositories.repositoryInterfaces.UniteLocationRepository;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.util.List;

public class UniteLocationRepositoryImpl
        extends AbstractRepository<UniteLocation, Long>
        implements UniteLocationRepository {

    @Override
    public List<UniteLocation> findByImmeubleId(Long immeubleId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u FROM UniteLocation u WHERE u.immeuble.id = :iid", UniteLocation.class)
                    .setParameter("iid", immeubleId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<UniteLocation> findDisponibles() {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT u FROM UniteLocation u
                JOIN FETCH u.immeuble
                WHERE u.disponible = true
            """;

            return em.createQuery(jpql, UniteLocation.class).getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<UniteLocation> findByNbPiecesAndDisponible(int nbPieces) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u FROM UniteLocation u WHERE u.nbPieces = :nb AND u.disponible = true",
                    UniteLocation.class)
                    .setParameter("nb", nbPieces)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<UniteLocation> findAllDisponibles() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT u FROM UniteLocation u
                JOIN FETCH u.immeuble i
                JOIN FETCH i.proprietaire
                WHERE u.disponible = true
            """;

            return em.createQuery(jpql, UniteLocation.class).getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<UniteLocation> findByImmeubleWithDetails(Long immeubleId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("""
                SELECT u FROM UniteLocation u
                JOIN FETCH u.immeuble
                WHERE u.immeuble.id = :id
            """, UniteLocation.class)
            .setParameter("id", immeubleId)
            .getResultList();
        } finally {
            em.close();
        }
    }
}
