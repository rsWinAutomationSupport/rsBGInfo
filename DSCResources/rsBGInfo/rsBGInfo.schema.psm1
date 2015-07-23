Configuration rsBGInfo
{
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,
        
        [System.String]
        $BGInfoSource = "https://download.sysinternals.com/files/BGInfo.zip",
        
        [System.String]
        $DownloadPath = "C:\rs-pkgs\BGInfo",
        
        [System.String]
        $InstallPath = "C:\Program Files\BgInfo",

        [System.String]
        $FileName = "BGInfo.zip",

        [parameter(Mandatory = $true)]
        [System.String]
        $BGConfigPath

    )

    
    Script Get_BGInfo 
    {
        GetScript = {
            @{
                Result = (Join-Path -Path $DownloadPath -ChildPath $FileName)
            } 
        }
        SetScript = {
            $OutFile = (Join-Path -Path $DownloadPath -ChildPath $FileName)
            Invoke-WebRequest -Uri $BGInfoSource -OutFile $OutFile
            Unblock-File -Path $OutFile
        }
        TestScript = { 
            $BGPath = (Join-Path -Path $DownloadPath -ChildPath $FileName)
            Test-Path -Path $BGPath
        }
    }

    Archive UnZip_BGInfo
    {
        Path                = (Join-Path -Path $DownloadPath -ChildPath $FileName)
        Destination         = "$InstallPath"
        Force               = $True
        Ensure              = $Ensure
        DependsOn           = "[Script]Get_BGInfo"
    }

    Registry Reg_BGInfo
    {
        Key                 = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
        ValueType           = "String"
        ValueName           = "bginfo"
        ValueData           = "`"$InstallPath\bginfo.exe`" `"$BGConfigPath`" /silent /accepteula /timer:0"
        Force               = $true
        Ensure              = $Ensure
        DependsOn           = "[Archive]UnZip_BGInfo"
    }

}
