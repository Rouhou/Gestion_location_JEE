package com.location.entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "immeuble")
public class Immeuble {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 150)
    private String nom;

    @Column(nullable = false)
    private String adresse;

    @Column(nullable = false, length = 100)
    private String ville;

    @Column(name = "code_postal", length = 10)
    private String codePostal;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "nb_unites")
    private int nbUnites;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proprietaire_id", nullable = false)
    private Utilisateur proprietaire;

    @OneToMany(mappedBy = "immeuble", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UniteLocation> unites = new ArrayList<>();

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    public Immeuble() {}

    // Getters / Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }
    public String getCodePostal() { return codePostal; }
    public void setCodePostal(String codePostal) { this.codePostal = codePostal; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getNbUnites() { return nbUnites; }
    public void setNbUnites(int nbUnites) { this.nbUnites = nbUnites; }
    public Utilisateur getProprietaire() { return proprietaire; }
    public void setProprietaire(Utilisateur proprietaire) { this.proprietaire = proprietaire; }
    public List<UniteLocation> getUnites() { return unites; }
    public void setUnites(List<UniteLocation> unites) { this.unites = unites; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
}
