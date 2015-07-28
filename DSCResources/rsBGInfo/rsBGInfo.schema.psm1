Configuration rsBGInfo
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,
        
        [System.String]
        $BGInfoSrc = "https://download.sysinternals.com/files/BGInfo.zip",
        
        [System.String]
        $DownloadPath = "C:\rs-pkgs\BGInfo",
        
        [System.String]
        $InstallPath = "C:\Program Files\BgInfo",

        [System.String]
        $ZipFileName = "BGInfo.zip",

        [System.String]
        $ConfSrc = "https://github.com/rsWinAutomationSupport/rsBGInfo/blob/master/Config/bginfo_config_for_DOAS.bgi?raw=true",

        [System.String]
        $ConfFileName = "BGInfo.bgi",

        [System.String]
        $ConfPath = "C:\Program Files\BgInfo"

    )

    
    Script Get_BGInfo 
    {
        GetScript = {
            @{
                Result = (Join-Path -Path $DownloadPath -ChildPath $ZipFileName)
            } 
        }
        SetScript = {
            $OutFile = (Join-Path -Path $DownloadPath -ChildPath $ZipFileName)
            Invoke-WebRequest -Uri $BGInfoSrc -OutFile $OutFile
            Unblock-File -Path $OutFile
        }
        TestScript = { 
            $BGPath = (Join-Path -Path $DownloadPath -ChildPath $ZipFileName)
            Test-Path -Path $BGPath
        }
    }

    Script Get_BGConfig 
    {
        GetScript = {
            @{
                Result = (Join-Path -Path $ConfPath -ChildPath $ConfFileName)
            } 
        }
        SetScript = {
            $OutFile = (Join-Path -Path $ConfPath -ChildPath $ConfFileName)
            Invoke-WebRequest -Uri $ConfSrc -OutFile $OutFile
            Unblock-File -Path $OutFile
        }
        TestScript = { 
            $BGConfPath = (Join-Path -Path $ConfPath -ChildPath $ConfFileName)
            Test-Path -Path $BGConfPath
        }
    }

    Archive UnZip_BGInfo
    {
        Path        = (Join-Path -Path $DownloadPath -ChildPath $ZipFileName)
        Destination = "$InstallPath"
        Force       = $True
        Ensure      = $Ensure
        DependsOn   = "[Script]Get_BGInfo"
    }

    Registry Reg_BGInfo
    {
        Key         = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
        ValueType   = "String"
        ValueName   = "bginfo"
        ValueData   = "`"$InstallPath\bginfo.exe`" `""+(Join-Path -Path $ConfPath -ChildPath $ConfFileName)+"`" /silent /accepteula /timer:0"
        Force       = $true
        Ensure      = $Ensure
        DependsOn   = @("[Archive]UnZip_BGInfo","[Script]Get_BGConfig")
    }

}
