
<#
.SYNOPSIS
    Disables the Print Spooler service on a Domain Controller.
.DESCRIPTION
    This script stops and disables the Print Spooler service to mitigate 
    NTLM relay attacks (e.g., PetitPotam, PrintNightmare).
    Run this script with administrative privileges on the Domain Controller.
.NOTES
    Author: OUCHAHEd SALMA
    Date:   July 2026
    Version: 1.0
#>

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator. Please restart PowerShell as Administrator."
    exit 1
}

Write-Host "[INFO] Disabling Print Spooler service..." -ForegroundColor Cyan

try {
    # Check if the service exists
    $service = Get-Service -Name Spooler -ErrorAction SilentlyContinue

    if (-not $service) {
        Write-Host "[WARNING] Print Spooler service not found. It may already be uninstalled." -ForegroundColor Yellow
        exit 0
    }

    # Stop the service if it is running
    if ($service.Status -eq 'Running') {
        Write-Host "[INFO] Stopping Spooler service..." -ForegroundColor Yellow
        Stop-Service -Name Spooler -Force -ErrorAction Stop
        Write-Host "[SUCCESS] Service stopped." -ForegroundColor Green
    } else {
        Write-Host "[INFO] Service is already stopped (Status: $($service.Status))." -ForegroundColor Green
    }

    # Disable the service startup type
    Write-Host "[INFO] Setting startup type to 'Disabled'..." -ForegroundColor Yellow
    Set-Service -Name Spooler -StartupType Disabled -ErrorAction Stop

    # Verify the change
    $updatedService = Get-Service -Name Spooler
    Write-Host "[SUCCESS] Print Spooler service is now set to '$($updatedService.StartupType)'." -ForegroundColor Green
    Write-Host "[INFO] Remediation completed. The server is now protected against Spooler-based NTLM relay attacks." -ForegroundColor Cyan

} catch {
    Write-Host "[ERROR] An error occurred: $_" -ForegroundColor Red
    exit 1
}
