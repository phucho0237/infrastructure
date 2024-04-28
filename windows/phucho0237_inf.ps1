# Request Administrators Permission
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
}

# Create Temporary Folder At %temp%
$tempFolder = Join-Path -Path $env:TEMP -ChildPath "infrastructure"
if (-not (Test-Path -Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder | Out-Null    
    Write-Host `[INIT] Created a new folder at $tempFolder`
} else {
    Write-Host `[INIT] Folder existed at $tempFolder`
}

# Check if chocolatey is installed or not
$chocoFolder = Join-Path -Path C:\ProgramData -ChildPath "chocolatey"

if (Test-Path -Path $chocoFolder) {
    Write-Host `[PKG] Chocolatey was installed in this system. Skipping...
}
else {
    # Install chocolatey
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "[PKG] Chocolatey installation completed."
}

Pause
