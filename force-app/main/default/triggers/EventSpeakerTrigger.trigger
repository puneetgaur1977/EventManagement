/**
 * @description       : 
 * @author            : Puneet Gaur
 * @group             : 
 * @last modified on  : 10-11-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   10-11-2020   gaur.puneet@outlook.com   Initial Version
**/
trigger EventSpeakerTrigger on Event_Speaker__c (before insert,after insert,before update,after update,before delete,after delete,after undelete){
    TriggerExecution.run(new EventSpeakerTriggerHandler(),'Event_Speaker__c');
}