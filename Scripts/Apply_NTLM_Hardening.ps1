
<#
.SYNOPSIS
    Applies NTLM/LM hardening policies via a dedicated GPO.
.DESCRIPTION
    This script creates a new GPO named 'GPO-Security-Authentication', configures 
    'LAN Manager Authentication Level' to "Send NTLMv2 response only. Refuse LM", 
    and disables LM hash storage. It then links the GPO to the domain.
    Run this script on a Domain Controller with Group Policy Management installed.
.NOTES
    Author: OUCHAHEd SALMA
    Date:   July 2026
    Version: 1.0
    Prerequisites: Group Policy Management Console (GPMC) feature must be installed.
#>

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator. Please restart PowerShell as Administrator."
    exit 1
}

# Import the GroupPolicy module if available
try {
    Import-Module GroupPolicy -ErrorAction Stop
    Write-Host "[INFO] GroupPolicy module loaded successfully." -ForegroundColor Cyan
} catch {
    Write-Host "[ERROR] GroupPolicy module not found. Ensure GPMC is installed (Server Manager -> Add Roles and Features -> Group Policy Management)." -ForegroundColor Red
    exit 1
}

# Variables
$GPOName = "GPO-Security-Authentication"
$Domain = (Get-ADDomain).DNSRoot

Write-Host "[INFO] Target Domain: $Domain" -ForegroundColor Cyan

# --- Step 1: Create the GPO if it doesn't exist ---
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    Write-Host "[INFO] Creating new GPO: $GPOName ..." -ForegroundColor Yellow
    New-GPO -Name $GPOName -Comment "Hardening policies for NTLM/Kerberos authentication" | Out-Null
    $GPO = Get-GPO -Name $GPOName
    Write-Host "[SUCCESS] GPO '$GPOName' created (ID: $($GPO.Id))." -ForegroundColor Green
} else {
    Write-Host "[INFO] GPO '$GPOName' already exists. Applying settings to existing GPO." -ForegroundColor Yellow
}

# --- Step 2: Configure LAN Manager Authentication Level ---
# Policy Path: Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options
# Registry Value: LmCompatibilityLevel = 5 (Send NTLMv2 response only. Refuse LM & NTLMv1)

Write-Host "[INFO] Configuring 'LAN Manager authentication level' to 'Send NTLMv2 response only. Refuse LM'..." -ForegroundColor Yellow
try {
    Set-GPRegistryValue -Name $GPOName -Key "HKLM\System\CurrentControlSet\Control\Lsa" -ValueName "LmCompatibilityLevel" -Type DWord -Value 5 -ErrorAction Stop
    Write-Host "[SUCCESS] LmCompatibilityLevel set to 5." -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to set LmCompatibilityLevel: $_" -ForegroundColor Red
}

# --- Step 3: Disable LM Hash Storage ---
# Policy Path: Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options
# Registry Value: NoLMHash = 1 (Do not store LAN Manager hash value on next password change)

Write-Host "[INFO] Disabling LM hash storage (NoLMHash = 1)..." -ForegroundColor Yellow
try {
    Set-GPRegistryValue -Name $GPOName -Key "HKLM\System\CurrentControlSet\Control\Lsa" -ValueName "NoLMHash" -Type DWord -Value 1 -ErrorAction Stop
    Write-Host "[SUCCESS] NoLMHash set to 1." -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to set NoLMHash: $_" -ForegroundColor Red
}

# --- Step 4: Disable NTLMv1 (Restrict NTLM: Incoming NTLM Traffic) - Additional safety ---
Write-Host "[INFO] Configuring 'Restrict NTLM: Incoming NTLM traffic' to 'Deny all accounts' (optional hardening)..." -ForegroundColor Yellow
# Note: This is an extra security measure. Set to 'Deny all accounts' (Value 2)
# Note: Be cautious with this setting as it might break legacy applications.
try {
    Set-GPRegistryValue -Name $GPOName -Key "HKLM\System\CurrentControlSet\Control\Lsa" -ValueName "RestrictSendingNTLMTraffic" -Type DWord -Value 2 -ErrorAction SilentlyContinue
    Write-Host "[SUCCESS] RestrictSendingNTLMTraffic set." -ForegroundColor Green
} catch {
    Write-Host "[WARNING] Could not set RestrictSendingNTLMTraffic (may not exist on older OS versions)." -ForegroundColor Yellow
}

# --- Step 5: Link the GPO to the Domain Root ---
Write-Host "[INFO] Linking GPO to the domain root ($Domain)..." -ForegroundColor Yellow
try {
    # Check if GPO is already linked
    $ExistingLink = Get-GPO -Name $GPOName | Get-GPPermission -TargetName $Domain -TargetType Domain | Select-Object -ErrorAction SilentlyContinue
    
    # Force link (refresh)
    New-GPLink -Name $GPOName -Target "dc=$($Domain.Replace('.', ',dc='))" -LinkEnabled Yes -ErrorAction Stop
    Write-Host "[SUCCESS] GPO linked to the domain." -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to link GPO: $_" -ForegroundColor Red
}

# --- Step 6: Force Group Policy Update (Optional) ---
Write-Host "[INFO] Forcing Group Policy update on the local DC..." -ForegroundColor Yellow
try {
    gpupdate /force /target:computer | Out-Null
    Write-Host "[SUCCESS] Group Policy updated successfully." -ForegroundColor Green
} catch {
    Write-Host "[WARNING] Could not force gpupdate. A reboot might be required or run manually." -ForegroundColor Yellow
}

# --- Final Summary ---
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "           NTLM HARDENING COMPLETED" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "✅ GPO Name          : $GPOName" -ForegroundColor White
Write-Host "✅ Target Domain     : $Domain" -ForegroundColor White
Write-Host "✅ LM Compatibility  : 5 (Refuse LM & NTLMv1)" -ForegroundColor White
Write-Host "✅ NoLMHash          : Enabled (LM hashes will not be stored)" -ForegroundColor White
Write-Host "✅ Restrict NTLM     : Deny all incoming NTLM (optional)" -ForegroundColor White
Write-Host ""
Write-Host "[INFO] Next Steps: Verify with 'klist' (AES-256 tickets) and check Event IDs 4768/4769." -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
