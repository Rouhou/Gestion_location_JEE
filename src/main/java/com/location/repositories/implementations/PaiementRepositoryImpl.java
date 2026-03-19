package com.location.repositories.implementations;

import com.location.entities.Paiement;
import com.location.repositories.repositoryInterfaces.PaiementRepository;
import com.location.util.JpaUtil;

import jakarta.persistence.EntityManager;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaiementRepositoryImpl
        extends AbstractRepository<Paiement, Long>
        implements PaiementRepository {

    @Override
    public List<Paiement> findByContratId(Long contratId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Paiement p WHERE p.contrat.id = :cid ORDER BY p.datePaiement DESC",
                    Paiement.class)
                    .setParameter("cid", contratId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findByStatut(Paiement.StatutPaiement statut) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Paiement p WHERE p.statut = :statut", Paiement.class)
                    .setParameter("statut", statut)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findByMoisConcerne(String moisConcerne) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Paiement p WHERE p.moisConcerne = :mois", Paiement.class)
                    .setParameter("mois", moisConcerne)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findByProprietaireId(Long proprietaireId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT p FROM Paiement p
                JOIN FETCH p.contrat c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble i
                WHERE i.proprietaire.id = :pid
            """;

            return em.createQuery(jpql, Paiement.class)
                    .setParameter("pid", proprietaireId)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findByLocataire(Long locataireId){
        EntityManager em = getEntityManager();
        try {
           String jpql = """
                SELECT p FROM Paiement p
                JOIN FETCH p.contrat c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble
                WHERE c.locataire.id = :lid
            """;
            return em.createQuery(jpql, Paiement.class)
                    .setParameter("lid", locataireId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Map<String, Object> getStatsLocataire(Long locataireId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = """
                SELECT 
                    COUNT(p), 
                    COALESCE(SUM(CASE WHEN p.statut = 'VALIDE' THEN p.montant ELSE 0 END), 0),
                    COALESCE(SUM(CASE WHEN p.statut = 'EN_ATTENTE' THEN 1 ELSE 0 END), 0),
                    COALESCE(SUM(CASE WHEN p.statut = 'REJETE' THEN 1 ELSE 0 END), 0)
                FROM Paiement p
                JOIN p.contrat c
                WHERE c.locataire.id = :lid
            """;

            Object[] result = (Object[]) em.createQuery(jpql)
                    .setParameter("lid", locataireId)
                    .getSingleResult();

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalPaiements", result[0] != null ? ((Long) result[0]).intValue() : 0);
            stats.put("montantValide", result[1] != null ? (BigDecimal) result[1] : BigDecimal.ZERO);
            stats.put("enAttente", result[2] != null ? ((Long) result[2]).intValue() : 0);
            stats.put("rejete", result[3] != null ? ((Long) result[3]).intValue() : 0);

            return stats;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findAllWithDetails() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = """
                SELECT p FROM Paiement p
                JOIN FETCH p.contrat c
                JOIN FETCH c.locataire
                JOIN FETCH c.unite u
                JOIN FETCH u.immeuble
            """;

            return em.createQuery(jpql, Paiement.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Paiement> findDerniersAvecDetails(int limit) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("""
                SELECT p FROM Paiement p
                JOIN FETCH p.contrat c
                JOIN FETCH c.locataire
                ORDER BY p.datePaiement DESC
            """, Paiement.class)
            .setMaxResults(limit)
            .getResultList();
        } finally {
            em.close();
        }
    }
}
