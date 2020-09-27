/**
 * @description       : 
 * @author            : Puneet Gaur
 * @group             : 
 * @last modified on  : 09-24-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class TriggerExecution {
    public
    static void run(TriggerInterface handler, String objectName){
        Trigger_Setting__c triggerSettingRecord = getTriggerSetting(objectName);
        //if(triggerSettingRecord == null){
        //    triggerSettingRecord = getTriggerBlankSetting(objectName);
        //}
        execute(handler,triggerSettingRecord);
    }
    private
    static void execute(TriggerInterface handler,Trigger_Setting__c triggerSettingRecord){
        
        if(triggerSettingRecord !=null && triggerSettingRecord.Disabled__c){
            return;
        }
        if(Trigger.isBefore){
            if(Trigger.isInsert && (triggerSettingRecord !=null || !triggerSettingRecord.Before_Insert__c)){
                handler.beforeInsert(Trigger.new);
            }
            if(Trigger.isUpdate && (triggerSettingRecord !=null || !triggerSettingRecord.Before_Update__c)){
                handler.beforeUpdate(Trigger.newMap,Trigger.oldMap);
            }
            if(Trigger.isDelete && (triggerSettingRecord !=null || !triggerSettingRecord.Before_Delete__c)){
                handler.beforeDelete(Trigger.old,Trigger.oldMap);
            }
        }
        if(Trigger.isAfter){
            if(Trigger.isInsert && (triggerSettingRecord !=null || !triggerSettingRecord.After_Insert__c)){
                handler.afterInsert(Trigger.new, Trigger.newMap);
            }
            if(Trigger.isUpdate && (triggerSettingRecord !=null || !triggerSettingRecord.After_Update__c)){
                handler.afterUpdate(Trigger.newMap,Trigger.oldMap);
            }
            if(Trigger.isDelete && (triggerSettingRecord !=null || !triggerSettingRecord.After_Delete__c)){
                handler.afterDelete(Trigger.oldMap);
            }
            if(Trigger.isDelete && (triggerSettingRecord !=null || !triggerSettingRecord.After_Undelete__c)){
                handler.afterUnDelete(Trigger.new, Trigger.newMap);
            }
        }

    }
    private
    static Trigger_Setting__c getTriggerSetting(String objectName){
        try{
        return[
            SELECT
                After_Delete__c,
                After_Insert__c,
                After_Undelete__c,
                After_Update__c,
                Before_Delete__c,
                Before_Insert__c,
                Before_Update__c,
                Disabled__c,
                Object_Name__c
            FROM
                Trigger_Setting__c
            WHERE
                Object_Name__c = :objectName
        ];
        }catch(Exception ex){
            return getTriggerBlankSetting(objectName);
        }
        //return null;
    }
    private
    static Trigger_Setting__c getTriggerBlankSetting(String objectName){
        Trigger_Setting__c triggerSettingBlankRecordBuild = new Trigger_Setting__c();
        triggerSettingBlankRecordBuild.Object_Name__c = objectName;
        return triggerSettingBlankRecordBuild;
    }

}
