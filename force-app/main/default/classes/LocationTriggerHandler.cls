/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 10-18-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   10-18-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class LocationTriggerHandler implements TriggerInterface{
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    public void beforeInsert(List<sObject> newRecordList){
        
    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    public void afterInsert(List<sObject> newRecordList,Map<Id,sObject> newRecordMap){
        //EventAttendeeHelper.sendConfirmationEmail(newRecordList,(Map<Id,Event_Attendee__c>)newRecordMap);
        Map<Id,Location__c> locationMap = (Map<Id,Location__c>)newRecordMap;
        LocationTriggerHelper.validateLocationAddress(locationMap.keyset());
    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList) , Map<Id,sObject> newRecordMap
    */
    public void beforeInsert(List<sObject> newRecordList, Map<Id,sObject> newRecordMap){

    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap
    */
    public void beforeUpdate(Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap){
        
    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap
    */
    public void afterUpdate(Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap){

    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> oldRecordList,Map<Id,sObject> oldRecordMap
    */
    public void beforeDelete(List<sObject> oldRecordList,Map<Id,sObject> oldRecordMap){

    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap
    */
    public void afterDelete(Map<Id,sObject> oldRecordMap){

    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap
    */
    public void afterUndelete(List<sObject> newRecordList, Map<Id,sObject> newRecordMap){

    }

}