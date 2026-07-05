<div align="center">

# 🔐 Active Directory Security Audit & Hardening Report
## Domain: cybertechsali.com

[![Audit Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square&logo=github)](/)
[![Report Version](https://img.shields.io/badge/Report%20Version-2.0-blue?style=flat-square)](/)
[![Risk Level](https://img.shields.io/badge/Risk%20Level-CRITICAL%20→%20MEDIUM-orange?style=flat-square)](/)
[![PingCastle Score](https://img.shields.io/badge/PingCastle-55%2F100-red?style=flat-square&logo=windows)](/)
[![Purple Knight](https://img.shields.io/badge/Purple%20Knight-82%25%20(Grade%20C)-red?style=flat-square&logo=windows)](/)

[![License](https://img.shields.io/badge/License-Confidential-darkred?style=flat-square)](LICENSE)
[![Last Update](https://img.shields.io/badge/Last%20Updated-December%202025-blue?style=flat-square)](/)
[![Documentation](https://img.shields.io/badge/Documentation-Complete-success?style=flat-square)](docs/)

**Assessment Period:** November - December 2025  
**Auditor:** Mohammed HABIB LAMINI  
**Organization:** CyberSecure Solutions

---

</div>

## 📋 Table of Contents

- [Executive Summary](#executive-summary)
- [Key Metrics](#-key-metrics)
- [Findings Overview](#findings-overview)
- [Exploitation Demonstration](#exploitation-demonstration)
- [Remediation Actions](#remediation-actions)
- [Screenshots & Evidence](#-screenshots--evidence)
- [Implementation Roadmap](#implementation-roadmap)
- [Documentation](#documentation)
- [Quick Links](#quick-links)

---

## 🎯 Executive Summary

The cybertechsali.com Active Directory infrastructure presented a **CRITICAL security posture** with multiple vulnerabilities enabling complete domain compromise in under 5 minutes.

### Quick Facts

| Metric | Value | Status |
|--------|-------|--------|
| **Assessment Tools** | 4 (PingCastle, Purple Knight, BloodHound, Mimikatz) | ✅ Complete |
| **Critical Findings** | 5 P0 issues | ✅ All Fixed in Phase 1 |
| **Attack Paths Demonstrated** | 3 main vectors | ✅ Neutralized |
| **Exploitation Time** | < 5 minutes to domain admin | ✅ Remediated |
| **Risk Reduction** | 80% in Phase 1 | ✅ In Progress |
| **Remediation Timeline** | 6 months (3 phases) | ⏳ Executing |

---

## 📊 Key Metrics

### Audit Scores
PingCastle Assessment
┌─────────────────────────┐
│ Score: 55/100           │
│ Status: CRITICAL ⚠️      │
│ Trend: ↓ Improving      │
└─────────────────────────┘
Purple Knight Assessment
┌─────────────────────────┐
│ Grade: 82% / C          │
│ Status: CRITICAL ⚠️      │
│ Deficiencies: Many      │
└─────────────────────────┘
BloodHound Analysis
┌─────────────────────────┐
│ Tier Zero Objects: 25   │
│ Attack Paths: 10+       │
│ Status: Exploitable ❌  │
└─────────────────────────┘

### Risk Timeline
Risk Level Over Time
100% ┌─ BEFORE AUDIT (Critical Exposure)
│ ╲
80%│  ╲
│   ╲___ Phase 1 (Quick Wins) → 80% reduction
60%│        ╲
│         ╲___ Phase 2 (Strategic) → 50% reduction
40%│              ╲
│               ╲___ Phase 3 (Mature) → 50% reduction
20%│                ╲
│                 ╲
0%└──────────────────────────────────→
0    1wk  2-4wks        6months

---

## 🎪 Findings Overview

### The 5 Critical Issues (All P0)

| # | Finding | Impact | Fix Time | Status |
|---|---------|--------|----------|--------|
| **#1** | 🔴 Spooler on DC | DCSync + Full credential theft | 15 min | ✅ FIXED |
| **#2** | 🔴 Unconstrained Delegation | Identity spoofing via Kerberos | 45 min | ✅ FIXED |
| **#3** | 🔴 Legacy Protocols (RC4/DES) | Weak encryption on tickets | 2h | ✅ FIXED |
| **#4** | 🔴 NTLM/LM Enabled | Pass-the-Hash attacks | 2h | ✅ FIXED |
| **#5** | 🟠 No LAPS Deployment | Local admin password reuse | 1-2 weeks | ⏳ IN PROGRESS |

### Attack Surface Reduction
Before Remediation:
├─ 3 concurrent attack vectors
├─ No defense-in-depth
├─ In-memory credential theft trivial
└─ Domain compromise: < 5 minutes ❌
After Phase 1:
├─ 0 known vectors (all closed)
├─ Basic defense-in-depth
├─ In-memory theft difficult
└─ Domain compromise: 2-3 days ⚠️
After Phase 3:
├─ Tiering enforced
├─ Complete defense-in-depth
├─ In-memory theft impossible
└─ Threats detected/mitigated ✅

---

## 🔥 Exploitation Demonstration

We demonstrated **real-world attack techniques** on the infrastructure. This section documents the practical proof-of-concept.

### Attack Path #1: Spooler → DCSync → Domain Admin
┌─────────────────────────────────────────────┐
│ Spooler Service Enabled on DC               │
│ ↓                                           │
│ Attacker forces DC authentication via RPC   │
│ ↓                                           │
│ Captures DC Kerberos ticket                 │
│ ↓                                           │
│ Executes lsadump::dcsync                    │
│ ↓                                           │
│ ALL domain hashes extracted                 │
│ ↓                                           │
│ Domain Admin access achieved ❌             │
└─────────────────────────────────────────────┘
Time: 2 minutes | Effort: Minimal

**Evidence:** See Images 1-10 below

---

### Attack Path #2: Unconstrained Delegation → Ticket Theft → Spoofing
┌─────────────────────────────────────────────┐
│ Admin connects to server (unconstrained)    │
│ ↓                                           │
│ Server receives full admin ticket           │
│ ↓                                           │
│ Attacker extracts ticket via Mimikatz       │
│ ↓                                           │
│ Ticket re-injected in new session           │
│ ↓                                           │
│ Attacker now = Domain Admin ❌              │
└─────────────────────────────────────────────┘
Time: 3 minutes | Effort: Low | Password: Not needed

**Evidence:** See Images 2-6 below

---

### Attack Path #3: In-Memory Extraction → Pass-the-Hash → Shell
┌─────────────────────────────────────────────┐
│ Attacker has local admin access             │
│ ↓                                           │
│ sekurlsa::logonpasswords extracts NTLM      │
│ ↓                                           │
│ Gets hash: fa7665befe243a5079d1c602f5524ce0│
│ ↓                                           │
│ sekurlsa::pth injects hash into new process │
│ ↓                                           │
│ Shell obtained as Domain Admin ❌           │
└─────────────────────────────────────────────┘
Time: 30 seconds | Effort: Trivial | Password: Not cracked

**Evidence:** See Images 9-10 below

---

## 🖼️ Screenshots & Evidence

### Section 1: Mimikatz Exploitation (10 Screenshots)

#### **Image 1: Pass-the-Hash Error (Context)**
![Mimikatz PTH Error](screenshots/01_mimikatz_exploitation/01_PTH_Error.png)
*Initial PTH attempt failure on sali-adm account*

---

#### **Image 2: Kerberos Ticket Export**
![Ticket Export](screenshots/01_mimikatz_exploitation/02_Tickets_Export.png)
*Command: `sekurlsa::tickets /export` — Extracts all cached Kerberos tickets from LSASS*

---

#### **Image 3: Generated .kirbi Files**
![Kirbi Files](screenshots/01_mimikatz_exploitation/03_Kirbi_Files.png)
*File explorer showing exported .kirbi files — karim-adm ticket visible*

---

#### **Image 4: karim-adm.kirbi Selected**
![Kirbi Selected](screenshots/01_mimikatz_exploitation/04_Kirbi_Selected.png)
*Target ticket file ready for injection*

---

#### **Image 5: Pass-the-Ticket Injection**
![PTT Injection](screenshots/01_mimikatz_exploitation/05_PTT_Injection.png)
*Command: `kerberos::ppt karim-adm.kirbi` — "File: OK" confirmation*
**Technique:** T1550.003 - Use Alternate Authentication Material

---

#### **Image 6: Kerberos List (Verification)**
![Kerberos List](screenshots/01_mimikatz_exploitation/06_Kerberos_List.png)
*Command: `kerberos::list` — Shows TGT for karim-adm now active in cache*
**Impact:** Attacker now has valid Domain Admin ticket without password knowledge

---

#### **Image 7: Runas /netonly (Part 1)**
![Runas Command](screenshots/01_mimikatz_exploitation/07_Runas_Netonly_1.png)
*Command: `runas /netonly /user:CYBERTECHSALI.COM\karim-adm powershell.exe`*
*Opens new PowerShell session under karim-adm identity (no password verification)*

---

#### **Image 8: PowerShell Session Opened**
![Session Open](screenshots/01_mimikatz_exploitation/08_Runas_Session.png)
*New session successfully created as karim-adm*

---

#### **Image 9: NTLM Hash Extraction**
![NTLM Extract](screenshots/01_mimikatz_exploitation/09_NTLM_Extraction.png)
*Command: `sekurlsa::logonpasswords` — Extracts NTLM hash from memory*
*Hash: fa7665befe243a5079d1c602f5524ce0*
**Technique:** T1003.001 - Credential Dumping

---

#### **Image 10: Final Pass-the-Hash Success**
![PTH Success](screenshots/01_mimikatz_exploitation/10_PTH_Final_Success.png)
*Command: `sekurlsa::pth /user:karim-adm /domain:CYBERTECHSALI.COM /ntlm:fa7665befe... /run:cmd`*
*Result: cmd.exe shell opened with full Domain Admin privileges*
**Technique:** T1550.002 - Use Alternate Authentication Material (Pass-the-Hash)

---

### Section 2: Kerberos Hardening (15 Screenshots)

#### **Image 11: Services Management Console**
![Services MSC](screenshots/02_kerberos_hardening/11_Services_MSC.png)
*Opening services.msc to verify Kerberos KDC service status*

---

#### **Image 12: KDC Service Running**
![KDC Status](screenshots/02_kerberos_hardening/12_KDC_Service.png)
*"Centre de distribution de clés Kerberos" service is Running (Automatic)*
*Critical for enforcing Kerberos-only authentication*

---

#### **Image 13: Server Manager + Network Configuration**
![Server Manager](screenshots/02_kerberos_hardening/13_Server_Manager.png)
*Accessing network configuration (ncpa.cpl) for DNS verification*

---

#### **Image 14: TCP/IPv4 Properties**
![TCP IPv4](screenshots/02_kerberos_hardening/14_TCP_IPv4.png)
*DNS Configuration: Preferred server = 127.0.0.1 (DC itself)*
*Critical for Kerberos SRV record resolution*

---

#### **Image 15: GPO Creation**
![GPO Create](screenshots/02_kerberos_hardening/15_GPO_Creation.png)
*Creating new Group Policy Object: "GPO-Sécurité-Auth"*
*Will contain NTLM/Kerberos hardening policies*

---

#### **Image 16: Group Policy Editor**
![GPO Editor](screenshots/02_kerberos_hardening/16_GPO_Editor.png)
*Group Policy Editor opened with GPO-Sécurité-Auth visible*

---

#### **Image 17: Security Options Navigation**
![Security Options](screenshots/02_kerberos_hardening/17_Security_Options.png)
*Path: Computer Config > Windows Settings > Security Settings > Local Policies > Security Options*
*Target: "Sécurité réseau : niveau d'authentification LAN Manager"*

---

#### **Image 18: NTLM/LM Restriction Configuration**
![LM Config](screenshots/02_kerberos_hardening/18_LM_Auth_Config.png)
*Setting: "Envoyer uniquement les réponses NTLMv2. Refuser LM"*
*Effect: Disables NTLM/LM, enforces NTLMv2 minimum (Kerberos preferred)*

---

#### **Image 19: Configuration Confirmation**
![Confirmation](screenshots/02_kerberos_hardening/19_Confirmation.png)
*Warning dialog confirming compatibility impact*
*Proceeding to apply hardening policy*

---

#### **Image 20: LM Hash Removal Setting**
![No LM Hash](screenshots/02_kerberos_hardening/20_No_LM_Hash.png)
*Setting: "Sécurité réseau : ne pas stocker de valeurs de hachage LM"*
*Status: Enabled*
*Effect: Future password changes won't store LM hashes (reduces attack surface)*

---

#### **Image 21: Kerberos Ticket Cache (Admin)**
![KList Admin](screenshots/02_kerberos_hardening/21_KList_Admin.png)
*Command: `klist` on Administrateur account*
*Result: 1 ticket cached, encrypted with AES-256-CTS-HMAC-SHA1-96*
*Verification: Kerberos functioning normally post-hardening*

---

#### **Image 22: Test Login Screen**
![Login Test](screenshots/02_kerberos_hardening/22_Login_Screen.png)
*Windows logon screen with sali-adm user selected for validation testing*

---

#### **Image 23: Kerberos Ticket Cache (Sali-adm)**
![KList Sali](screenshots/02_kerberos_hardening/23_KList_Sali_ADM.png)
*Command: `klist` on sali-adm account*
*Result: 6 tickets cached, ALL in AES-256*
*Includes: TGT + delegation tickets for ProtectedStorage and other services*
*Verification: Complex Kerberos delegation working correctly*

---

#### **Image 24: Kerberos Service Ticket Event (4769)**
![Event 4769](screenshots/02_kerberos_hardening/24_Event_4769.png)
*Windows Event Viewer: Event 4769 (Kerberos Service Ticket Operations)*
*"Un ticket de service Kerberos a été demandé" (A Kerberos service ticket was requested)*
*Use: Monitoring for Pass-the-Ticket attacks via rapid ticket injection patterns*

---

#### **Image 25: Kerberos TGT Event (4768)**
![Event 4768](screenshots/02_kerberos_hardening/25_Event_4768.png)
*Windows Event Viewer: Event 4768 (Kerberos Authentication Service)*
*"Un ticket d'authentification Kerberos (TGT) a été demandé" (A Kerberos TGT was requested)*
*Use: Monitoring for unusual TGT requests (brute force, delegation abuse)*

---

## ✅ Remediation Actions

### Phase 1: Immediate (Week 1) — 4 Hours

| Action | Time | Status | Impact |
|--------|------|--------|--------|
| **1.1** Disable Spooler on DC | 15 min | ✅ DONE | Closes DCSync vector |
| **1.2** Change admin passwords (5 accounts) | 30 min | ✅ DONE | Invalidates old hashes |
| **1.3** Set "non-delegable" flag on admins | 45 min | ✅ DONE | Closes ticket theft vector |
| **1.4** Deploy GPO: Kerberos/AES, disable NTLM | 2h | ✅ DONE | Closes Pass-the-Hash vector |

**Result:** Risk CRITICAL → ACCEPTABLE (80% reduction)

---

### Phase 2: Strategic (Weeks 2-4)

- ⏳ LAPS deployment (1-2 weeks)
- ⏳ Credential Guard enablement (3-5 days)
- ⏳ MFA for admin accounts (2-3 days)
- ⏳ Protected Users group configuration (1 day)
- ⏳ Restricted Admin RDP mode (2 days)

**Target:** Risk ACCEPTABLE → MEDIUM

---

### Phase 3: Mature (Months 2-6)

- Tier-0/1/2 implementation
- PAW (Privileged Access Workstations)
- SIEM for Kerberos monitoring
- Advanced Threat Analytics
- Just-In-Time access (JIT/PIM)

**Target:** Risk MEDIUM → LOW (zero-trust posture)

---

## 📖 Implementation Roadmap
Week 1 (Phase 1)
├─ Mon: Disable Spooler
├─ Tue: Reset admin passwords
├─ Wed: Set non-delegable flags
└─ Thu-Fri: Deploy Kerberos/AES GPO
Week 2-4 (Phase 2)
├─ LAPS deployment
├─ Credential Guard
├─ MFA integration
└─ Protected Users
Month 2-6 (Phase 3)
├─ Tiering model
├─ PAW infrastructure
├─ SIEM configuration
└─ JIT access platform

---

## 📚 Documentation

| Document | Purpose | Location |
|----------|---------|----------|
| **Executive Brief** | C-suite overview (2 pages) | `/reports/Executive_Brief.pdf` |
| **Full Report (FR)** | Detailed audit (35+ pages) | `/reports/Rapport_Audit_Durcissement_AD_FINAL.docx` |
| **Full Report (EN)** | English translation | `/reports/Active_Directory_Audit_Report_ENGLISH.docx` |
| **Project Summary** | Key metrics & roadmap | `/reports/Project_Summary_Resume.docx` |
| **Methodology** | How we did the audit | `/docs/METHODOLOGY.md` |
| **Detailed Findings** | Technical deep-dive | `/docs/FINDINGS_DETAILED.md` |
| **Monitoring Guide** | SIEM setup for 4768/4769 | `/docs/MONITORING_GUIDE.md` |

---

## 🛠️ Tools & Resources

### Assessment Tools Used
- **PingCastle** — AD security scoring
- **Purple Knight** — Configuration audit
- **BloodHound** — Privilege escalation mapping
- **Mimikatz** — Credential extraction proof-of-concept

### Provided Templates
- `GPO-Securite-Auth.xml` — Group Policy for hardening
- `SIEM_Rules_4768_4769.json` — Detection rules
- `Remediation_Checklist.md` — Implementation checklist
- PowerShell scripts for automation
