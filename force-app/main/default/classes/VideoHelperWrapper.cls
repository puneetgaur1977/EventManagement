/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 01-03-2021
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   01-03-2021   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class VideoHelperWrapper {
    private String fileNameVal;
    private String fileURLVal;
    private Boolean isVideoDisplayVal;
    @AuraEnabled
    public String fileName{
        get{
            return fileNameVal;
        }
        set{
            fileNameVal = value;
        }
    }
    @AuraEnabled
    public String fileURL{
        get{
            return fileURLVal;
        }
        set{
            fileURLVal = value;
        }
    }
    @AuraEnabled
    public Boolean isVideoDisplay{
        get{
            return isVideoDisplayVal;
        }
        set{
            isVideoDisplayVal = value;
        }
    }
}
