package com.location.repositories.implementations;

import com.location.entities.Immeuble;
import com.location.repositories.repositoryInterfaces.ImmeubleRepository;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.Optional;

public class ImmeubleRepositoryImpl
        extends AbstractRepository<Immeuble, Long>
        implements ImmeubleRepository {

    @Override
    public List<Immeuble> findByProprietaireId(Long proprietaireId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT i FROM Immeuble i WHERE i.proprietaire.id = :pid", Immeuble.class)
                    .setParameter("pid", proprietaireId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Immeuble> findByVille(String ville) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT i FROM Immeuble i WHERE LOWER(i.ville) = LOWER(:ville)", Immeuble.class)
                    .setParameter("ville", ville)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Immeuble> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT i FROM Immeuble i
                JOIN FETCH i.proprietaire
                LEFT JOIN FETCH i.unites
            """;

            return em.createQuery(jpql, Immeuble.class).getResultList();

        } finally {
            em.close();
        }
    }

        @Override
    public Optional<Immeuble> findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT i FROM Immeuble i
                JOIN FETCH i.proprietaire
                LEFT JOIN FETCH i.unites u
                WHERE i.id = :id
            """;

            Immeuble immeuble = em.createQuery(jpql, Immeuble.class)
                    .setParameter("id", id)
                    .getSingleResult();

            return Optional.ofNullable(immeuble);

        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }
}
