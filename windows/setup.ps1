# Setup file for windows - by phucho0237
# Last edit: 2023-12-12 12:00

# Chocolatey setup
Write-Host("Installing Chocolatey...")
if (Get-Command -Name choco -ErrorAction SilentlyContinue) 
{
   Write-Host("Chocolatey is already installed. Skipping...")
}
else {
   Set-ExecutionPolicy AllSigned
   [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
   iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
