Set-ExecutionPolicy Unrestricted -Scope Process

#Tuning Pack Downloader
############################################################################################################################################################################################################
while (!(test-connection 8.8.8.8 -Count 1 -Quiet)) {
    $Verbindungbesteht = $true
    break
}
if ($Verbindungbesteht){
    $Internet = $false
} else {
    $Internet = $true
}
if ($Internet){
    "$(Get-Date) Internetverbindung: Online"
} else {
    "$(Get-Date) Internetverbindung: Offline"
}
##########################################################################################################################################################################

$Gedownloaded = Test-Path .\TuningPack\
if ($Gedownloaded){
    Write-Output "$(Get-Date) Das Tuning Pack wurde bereits heruntergeladen"
} else {
    if ($Internet){
        Write-Output "$(Get-Date) Das Tuning Pack muss heruntergeladen werden"
    } else {
        Write-Output "$(Get-Date) Das Tuning Pack ist nicht Installiert, jedoch besteht keine Internetverbindung. Das Programm wird beendet."
    }
}

if ($Internet){
    $NeusteVersion = Invoke-WebRequest http://root3.minerswin.de/TGF/TuningPack/LatestVersion.html -UseBasicParsing
    Write-Output "$(Get-Date) Neuste Version: $($NeusteVersion)"
    if ($Gedownloaded){
        $VersionInstalliert = Get-Content .\TuningPack\Version.txt
        if ($NeusteVersion.Content -gt $VersionInstalliert){
            Write-Output "$(Get-Date) Die aktuelle Version wird nicht mehr Unterstüzt. Die neuste wird heruntergeladen."
            Write-Output "$(Get-Date) Tuning Pack wurde beendet"
            del .\TuningPack -Recurse -Force
            Write-Output "$(Get-Date) Tuning Pack wurde gelöscht"
            $Downloadlink = curl http://root3.minerswin.de/TGF/TuningPack/DownloadLink.html -UseBasicParsing
            Write-Output "$(Get-Date) Der Download wird gestartet"
            wget $Downloadlink.Content -OutFile 'TuningPack.zip' -UseBasicParsing
            Write-Output "$(Get-Date) Der Download wurde abgeschlossen"
            Expand-Archive .\TuningPack.zip -DestinationPath .\TuningPack\
            rm TuningPack.zip
            Set-Location .\TuningPack\
            Write-Output "$(Get-Date) Das Tuning Pack wird gestartet"
            $NeusteVersion.Content | Out-File -FilePath .\Version.txt
            Start-Process powershell .\GUI.ps1
        } else {
            Set-Location .\TuningPack\
            Start-Process powershell .\GUI.ps1
        }
    } else {
        $Downloadlink = curl http://root3.minerswin.de/TGF/TuningPack/DownloadLink.html -UseBasicParsing
        Write-Output "$(Get-Date) Der Download wird gestartet"
        wget $Downloadlink.Content -OutFile 'TuningPack.zip' -UseBasicParsing
        Write-Output "$(Get-Date) Der Download wurde abgeschlossen"
        Expand-Archive .\TuningPack.zip -DestinationPath .\TuningPack\
        rm TuningPack.zip
        Set-Location .\TuningPack\
        Write-Output "$(Get-Date) Das Tuning Pack wird gestartet"
        $NeusteVersion.Content | Out-File -FilePath .\Version.txt
        Start-Process powershell .\GUI.ps1
    }
} else {
    if ($Gedownloaded){
        Set-Location .\TuningPack\
        Start-Process powershell .\GUI.ps1
    }
}