# rsBGInfo
The rsBGInfo composite DSC resource module to deploy [BGInfo utility](https://technet.microsoft.com/en-us/library/bb897557.aspx) and accompanying default configuration stored within the 'Config' folder of this repository.

### Parameters
 * **Ensure**: Enable/disable BGInfo. Default "Present"
 * **BGInfoSrc**: Source URI for BGInfo.zip file. Default: https://download.sysinternals.com/files/BGInfo.zip
 * **DownloadPath**: Location, where to store the downloaded zip file. Default: "C:\rs-pkgs\BGInfo"
 * **InstallPath**: BGInfo utility installation path. Default: "C:\Program Files\BgInfo"
 * **ZipFileName**: Archive file name to use locally. Default: "BGInfo.zip"
 * **ConfSrc**: Source URI for BGInfo configuration file to deploy for the utility. Default: https://github.com/rsWinAutomationSupport/rsBGInfo/blob/master/Config/bginfo_config_for_DOAS.bgi?raw=true
 * **ConfFileName**: File name to use locally for BGInfo configuration file. Default: "BGInfo.bgi"
 * **ConfPath**: Path to the folder that contains the configuration file to use at BGInfo start-up. Default: "C:\Program Files\BgInfo"

## Versions

### 1.0.0
 *  Initial release


## Examples
Deploy BGInfo with default configuration:


    Configuration Sample_default_BGInfo
    {
    	param
    	(
    		[string[]]$NodeName = 'localhost'
    	)
    	Import-DscResource -Module rsBGInfo 
    	Node $NodeName
    	{
    		rsBGInfo DeployBGInfo
    		{
    			Ensure       = "Present"
    		}
    	}
    }

Deploy BGInfo with custom configuration file in an alternate location: 

    Configuration Custom_confFile_BGInfo
    {
    	param
    	(
    		[string[]]$NodeName = 'localhost'
    	)
    	Import-DscResource -Module rsBGInfo 
    	Node $NodeName
    	{
    		rsBGInfo DeployCustomBGInfo
    		{
    			Ensure       = "Present"
				ConfSrc      = "http://some=other/location/my_config.bgi"
				ConfPath     = "C:\Program Files\BgInfo"
    		}
    	}
    }