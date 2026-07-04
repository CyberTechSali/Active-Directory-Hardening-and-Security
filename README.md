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
├── Assessment/          PingCastle & Purple Knight reports
├── Reconnaissance/      BloodHound analysis & attack paths
├── Exploitation/        Mimikatz demonstrations & MITRE mapping
├── Remediation/         GPO configs, scripts, validation
├── Screenshots/         Evidence of each phase
└── Docs/               Technical references & glossary

## 🔐 Use Cases

✅ Penetration Testing Reference  
✅ Active Directory Hardening Guide  
✅ Security Training & Education  
✅ Compliance Assessment (ANSSI/CIS/ISO 27001)  
✅ Red Team Strategy Development  
✅ Blue Team Detection Improvement  

## ⚠️ Disclaimer

**Lab environment only.** This assessment was conducted on a controlled, 
intentionally-weakened Active Directory domain for educational and 
professional purposes. All demonstrated techniques are for authorized 
security testing only.

## 📚 Documentation

- **Main Report**: AD_Security_Audit_and_Remediation_Report.md
- **Attack Paths**: Comprehensive MITRE ATT&CK mapping
- **Remediation Guide**: Step-by-step hardening with validation
- **Technical References**: LSASS modules, Kerberos delegation, etc.

## 🛠️ Tools & Versions

- PingCastle 3.2.1
- Purple Knight 2.1
- BloodHound 4.3.1
- SharpHound 1.1.1
- Mimikatz 2.2.0

## 📊 Compliance Mapping

✅ ANSSI Recommendations (AD Hardening)  
✅ CIS Benchmarks v1.3.1 (Windows Server 2019)  
✅ NIST Cybersecurity Framework  
✅ ISO 27001 Controls (A.9, A.10)  
✅ MITRE ATT&CK Framework  

## 📖 How to Use This Repository

1. **Review the main report** for complete context
2. **Study attack paths** to understand exploitation chain
3. **Implement remediation** following the hardening guide
4. **Validate fixes** using before/after screenshots
5. **Adapt to your environment** using provided templates

## 👤 Author

[Your Name]  
Security Researcher | Penetration Tester | Active Directory Specialist  
Date: November-December 2025

## 📞 Contact & Questions

For questions or collaboration: [email/contact]

## 📄 License

[Choose: MIT / GPL-3.0 / CC-BY-4.0 / Proprietary]

---

*This project demonstrates real-world security challenges and practical 
solutions. Use responsibly and ethically.*
