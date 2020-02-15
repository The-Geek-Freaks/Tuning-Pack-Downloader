@{
        Root = 'c:\Users\TGF_Tuned\Documents\GitHub\Tuning Pack\TuningPack.ps1'
        OutputPath = 'c:\Users\TGF_Tuned\Documents\GitHub\Tuning Pack\out'
        Package = @{
            Enabled = $true
            Obfuscate = $true
            HideConsoleWindow = $false
            DotNetVersion = 'v4.6.2'
            FileVersion = '1.3.3.7'
            FileDescription = 'Downloader for the TGF Tuning Pack'
            ProductName = 'TGF Tuning Pack Downlader'
            ProductVersion = '1.3.3.7'
            Copyright = 'MinersWin 2020'
            RequireElevation = $true
            ApplicationIconPath = ''
            PackageType = 'Console'
        }
        Bundle = @{
            Enabled = $true
            Modules = $true
            # IgnoredModules = @()
        }
    }
    