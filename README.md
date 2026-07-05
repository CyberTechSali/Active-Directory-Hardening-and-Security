<p align="center">
  <img src="https://img.shields.io/badge/Type-Active%20Directory%20Audit-blue?style=for-the-badge&logo=microsoft" />
  <img src="https://img.shields.io/badge/Tools-PingCastle%20%7C%20BloodHound%20%7C%20Mimikatz-orange?style=for-the-badge&logo=security" />
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Risk-Critical-red?style=for-the-badge" />
</p>

<h1 align="center">🛡️ Active Directory Security Audit</h1>
<p align="center">
  <b>Domain :</b> cybertechsali.com &nbsp;|&nbsp; 
  <b>Period :</b> Nov – Dec 2025 &nbsp;|&nbsp; 
  <b>Author :</b> OUCHAHED SALMA
</p>

---

## Context

This project is a complete security audit of the `cybertechsali.com` Active Directory environment. The objective was to identify critical vulnerabilities, demonstrate their real-world impact through controlled exploitation, and propose a validated hardening roadmap.

---

## Tools Used

| Tool | Version | Purpose |
| :--- | :--- | :--- |
| **PingCastle** | 3.2.1 | Risk analysis and global scoring |
| **Purple Knight** | Community | Detection of exposure indicators (IOEs) |
| **BloodHound** | 8.3.1 | Attack path mapping and Tier 0 asset identification |
| **Mimikatz** | 2.2.0 | Credential extraction (DCSync, Pass-the-Hash, Pass-the-Ticket) |

---

## Key Findings

| Metric | Result |
| :--- | :--- |
| **PingCastle Score** | 55/100 (High Risk) |
| **Exposure Indicators (Purple Knight)** | 17 IOEs |
| **Tier 0 Assets Identified** | 25 objects (including 5 admin accounts) |
| **Demonstrated Compromise Time** | Less than 5 minutes |

---

## 📸 Visual Evidence (Screenshots)

| Finding | Screenshot |
| :--- | :--- |
| **PingCastle Score 55/100** | ![PingCastle](Preuves/01_PingCastle_Score55.png) |
| **17 IOEs Detected (Purple Knight)** | ![Purple Knight](Preuves/02_PurpleKnight_IOEs.png) |
| **BloodHound Attack Paths (Tier Zero)** | ![BloodHound](Preuves/03_BloodHound_TierZero.png) |
| **DCSync Extraction (Mimikatz)** | ![Mimikatz DCSync](Preuves/04_Mimikatz_DCSync.png) |
| **Successful Pass-the-Hash (Admin Shell)** | ![Pass-the-Hash](Preuves/05_PassTheHash_Shell.png) |

---

## Top 3 Exploited Vulnerabilities

1. **Print Spooler enabled on the DC** → DCSync attack (all domain hashes extracted).
2. **Admin accounts delegable** → Kerberos ticket theft (Pass-the-Ticket).
3. **NTLMv1/LM still active** → Pass-the-Hash (admin shell in 30 seconds).

---

## Remediation Roadmap

| Phase | Actions | Status |
| :--- | :--- | :--- |
| **Urgent (Week 1-2)** | Disable Spooler, rotate admin passwords, enable "sensitive & non-delegable" flag | ✅ Completed |
| **Structural (Week 3-8)** | Deploy LAPS, enable Credential Guard, add admins to Protected Users group | ⏳ In progress |
| **Governance (Month 2-6)** | Deploy SIEM, monitor Events 4768/4769, implement Tier 0/1/2 model | 📅 Planned |

---

## ✅ Hardening Validation – Before / After

| Before (Vulnerable) | After (Hardened) |
| :--- | :--- |
| `sekurlsa::pth /user:karim-adm /ntlm:fa7665bef... /run:cmd` <br> ✅ **Admin shell obtained** | `sekurlsa::pth /user:karim-adm /ntlm:fa7665bef... /run:cmd` <br> ❌ **Authentication failed – NTLM refused** |

**Post-hardening Kerberos verification:**
```powershell
klist
# Tickets now use AES-256-CTS-HMAC-SHA1-96 encryption (OK)
Audit enabled: Security events 4768 (TGT) and 4769 (TGS) are now successfully logged.

https://Preuves/06_Remediation_Klist_Validation.png

Disclaimer
⚠️ This project contains confidential information (internal domain names, NTLM hashes, network topology).
The repository is private and must not be shared publicly.
Intended for lab use or advanced cybersecurity training purposes only.
