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
    "Internetverbindung: Online"
} else {
    "Internetverbindung: Offline"
}
##########################################################################################################################################################################

$Gedownloaded = Test-Path .\TuningPack\
if ($Gedownloaded){
    Write-Output "Das Tuning Pack wurde bereits heruntergeladen"
} else {
    if ($Internet){
        Write-Output "Das Tuning Pack muss heruntergeladen werden"
    } else {
        Write-Output "Das Tuning Pack ist nicht Installiert, jedoch besteht keine Internetverbindung. Das Programm wird beendet."
    }
}

if ($Internet){
    $NeusteVersion = $Downloadlink = curl http://root3.minerswin.de/TGF/TuningPack/LatestVersion.html -UseBasicParsing
    Write-Output "Neuste Version: $($NeusteVersion.Content)"
    if ($Gedownloaded){
        Set-Location .\TuningPack\
        Start-Process powershell .\GUI.ps1
    } else {
        $Downloadlink = curl http://root3.minerswin.de/TGF/TuningPack/DownloadLink.html -UseBasicParsing
        Write-Output "Der Download wird gestartet"
        wget $Downloadlink.Content -OutFile 'TuningPack.zip' -UseBasicParsing
        Write-Output "Der Download wurde abgeschlossen"
        Expand-Archive .\TuningPack.zip -DestinationPath .\TuningPack\
        rm TuningPack.zip
        Set-Location .\TuningPack\
        Write-Output "Das Tuning Pack wird gestartet"
        Start-Process powershell .\GUI.ps1
    }
} else {
    if ($Gedownloaded){
        Set-Location .\TuningPack\
        Start-Process powershell .\GUI.ps1
    }
}
