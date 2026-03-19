package com.location.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Classe utilitaire pour le hachage et la vérification des mots de passe
 * Utilise BCrypt, un algorithme conçu spécifiquement pour les mots de passe
 */
public class PasswordUtil {

    /**
     * Hache un mot de passe avec BCrypt
     * 
     * @param plainPassword Le mot de passe en clair
     * @return Le mot de passe haché
     */
    public static String hash(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Le mot de passe ne peut pas être vide");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * Vérifie si un mot de passe en clair correspond à un mot de passe haché
     * 
     * @param plainPassword Le mot de passe en clair à vérifier
     * @param hashedPassword Le mot de passe haché stocké
     * @return true si les mots de passe correspondent, false sinon
     */
    public static boolean matches(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    /**
     * Vérifie si un mot de passe respecte les critères de complexité
     * 
     * @param password Le mot de passe à valider
     * @return true si le mot de passe est valide
     */
    public static boolean isValid(String password) {
        if (password == null) {
            return false;
        }
        // Critères : au moins 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre
        return password.length() >= 8
                && password.matches(".*[A-Z].*")
                && password.matches(".*[a-z].*")
                && password.matches(".*\\d.*");
    }
}
