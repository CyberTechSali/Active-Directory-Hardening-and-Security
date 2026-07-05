<p align="center">
  <img src="https://img.shields.io/badge/Mission-Cyber%20Resilience-0A0A2A?style=for-the-badge&logo= defender" />
  <img src="https://img.shields.io/badge/Status-Operation%20Completed-brightgreen?style=for-the-badge&logo=checkmarx" />
  <img src="https://img.shields.io/badge/Framework-ANSSI%20%7C%20MITRE%20ATT&CK-red?style=for-the-badge&logo=mitre" />
  <img src="https://img.shields.io/badge/Type-Red%20Team%20%26%20Blue%20Team-blue?style=for-the-badge&logo=datadog" />
</p>

<br>

<div align="center">
  <h1>⚔️ ACTIVE DIRECTORY : <br> AUDIT OFFENSIF & DURCISSEMENT</h1>
  <p>
    <i>De l'énumération silencieuse à la compromission totale en 5 minutes, <br> jusqu'à la mise en place d'une défense en profondeur.</i>
  </p>
  <br>
  <p>
    <b>👤 Auditeur :</b> OUCHAHEd SALMA &nbsp;|&nbsp; 
    <b>🎯 Cible :</b> cybertechsali.com &nbsp;|&nbsp; 
    <b>📅 Périmètre :</b> Nov. - Déc. 2025
  </p>
</div>

---

## 📊 TABLEAU DE BORD EXÉCUTIF

| Métrique | Résultat | Évaluation |
| :--- | :--- | :--- |
| **Score de Risque Global (PingCastle)** | `55 / 100` | 🔴 **Risque Critique** (Sous la moyenne secteur) |
| **Indicateurs d'Exposition (Purple Knight)** | `17 IOEs` | 🟠 Faiblesses structurelles majeures |
| **Actifs Tier Zero identifiés** | `25 objets` | 🟣 5 comptes administrateurs en ligne de mire |
| **Temps de Compromission (Exploit)** | `< 5 minutes` | ⏱️ Attaque fulgurante (Mimikatz) |
| **Vecteurs d'attaque validés** | `3 chaînes` | 🚪 Print Spooler, PtH, PtT |
| **Correctifs critiques appliqués** | `5 actions` | ✅ Pass-the-Hash désormais bloqué |

---

## 🧠 LA PHILOSOPHIE DE L'AUDIT

> *"La sécurité ne se résume pas à une checklist de conformité. Un vrai audit doit prouver l'impact opérationnel en enchaînant les vulnérabilités, avant de proposer des remédiations vérifiables."*

Ce projet ne s'est pas arrêté à un simple scan passif. J'ai suivi une méthodologie en **3 actes** :

1. **🔍 Reconnaissance Automatisée** : Cartographie complète de l'AD avec PingCastle, Purple Knight et BloodHound.
2. **💀 Exploitation & Mouvement Latéral** : Passage à l'action avec Mimikatz pour démontrer les scénarios du monde réel (Pass-the-Hash, DCSync).
3. **🛡️ Durcissement & Validation** : Application des GPO, vérification des événements de sécurité et test de régression pour prouver l'efficacité des correctifs.

---

## 🛠️ LA STACK TECHNIQUE (Les Armes du Pentester)

| Outil | Version | Mission |
| :--- | :--- | :--- |
| <img src="https://img.icons8.com/color/20/000000/checkmark.png"/> **PingCastle** | 3.2.1+ | Évaluation du score de risque et détection des failles de configuration. |
| <img src="https://img.icons8.com/color/20/000000/shield.png"/> **Purple Knight** | CE | Audit des 118 indicateurs de sécurité (ANSSI, MITRE ATT&CK). |
| <img src="https://img.icons8.com/color/20/000000/blood.png"/> **BloodHound** | 8.3.1 | Cartographie des relations de confiance (Tier Zero) et visualisation des attaques. |
| <img src="https://img.icons8.com/color/20/000000/lock--v1.png"/> **Mimikatz** | 2.2.0 | Extraction des secrets, vol de tickets Kerberos et DCSync. |
| <img src="https://img.icons8.com/color/20/000000/console.png"/> **SharpHound** | 2.8.0 | Collecte de données pour alimenter BloodHound. |

---

## ⛓️ LA CHAÎNE D'ATTAQUE DÉMONTÉE (Kill Chain)

Voici le chemin réellement emprunté par l'attaquant (moi) pour passer d'un simple utilisateur à un contrôleur de domaine :

| Étape | Technique | Outil | Résultat |
| :--- | :--- | :--- | :--- |
| **1. Reconnaissance** | Énumération LDAP | SharpHound | Cartographie de 9 users, 52 groups, 2 computers. |
| **2. Accès initial** | Connexion standard | (Lab) | Poste POST55 compromis (utilisateur standard). |
| **3. Escalade (PtT)** | Vol du ticket Kerberos | Mimikatz | Extraction du TGT de `karim-adm` (Admin). |
| **4. Mouvement Latéral** | Pass-the-Hash | Mimikatz | Shell `cmd.exe` sous identité `karim-adm`. |
| **5. Prise de contrôle** | DCSync | Mimikatz | Extraction de TOUS les hashs du domaine (`lsadump::dcsync`). |

---

## 🏆 TOP 3 DES VULNÉRABILITÉS CRITIQUES (AVANT CORRECTION)

| # | Faiblesse | Exploit démontré | Gravité |
| :--- | :--- | :--- | :--- |
| **1** | **Service Print Spooler actif sur le DC** | Coercition NTLM vers DCSync (extraction des hashs). | 🚨 **Critique** |
| **2** | **Comptes Admin déléguables** | Vol du ticket Kerberos et impersonnalisation (`Pass-the-Ticket`). | 🚨 **Critique** |
| **3** | **NTLMv1 & LM autorisés** | Réutilisation du hash NTLM (`Pass-the-Hash`). Shell Admin en 30s. | 🔥 **Urgent** |

---

## 🛡️ LE PLAN DE REMÉDIATION (De l'Urgence à la Gouvernance)

Le rapport propose un échelonnement temporel pour une mise en œuvre sans rupture de service.

### 🚨 PHASE 1 : URGENT (Semaine 1-2)
*Actions immédiates pour stopper l'hémorragie.*
- [x] **Désactivation du Spooler** sur le DC (`Stop-Service Spooler`).
- [x] **Protection des comptes Admin** (Flag "Sensitive and cannot be delegated" activé).
- [x] **Rotation des mots de passe** des comptes critiques (Admin, krbtgt).
- [x] **Durcissement NTLM** : Refus de LM/NTLMv1, passage en NTLMv2 uniquement.

### ⚙️ PHASE 2 : STRUCTUREL (Semaine 3-8)
*Renforcement de la posture de sécurité.*
- [ ] **Déploiement de LAPS** (Gestion sécurisée des mots de passe locaux).
- [ ] **Activation de Credential Guard** (Protection de la mémoire LSASS).
- [ ] **Ajout au groupe Protected Users** (Tickets Kerberos non réutilisables).
- [ ] **Mode Restricted Admin** pour les sessions RDP.

### 🏛️ PHASE 3 : GOUVERNANCE (Mois 2-6)
*Sécurité pérenne et détection proactive.*
- [ ] **Segmentation Tier 0 / 1 / 2** (Isolation des comptes sensibles).
- [ ] **Déploiement d'un SIEM** et monitoring des Events **4768/4769**.
- [ ] **Privilèges Just-In-Time (JIT)** pour les administrateurs.

---

## ✅ VALIDATION DES CORRECTIFS (BEFORE / AFTER)

La preuve par l'exemple : le test de régression après durcissement.

### AVANT (Vulnérabilité)
```powershell
# Mimikatz
sekurlsa::pth /user:karim-adm /ntlm:fa7665befea243a5079d1c602f5524ce0 /run:cmd
# ✅ Shell ADMIN obtenu en 30 secondes.
