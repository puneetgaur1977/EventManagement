/**
 * @description       : Triiger Interface
 * @author            : Puneet Gaur
 * @group             : puneetgaur.in
 * @last modified on  : 09-24-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log  : Puneet Gaur
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   gaur.puneet@outlook.com              Initial Version
**/
public Interface TriggerInterface {
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    void beforeInsert(List<sObject> newRecordList);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList
    */
    void afterInsert(List<sObject> newRecordList,Map<Id,sObject> newRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> newRecordList) , Map<Id,sObject> newRecordMap
    */
    void beforeInsert(List<sObject> newRecordList, Map<Id,sObject> newRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap
    */
    void beforeUpdate(Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap
    */
    void afterUpdate(Map<Id,sObject> oldRecordMap,Map<Id,sObject> newRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : List<sObject> oldRecordList,Map<Id,sObject> oldRecordMap
    */
    void beforeDelete(List<sObject> oldRecordList,Map<Id,sObject> oldRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap
    */
    void afterDelete(Map<Id,sObject> oldRecordMap);
    /*
    @Author : Puneet Gaur
    @Description: Calling by Trigger Handler Framework
    @CreatedDate: 09-24-2020
    @Param : Map<Id,sObject> oldRecordMap
    */
    void afterUndelete(List<sObject> newRecordList, Map<Id,sObject> newRecordMap);
}