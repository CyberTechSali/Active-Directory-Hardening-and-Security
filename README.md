# Active-Directory-Hardening-and-Security

# Active Directory Hardening and Security

A production-ready framework for comprehensive Active Directory security 
assessment, vulnerability demonstration, and hardening implementation.

## 📊 Project Overview

This repository documents a complete three-phase security audit of an Active 
Directory environment (cybertechsali.com lab), demonstrating real-world attack 
scenarios and proven remediation strategies.

### Phase 1: Passive Assessment
- **PingCastle v3.2.1**: Configuration audit → 55/100 risk score
- **Purple Knight v2.1**: ANSSI/CIS compliance mapping
- **17 Indicators of Exposure** identified

### Phase 2: Active Reconnaissance  
- **BloodHound v4.3.1**: Attack path cartography
- **7+ paths to Domain Admin** discovered
- **12 delegable accounts** (Kerberos delegation risk)

### Phase 3: Controlled Exploitation
- **Mimikatz v2.2.0**: Credential extraction (plaintext + NTLM + Kerberos)
- **Pass-the-Ticket**: Lateral movement via Kerberos ticket injection
- **Pass-the-Hash**: Administrator shell acquisition
- **DCSync**: Complete domain secrets extraction
- **Complete domain compromise in < 5 minutes**

### Phase 4: Remediation & Validation
- **Hardening GPO**: NTLM/LM restriction, Kerberos enforcement
- **Protected Users**: Admin account protection
- **SIEM Integration**: Event 4768/4769 monitoring
- **Proof of Remediation**: Before/after validation

## 🎯 Key Findings

| Metric | Value |
|---|---|
| Initial Risk Score | 55/100 (HIGH) |
| Critical Findings | 10 |
| High Findings | 7 |
| Attack Paths to DA | 7+ |
| Compromise Time | < 5 minutes |
| Detection Rate | 0 alerts |

## 📁 Repository Structure
