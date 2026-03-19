package com.location.repositories.implementations;

import com.location.entities.Utilisateur;
import com.location.repositories.repositoryInterfaces.UtilisateurRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;
import java.util.Optional;

public class UtilisateurRepositoryImpl
        extends AbstractRepository<Utilisateur, Long>
        implements UtilisateurRepository {

    @Override
    public Optional<Utilisateur> findByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            Utilisateur u = em.createQuery(
                    "SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(u);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT u FROM Utilisateur u WHERE u.role = :role", Utilisateur.class)
                    .setParameter("role", role)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(u) FROM Utilisateur u WHERE u.email = :email", Long.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}
