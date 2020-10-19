/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-18-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger AccountTrigger on Account (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
    //TriggerExecution.run(new AccountTriggerHandler(),'Account');
}