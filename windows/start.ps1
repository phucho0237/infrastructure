$githubScriptUrl = "https://raw.githubusercontent.com/phucho0237/infrastructure/main/windows/setup.ps1"

$scriptContent = Invoke-RestMethod -Uri $githubScriptUrl

$scriptPath = "$env:TEMP\Setup.ps1"
$scriptContent | Out-File -FilePath $scriptPath -Encoding UTF8

Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
