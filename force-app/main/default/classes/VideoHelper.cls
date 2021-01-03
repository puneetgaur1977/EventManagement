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
public with sharing class VideoHelper {
    /*
    @Author - Puneet Gaur
    @Group - Gaur
    @Desciption - Read Permission Set.
    */
    @AuraEnabled
    public static Boolean checkUserHasPermissionToWatchVideo(){
        return FeatureManagement.checkPermission(System.label.DISPLAY_VIDEO);
    }
    /*
    @Author - Puneet Gaur
    @Group - Gaur
    @Desciption - Write Permission Set.
    */
    @AuraEnabled
    public static Boolean checkUserHasPermissionToUploadVideo(){
        return checkUserHasPermissionToWatchVideo() && FeatureManagement.checkPermission(System.label.UPLOAD_VIDEO);
    }
    /*
    @Author - Puneet Gaur
    @Group - Gaur
    @Desciption - Write Permission Set.
    */
    @AuraEnabled(Cacheable=true)
    public static Upload_Video__c getUploadedVideoRecord(){
        List<Upload_Video__c> uploadVideoList = null;
        if(checkUserHasPermissionToWatchVideo()){
            uploadVideoList = [
                SELECT
                    Id,
                    File_Name__c,
                    File_URL__c,
                    Is_Visible__c
                FROM
                    Upload_Video__c
                    WITH SECURITY_ENFORCED
                ORDER BY 
                    LastModifiedDate DESC
                LIMIT 1
            ];
            if(uploadVideoList != null && !uploadVideoList.isEmpty()){
                return uploadVideoList[0];
            }    
        }
        return null;
    }
}