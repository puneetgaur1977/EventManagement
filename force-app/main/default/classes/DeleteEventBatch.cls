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
global class DeleteEventBatch implements Database.Batchable<sObject>, Database.stateful {
    Integer deletedEvenetCount = 0;
    global Database.queryLocator start(Database.BatchableContext batchContext){
        String eventQuery = 'Select Id,Name,Live__c ,End_Date_Time__c from Event__c Where Live__c = true and End_Date_Time__c < LAST_N_MONTHS:2';
        return Database.getQueryLocator(eventQuery);
    }
    global void execute(Database.BatchableContext batchContext, List<Event__c> eventList){
        List<Database.DeleteResult> deleteResults;
        if(!eventList.isEmpty()){
            deleteResults = Database.delete(eventList);
            for(Database.deleteResult deleteResult : deleteResults){
                if(deleteResult.isSuccess()){
                    deletedEvenetCount = deletedEvenetCount+1;
                    List<Database.Error> errors = deleteResult.getErrors();
                    String errorInString = String.join(errors,',');
                    TransactionLogHandler.doHandlerException(errorInString,'Delete Event Batch Failure');
                }
            }
        }
    }
    global void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        if(deletedEvenetCount >0){
            message.setToAddresses(new List<String>{
                'gaur.puneet@outlook.com'
            });
            message.optOutPolicy = 'FILTER';
            message.setSenderDisplayName('Puneet Gaur');
            message.subject = 'Event has been deleted';
            message.plainTextBody = 'Event has been deleted';
            Messaging.SingleEmailMessage[] messages = 
                new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                    + results[0].errors[0].message);
            }
        }
    }
}
