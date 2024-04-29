# Request Administrators Permission
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
}

# Create Temporary Folder At %temp%
$tempFolder = Join-Path -Path $env:TEMP -ChildPath "infrastructure"
if (-not (Test-Path -Path $tempFolder)) {
    New-Item -Path $tempFolder -ItemType Directory  | Out-Null
        
    Write-Host `[INIT] Created a new folder at $tempFolder`
} else {
    Write-Host `[INIT] Folder existed at $tempFolder`
}

# Check If Chocolatey Is Installed Or Not
$chocoFolder = Join-Path -Path C:\ProgramData -ChildPath "chocolatey"

if (Test-Path -Path $chocoFolder) {
    Write-Host "[INIT] Chocolatey was installed in this system. Skipping..."
}
else {
    # Install Chocolatey
    Write-Host "[INIT] Chocolatey not detected, installing..."

    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    Write-Host "[INIT] Chocolatey installation completed"
}

# Package Install
Write-Host "[PKG] Started package install..."

## DirectX
$pkgFolder = Join-Path -Path $tempFolder -ChildPath "pkg"
if (-not (Test-Path -Path $pkgFolder)) {
    New-Item -Path $pkgFolder -ItemType Directory | Out-Null
}

Write-Host "[PKG] Installing DirectX..."

$dxDownloadPath = Join-Path -Path $pkgFolder -ChildPath "dxwebsetup.exe"

if (-not (Test-Path -Path $dxDownloadPath)) {
    $directxUrl = "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe"
    Invoke-Webrequest -Uri $directxUrl -OutFile $dxDownloadPath
}

# Wait 3 seconds
Start-Sleep -Seconds 3

Start-Process -FilePath $dxDownloadPath -Wait

Pause
