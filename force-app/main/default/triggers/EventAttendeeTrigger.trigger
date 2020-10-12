/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-11-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   10-11-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger EventAttendeeTrigger on Event_Attendee__c (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
    System.debug('Hello');
    TriggerExecution.run(new EventAttendeeTriggerHandler(),'Event_Attendee__c');
}