/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-11-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class AccountTriggerHandler implements TriggerInterface{
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    public void beforeInsert(List<sObject> newRecordList){
        for(Account acc : (List<Account>)newRecordList){
            acc.Name = 'Trigger Framework ' + acc.Name;
        }
    }
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    public void afterInsert(List<sObject> newRecordList,Map<Id,sObject> newRecordMap){

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
