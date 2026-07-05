<p align="center">
  <img src="https://img.shields.io/badge/Audit-Active%20Directory-blue?style=for-the-badge&logo=microsoft" alt="Active Directory"/>
  <img src="https://img.shields.io/badge/Methodology-Offensive%20%26%20Defensive-red?style=for-the-badge&logo=datadog" alt="Offensive & Defensive"/>
  <img src="https://img.shields.io/badge/Status-Correctifs%20Validés-brightgreen?style=for-the-badge" alt="Status"/>
  <img src="https://img.shields.io/badge/Tools-PingCastle%20%7C%20BloodHound%20%7C%20Mimikatz-orange?style=for-the-badge&logo=security" alt="Tools"/>
</p>

<h1 align="center">🛡️ Audit de Sécurité & Durcissement Active Directory</h1>
<p align="center">
  <b>Domaine :</b> cybertechsali.com &nbsp;|&nbsp; 
  <b>Période :</b> Nov. 2025 - Déc. 2025 &nbsp;|&nbsp; 
  <b>Auditeur :</b> OUCHAHEd SALMA
</p>

---

## 📌 Contexte du Projet

Ce projet consiste en un audit de sécurité complet de l'infrastructure Active Directory (AD) du domaine `cybertechsali.com`. L'objectif principal était d'évaluer la posture de sécurité actuelle, d'identifier les vecteurs d'attaque critiques et de proposer un plan de remédiation concret, allant de la théorie à la validation pratique des correctifs.

L'audit a suivi une approche en trois phases :
- **Évaluation automatisée** (PingCastle, Purple Knight)
- **Exploitation pratique** (BloodHound, Mimikatz)
- **Remédiation et validation** (GPO, durcissement NTLM/Kerberos)

---

## 🗺️ Périmètre Technique

| Élément | Détail |
| :--- | :--- |
| **Domaine** | `cybertechsali.com` |
| **Niveau fonctionnel** | Windows Server 2016 |
| **Contrôleurs de domaine** | 1 (DC1 - `192.168.1.1`) |
| **Poste compromis (Lab)** | 1 (POST55) |
| **Comptes critiques testés** | `Administrator`, `karim-adm`, `sali-adm`, `hajar.lamini` |

---

## 🛠️ Stack Technique Utilisée

L'audit a utilisé une stack d'outils de l'industrie pour garantir une couverture maximale (du statique à l'exploitation dynamique) :

| Outil | Version | Rôle dans l'audit |
| :--- | :--- | :--- |
| **PingCastle** | 3.2.1+ | Analyse passive des risques et scoring global. |
| **Purple Knight** | Community | Vérification de 118 indicateurs de sécurité (IOEs) et mapping avec le référentiel ANSSI. |
| **BloodHound** | 8.3.1 (CE) | Cartographie des relations de confiance (Tier Zero) et visualisation des chemins d'attaque. |
| **Mimikatz** | 2.2.0 | Extraction des secrets mémoire (credential dumping), DCSync, Pass-the-Hash/Ticket. |
| **SharpHound** | 2.8.0 | Collecteur de données pour alimenter BloodHound. |

---

## 📊 Verdict Global & Scores

La convergence des outils a classé l'infrastructure comme **"Critically At-Risk"** avant correction.

| Outil | Score obtenu | Niveau de risque |
| :--- | :--- | :--- |
| **PingCastle** | **55 / 100** | 🔴 **Risque Élevé** (25ème-35ème percentile, très inférieur à la moyenne du secteur). |
| **Purple Knight** | **82% (Grade C)** | 🟠 Faiblesses critiques de configuration (17 Indicateurs d'Exposition). |
| **BloodHound** | 25 actifs Tier Zero | 🟣 5 comptes utilisateurs (dont Administrateur) identifiés comme cibles absolues. |
| **Exploitation (Mimikatz)** | Compromis en < 5 min | 🔴 Extraction des hashs NTLM, tickets Kerberos et accès Admin sans connaître le mot de passe. |

---

## ⚠️ Top 3 des Vecteurs d'Attaque Démontrés

L'exploitation pratique a validé 3 chaînes d'attaque indépendantes menant à la compromission totale :

| # | Vecteur d'attaque | Temps d'exécution | Impact démontré |
| :--- | :--- | :--- | :--- |
| **1** | **Print Spooler → DCSync** | ~2 minutes | Extraction de tous les hashs du domaine via `lsadump::dcsync`. |
| **2** | **Pass-the-Ticket (Kerberos)** | ~3 minutes | Impersonnalisation du compte `karim-adm` en injectant son TGT volé. |
| **3** | **Pass-the-Hash (NTLM)** | ~30 secondes | Obtention d'un shell `cmd.exe` interactif sous l'identité `karim-adm` sans connaître le mot de passe. |

---

## 🛡️ Plan de Remédiation & Durcissement

Face à ces risques, un plan de correction en trois phases a été établi et **partiellement validé en laboratoire** :

| Phase | Délai | Actions menées | Statut |
| :--- | :--- | :--- | :--- |
| **Phase 1 (Urgent)** | Semaines 1-2 | 🔹 Désactivation du service Spooler sur le DC.<br>🔹 Activation du flag *"Account is sensitive and cannot be delegated"*.<br>🔹 Changement des mots de passe administrateurs.<br>🔹 Restriction de l'authentification à **Kerberos/AES-256 uniquement**. | ✅ **Appliqué & Validé** |
| **Phase 2 (Structurel)** | Semaines 3-8 | 🔹 Déploiement de **Microsoft LAPS** (gestion des mots de passe locaux).<br>🔹 Activation de **Credential Guard** sur les postes.<br>🔹 Ajout des admins au groupe **Protected Users**.<br>🔹 Activation du mode *Restricted Admin* pour RDP. | ⏳ En cours d'implémentation |
| **Phase 3 (Gouvernance)** | Mois 2-6 | 🔹 Implémentation du modèle d'administration **Tier 0/1/2**.<br>🔹 Déploiement d'un **SIEM** avec monitoring des Events 4768/4769.<br>🔹 Mise en place de l'approche **Just-In-Time (JIT)** admin. | 📅 Planifié |

---

## ✅ Validation des Correctifs (NTLM/Kerberos)

Pour prouver l'efficacité du durcissement, des tests post-remédiation ont été menés :

1. **Service KDC** : Vérifié comme opérationnel (`Running`) avec un DNS résolvant correctement les SRV records.
2. **GPO dédiée** : Création de `GPO-Security-Authentication` (bonne pratique de ne pas toucher à la GPO Default Domain Policy).
3. **Restriction NTLM** : Passage du paramètre *"LAN Manager Authentication Level"* à **"Send NTLMv2 response only. Refuse LM"**.
4. **Validation Kerberos** : Exécution de `klist` confirmant que les tickets sont désormais émis avec du chiffrement **AES-256-CTS-HMAC-SHA1-96**.
5. **Traçabilité SIEM** : Activation des audits de sécurité sur les événements **4768** (TGT) et **4769** (TGS), essentiels pour détecter les réutilisations de tickets.

---

## 📁 Structure du Dépôt

```text
Audit-AD-cybertechsali/
├── README.md                                   # Ce fichier
├── Rapport_Audit_AD_Final.pdf                  # Rapport complet (toutes les preuves)
├── Preuves_Techniques/                         # Captures d'écran organisées
│   ├── 01_PingCastle_Score55.png
│   ├── 02_BloodHound_TierZero.png
│   └── 03_Mimikatz_DCSync_Extraction.png
└── Scripts_Remediation/                        # Automatisation des correctifs
    ├── Disable_Spooler_Service.ps1
    └── Apply_NTLM_Hardening_GPO.ps1
