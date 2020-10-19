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
trigger LocationValidationTrigger on Location__c (before insert,after insert,before update,after update,before delete,after delete,after undelete)  {
    //LocationTriggerHandler
    TriggerExecution.run(new LocationTriggerHandler(),'Location__c');
}