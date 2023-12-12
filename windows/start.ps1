$githubScriptUrl = "https://raw.githubusercontent.com/phucho0237/infrastructure/main/windows/setup.ps1"

$scriptContent = Invoke-RestMethod -Uri $githubScriptUrl

Invoke-Expression -Command $scriptContent
