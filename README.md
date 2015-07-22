# rsBGInfo
DSC Composite Resource module to deploy BGInfo on to managed nodes

### Example

    Node localhost
    {
    	rsBGInfo DeployBGInfo
    	{
    		Ensure = "Present"
    	}
    }

