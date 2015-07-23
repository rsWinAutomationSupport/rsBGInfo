# rsBGInfo
The rsBGInfo composite DSC resource module to deploy [BGInfo utility](https://technet.microsoft.com/en-us/library/bb897557.aspx) and accompanying configuration.

Please note that this module has a dependency on rsFileDownload

## Versions

### 1.0.0
 *  Initial release


## Examples

    Configuration Sample_BGInfo
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
    			BGConfigPath = "c:\resources\BGInfo_Config.bgi"
    		}
    	}
    }

