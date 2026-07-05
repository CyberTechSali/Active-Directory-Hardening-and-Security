<p align="center">
  <img src="https://img.shields.io/badge/Projet-Audit%20AD-blue?style=for-the-badge&logo=microsoft" />
  <img src="https://img.shields.io/badge/Statut-Terminé-brightgreen?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Outils-PingCastle%20%7C%20Mimikatz-orange?style=for-the-badge&logo=security" />
  <img src="https://img.shields.io/badge/Niveau-Critique-red?style=for-the-badge" />
</p>

# Audit de sécurité Active Directory – cybertechsali.com

**Période** : Novembre – Décembre 2025  
**Auteur** : OUCHAHEd SALMA

---

## Contexte

Ce projet est un audit de sécurité complet de l'Active Directory `cybertechsali.com`. L'objectif était d'identifier les vulnérabilités critiques, de démontrer leur impact par l'exploitation, et de proposer un plan de durcissement validé techniquement.

---

## Outils utilisés

| Outil | Version | Usage |
| :--- | :--- | :--- |
| **PingCastle** | 3.2.1 | Analyse des risques et scoring global |
| **Purple Knight** | Community | Détection des indicateurs d'exposition (IOEs) |
| **BloodHound** | 8.3.1 | Cartographie des chemins d'attaque et actifs Tier 0 |
| **Mimikatz** | 2.2.0 | Extraction des secrets (DCSync, Pass-the-Hash, Pass-the-Ticket) |

---

## Résultats clés

| Métrique | Résultat |
| :--- | :--- |
| **Score PingCastle** | 55/100 (Risque élevé) |
| **Indicateurs d'exposition (Purple Knight)** | 17 IOEs |
| **Actifs Tier 0 identifiés** | 25 objets (dont 5 comptes administrateurs) |
| **Temps de compromission démontré** | Moins de 5 minutes |

---

## Top 3 des vulnérabilités exploitées

1. **Print Spooler actif sur le DC** → DCSync (extraction de tous les hashs du domaine).
2. **Comptes administrateurs déléguables** → Vol de tickets Kerberos (Pass-the-Ticket).
3. **NTLMv1/LM activé** → Pass-the-Hash (shell administrateur en 30 secondes).

---

## Plan de remédiation

| Phase | Actions | Statut |
| :--- | :--- | :--- |
| **Urgent (Sem. 1-2)** | Désactivation du Spooler, rotation des mots de passe, flag "non déléguable" | ✅ Terminé |
| **Structurel (Sem. 3-8)** | Déploiement LAPS, Credential Guard, groupe Protected Users | ⏳ En cours |
| **Gouvernance (Mois 2-6)** | SIEM, monitoring Events 4768/4769, modèle Tier 0/1/2 | 📅 Planifié |

---

## Validation des correctifs

**Avant durcissement** (Pass-the-Hash réussi) :
```powershell
sekurlsa::pth /user:karim-adm /ntlm:fa7665bef... /run:cmd
# ✅ Shell ADMIN obtenu.
