package com.location.entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "demande_location")
public class DemandeLocation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "TEXT")
    private String message;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StatutDemande statut = StatutDemande.EN_ATTENTE;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "locataire_id", nullable = false)
    private Utilisateur locataire;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "unite_id", nullable = false)
    private UniteLocation unite;

    @Column(name = "date_demande")
    private LocalDateTime dateDemande = LocalDateTime.now();

    public enum StatutDemande { EN_ATTENTE, ACCEPTEE, REFUSEE }

    public DemandeLocation() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public StatutDemande getStatut() { return statut; }
    public void setStatut(StatutDemande statut) { this.statut = statut; }
    public Utilisateur getLocataire() { return locataire; }
    public void setLocataire(Utilisateur locataire) { this.locataire = locataire; }
    public UniteLocation getUnite() { return unite; }
    public void setUnite(UniteLocation unite) { this.unite = unite; }
    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }

     public String getDateDemandeFormattee() {
        if (dateDemande == null) return "";
        return dateDemande.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    public String getHeureDemandeFormattee() {
        if (dateDemande == null) return "";
        return dateDemande.format(DateTimeFormatter.ofPattern("HH:mm"));
    }
}
