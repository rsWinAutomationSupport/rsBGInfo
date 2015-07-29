# rsBGInfo
The rsBGInfo composite DSC resource module can be used to deploy [BGInfo utility](https://technet.microsoft.com/en-us/library/bb897557.aspx) and accompanying configuration (.bgi) file. Only the Ensure parameter is mandatory. All other parameters come with default values, but can be overridden to suit most use-cases. 

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
	 *  Download and deployment of BGInfo utility from a URL
	 *  Download and deployment of BGInfo utility configuration file form a URL


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
				ConfSrc      = "http://some_other/location/my_config.bgi"
				ConfPath     = "C:\Program Files\BgInfo"
    		}
    	}
    }