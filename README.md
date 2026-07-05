# 🔐 Active Directory Security Audit

> A comprehensive security audit of an Active Directory environment with real exploitation proof and actionable remediation plan.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: Complete](https://img.shields.io/badge/Status-Complete-brightgreen)]()
[![Level: Intermediate-Advanced](https://img.shields.io/badge/Level-Intermediate--Advanced-blue)]()
[![PowerShell](https://img.shields.io/badge/PowerShell-Ready-green)]()

---

## 📊 Quick Stats

| Metric | Value |
|--------|-------|
| **Security Score** | 55/100 (CRITICAL) |
| **Critical Findings** | 10 (PingCastle) |
| **Exposure Indicators** | 17 (Purple Knight) |
| **Time to Full Compromise** | < 5 minutes |
| **Exploitation Proof** | ✅ Real (Mimikatz) |
| **Remediation Plan** | ✅ 3 phases, 14 actions |
| **Automation Scripts** | ✅ Phase 1, 2, 3 included |
| **Ready for Production** | ✅ YES |

---

## 🎯 Project Overview

This repository documents a **real-world Active Directory security audit** including:

✅ **Passive Audit Phase**
- PingCastle 3.2.0 security scan
- Purple Knight exposure indicators
- Comprehensive vulnerability assessment

✅ **Active Reconnaissance Phase**
- BloodHound AD mapping
- Attack path visualization
- Privilege escalation routes

✅ **Real Exploitation Phase**
- Mimikatz credential extraction
- Pass-the-Ticket attack (Kerberos)
- Pass-the-Hash attack (NTLM)
- DCSync domain secrets extraction
- **Complete domain compromise in < 5 minutes PROVEN**

✅ **Remediation Phase**
- 3-phase action plan (48 hours → 6 months)
- 14 detailed recommendations
- PowerShell automation scripts
- GPO templates (ready to deploy)
- Proof-of-concept validation

---

## 📁 What's Inside

### 📄 Complete Audit Report
- **30+ pages** of detailed findings
- Real screenshots from Mimikatz sessions
- Attack chain explanation
- Business impact analysis
- Available in: PDF, Word (.docx), Markdown

### 🔍 10 Critical Findings
Each finding includes:
- Description of vulnerability
- Real exploitation proof
- Business impact
- MITRE ATT&CK mapping
- Detailed remediation steps

### 🛠️ Automation Tools
**Phase 1 (URGENT — 48 hours):**
- `remediation-phase1.ps1` — 6 immediate actions
- `validation.ps1` — Verify remediation works
- Results: 80% risk reduction

**Phase 2 (Medium-term — 8 weeks):**
- `deploy-laps.ps1` — Local Administrator Password Solution
- `enable-credential-guard.ps1` — Isolate LSASS
- Results: 95% risk reduction

**Phase 3 (Long-term — 6 months):**
- Tiering implementation guide
- PAW deployment guide
- SIEM setup instructions

### 📋 GPO Templates
- Ready-to-import XML template
- Step-by-step deployment guide
- Registry settings included
- NTLM/LM disable configuration

### 📚 Complete Documentation
- Methodology explanation
- Technical glossary
- References (MITRE, ANSSI, CIS Benchmarks)
- Troubleshooting guide
- Rollback procedures

---

## 🚀 Quick Start

### 1️⃣ Read the Report (30 minutes)

```bash
# View complete report
cat report/AUDIT_REPORT_FINAL.md

# Or download PDF for printing
# → report/AUDIT_REPORT_FINAL.pdf
```

### 2️⃣ Understand Key Findings (15 minutes)

- **Section 4** : 10 Critical Findings
- **Section 6** : Real Exploitation (Mimikatz)
- **Section 7** : Lateral Movement Techniques

### 3️⃣ Review Remediation Plan (20 minutes)

**Phase 1 (48 hours):**
- Disable Print Spooler
- Mark admin accounts non-delegable
- Force Kerberos-only (disable NTLM/LM)
- Increase password complexity
- Enable AD audit
- Configure Protected Users group

**Result: 80% of attack surface eliminated**

### 4️⃣ Deploy Remediation (1-2 hours)

```powershell
# Phase 1 (URGENT)
cd scripts
.\remediation-phase1.ps1

# Validate it worked
.\validation.ps1

# Force GPO update
gpupdate /force
```

### 5️⃣ Monitor Kerberos

```powershell
# Verify Kerberos TGT (should show valid ticket)
klist

# Check for NTLM events (should be zero)
Get-EventLog -LogName Security -InstanceId 4776 -After (Get-Date).AddHours(-1)
```

---

## 🔍 The Exploitation Chain

### Step 1: Local Admin Access (1 machine)
- Get access to any Windows machine with admin rights

### Step 2: Extract Credentials (2 minutes)
