# 🔐 Audit de Sécurité Active Directory — cybertechsali.com

> Un audit complet d'Active Directory documentant une exploitation réelle 
> avec preuve de remédiation. Méthodologie rigoureuse + code + proof-of-concept.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: Complete](https://img.shields.io/badge/Status-Complete-brightgreen)]()
[![Level: Intermediate-Advanced](https://img.shields.io/badge/Level-Intermediate--Advanced-blue)]()

---

## 📋 Table of Contents

- [Overview](#overview)
- [What's Inside](#whats-inside)
- [Quick Start](#quick-start)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [Remediation](#remediation)
- [Files & Structure](#files--structure)
- [Tools Used](#tools-used)
- [Usage & Attribution](#usage--attribution)

---

## 🎯 Overview

This repository documents a **complete security audit** of an Active Directory 
environment (cybertechsali.com lab) including:

- ✅ **Passive Audit** (PingCastle, Purple Knight)
- ✅ **Active Reconnaissance** (BloodHound)
- ✅ **Real Exploitation** (Mimikatz) — Pass-the-Ticket, Pass-the-Hash, DCSync
- ✅ **Proof-of-Concept Remediation** (NTLM/Kerberos hardening validated)
- ✅ **3-Phase Remediation Plan** (48 hours → 6 months)

### Key Numbers

| Metric | Value |
|--------|-------|
| **Security Score** | 55/100 (CRITICAL) |
| **Critical Findings** | 10 (PingCastle) |
| **IOE Detected** | 17 (Purple Knight) |
| **Attack Surface** | 4 vectors exploited |
| **Time to Compromise** | < 5 minutes |
| **Exploitation Proof** | ✅ Real (Mimikatz) |
| **Pages of Report** | 30+ |

---

## 📦 What's Inside

### Rapport Complet
- **RAPPORT_AUDIT_AD_FINAL.md** — Rapport texte intégral
- **RAPPORT_AUDIT_AD_FINAL.pdf** — PDF professionnel (impression)
- **RAPPORT_AUDIT_AD_FINAL.docx** — Word (édition + personnalisation)

### Sections Clés
1. **Résumé Exécutif** — Score, risques immédiats, impacts
2. **Méthodologie** — 3 phases, outils, timeline
3. **Findings Détaillés** — 10 critiques expliqués
4. **Exploitation Réelle** — Mimikatz 7 étapes
5. **Mouvement Latéral** — Pass-the-Ticket & Pass-the-Hash
6. **Remédiation** — 14 actions sur 3 phases
7. **Preuve de Concept** — Durcissement NTLM/Kerberos validé
8. **Conclusions & Plan d'Action** — Prochaines étapes

### Screenshots
Evidence of exploitation from real Mimikatz sessions:
- Administrator credentials extraction
- Kerberos ticket export
- DCSync execution

### Tools & Scripts
- PowerShell remediation scripts (Phase 1, 2, 3)
- GPO templates (ready to deploy)
- Validation scripts

### Documentation
- Full methodology explanation
- Technical glossary (Kerberos, NTLM, etc.)
- References (MITRE ATT&CK, ANSSI, CIS)

---

## 🚀 Quick Start

### 1️⃣ Read the Full Report

Start here for the complete picture:

```bash
# Open the main report
cat rapport/RAPPORT_AUDIT_AD_FINAL.md

# Or download the PDF for printing
# → rapport/RAPPORT_AUDIT_AD_FINAL.pdf
```

### 2️⃣ Understand the Findings

Quick navigation:
- **Section 4** : 10 Critical Findings (explained)
- **Section 6** : Real Exploitation (Mimikatz 7 steps)
- **Section 7** : Lateral Movement (Pass-the-Ticket, Pass-the-Hash)

### 3️⃣ Review the Remediation Plan

Priority phases:
- **Phase 1 (48 hours)** : 6 actions = 80% risk reduction
- **Phase 2 (8 weeks)** : LAPS, Credential Guard, MFA
- **Phase 3 (6 months)** : Tiering, PAW, SIEM

### 4️⃣ Deploy Scripts (Optional)

```bash
# Phase 1 remediation (urgent, low risk)
.\tools\remediation-phase1.ps1

# Validate remediation works
.\tools\validation-remediation.ps1

# Deploy GPO
Import-GPO -BackupGpoName "GPO-Securite-Auth" .\templates\
```

---

## 🔍 Methodology

### Phase 1: Passive Audit
- **PingCastle 3.2.0** : Configuration scan → 10 findings
- **Purple Knight 2.1.0** : Exposure indicators → 17 IOE detected
- **Result** : Comprehensive baseline of vulnerabilities

### Phase 2: Active Reconnaissance
- **BloodHound 4.1.0** : AD mapping → Attack paths visualized
- **SharpHound 2.1.0** : Data collection
- **Result** : Privilege escalation routes identified

### Phase 3: Real Exploitation
- **Mimikatz 2.2.0** : Credential extraction → PROVEN EXPLOITABLE
- **Techniques** : 
  - sekurlsa::logonpasswords (clear text)
  - sekurlsa::tickets (Kerberos export)
  - lsadump::dcsync (domain secrets)
  - sekurlsa::pth (Pass-the-Hash)
  - kerberos::ptt (Pass-the-Ticket)
- **Result** : Complete domain compromise in < 5 minutes

### Validation
- All three tools (PingCastle, Purple Knight, Mimikatz) confirm same vulnerabilities
- Confidence level: 100%

---

## ⚠️ Key Findings at a Glance

### Tier 0 Risks (Immediate Action Required)

| # | Finding | Impact | MITRE |
|---|---------|--------|-------|
| 1 | Printer Spooler on DC | RPC → Domain Secrets | T1021.006 |
| 2 | Admin Accounts Delegable | Kerberos Delegation → Impersonation | T1558 |
| 3 | NTLM/LM Enabled | Pass-the-Hash possible | T1550.002 |

### The Attack Chain (Real Proof)
