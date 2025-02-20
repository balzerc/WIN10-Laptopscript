#Laptop script to automatically install the teams bootstrapper and lenovo system update to lenovo laptops.
#Please sign into laptop as admin, copy script to downloads folder, and navigate to Downloads folder inside of powershell (run as admin)
#Additionally, run: set-executionpolicy bypass
#Created by Cole Balzer
#2025-01-22


#Installing teams bootstrapper

#Define teams boostrapper url
$teamsBootstrapperUrl = "https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409"

#Define destination path of download for teams
$destinationPath = "$env:USERPROFILE\Downloads\teamsbootstrapper.exe"

#Download Teams bootstrapper
Invoke-WebRequest -Uri $teamsBootstrapperUrl -OutFile $destinationPath

& $destinationPath -p

# Check if Teams has installed successfully
$teamsPath = "C:\Program Files\WindowsApps\MSTeams_*_x64__8wekyb3d8bbwe"
if (Test-Path -Path $teamsPath) {
    Write-Output "Teams has installed successfully"
} else {
    Write-Output "Teams install has failed"
}

# Installing Lenovo System Update for firmware and BIOS updates
# This pulls the system update application from the web to the user's download location and installs it silently

# Define the download URL and the output file path
$downloadUrl = "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.08.03.59.exe"
$outputFile = "$env:USERPROFILE\Downloads\systemupdate.exe"

Start-Sleep -seconds 10
# Download the installer
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile

# Run the installer silently
& $outputFile /verysilent

#wait for install
Start-Sleep -Seconds 10

#open lenovo system update
Start-Process "C:\Program Files (x86)\Lenovo\System Update\tvsu.exe"

#delete system update installer file and teams installer file
Remove-Item -Path $outputFile -Force
Remove-item -Path $destinationPath -Force