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
    @AuraEnabled(Cacheable=true)
    public static Boolean checkUserHasPermissionToWatchVideo(){
        return FeatureManagement.checkPermission(System.label.DISPLAY_VIDEO);
    }
    /*
    @Author - Puneet Gaur
    @Group - Gaur
    @Desciption - Write Permission Set.
    */
    @AuraEnabled(Cacheable=true)
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
    @AuraEnabled
    public static VideoHelperWrapper uploadVideoToS3Bucket(String fileName, String fileType , String fileContent){
        System.debug('fileName='+fileName);
        System.debug('fileType='+fileType);
        System.debug('fileContent='+fileContent);
        VideoHelperWrapper videoHelperResponse = new VideoHelperWrapper();
        HttpRequest reqFileUploadInS3Bucket = new HttpRequest();
        Blob base64Content = EncodingUtil.base64Decode(EncodingUtil.urlDecode(fileContent,'UTF-8'));
        String attachmentBody = fileContent;
        String formattedDateString = DateTime.now().formatGMT('EEE, dd MM yyyy HH:mm:ss z');
        String dateString = DateTime.now().format('ddMMYYYYHHmmss');
        fileName = dateString+'_'+fileName;
        String endPoint='https://salesforcevideo.s3.us-east-2.amazonaws.com/'+fileName;
        try {
            reqFileUploadInS3Bucket.setEndpoint('callout:S3_Bucket_Access/'+fileName);
            reqFileUploadInS3Bucket.setMethod('PUT');
            reqFileUploadInS3Bucket.setHeader('Access-Control-Allow-Origin', '*');
            reqFileUploadInS3Bucket.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
            reqFileUploadInS3Bucket.setHeader('Content-Encoding', 'UTF-8');
            reqFileUploadInS3Bucket.setHeader('Content-type', 'application/x-www-form-urlencoded');
            reqFileUploadInS3Bucket.setHeader('Connection', 'keep-alive');
            reqFileUploadInS3Bucket.setHeader('Date', formattedDateString); 
            reqFileUploadInS3Bucket.setHeader('ACL', 'public-read');
            //store file as blob       
            reqFileUploadInS3Bucket.setBodyAsBlob(base64Content);                       
            Http http = new Http();
            HTTPResponse resFileUploadInS3Bucket = http.send(reqFileUploadInS3Bucket);                
            System.debug(resFileUploadInS3Bucket.getBody());
            if(resFileUploadInS3Bucket.getStatusCode() == 200){
                videoHelperResponse.fileName = fileName;
                videoHelperResponse.fileURL = endPoint;
                videoHelperResponse.isVideoDisplay = true;
            }
            return videoHelperResponse;
        } catch (Exception e) {
            System.debug('Error Message='+e.getMessage());
            //throw new AuraHandledException(e.getMessage());
            return null;
        }
    }
}