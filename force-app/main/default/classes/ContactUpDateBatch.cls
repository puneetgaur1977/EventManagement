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
global class ContactUpDateBatch implements Database.Batchable<sObject> {
    global Database.queryLocator start(Database.BatchableContext bc){
        String contactQuery = 'select Id, Name, Fax, Email, MobilePhone, Description, Account.Name, Account.Rating, Account.Phone, Account.Fax, Account.Industry from Contact';
        return Database.getQueryLocator(contactQuery);
    }
    global void execute(Database.BatchableContext bc, List<Contact> conactList){
        Integer contactRecordSize = conactList.size();
        for(Contact contactRecord : conactList){
            if(String.isEmpty(contactRecord.Fax)){
                contactRecord.Fax = contactRecord.Account.Fax;
            }
            if(String.isEmpty(contactRecord.Fax)){
                contactRecord.Fax = contactRecord.Account.Fax;
            }
            if(String.isEmpty(contactRecord.MobilePhone)){
                contactRecord.MobilePhone = contactRecord.Account.Phone;
            }
            contactRecord.Email = 'gaur.puneet@outlook.com';
            contactRecord.Description = contactRecord.Account.Name + ' '+contactRecord.Account.Rating+' '+contactRecord.Account.Industry;
        }
        update conactList;
    }
    global void finish(Database.BatchableContext bc){
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setSubject('Status if Batch Class : ContactBatch');
        email.setSenderDisplayName('Puneet Gaur');
        email.setHtmlBody('Dear User, Batch Processed');
        List<String> emailTo = new List<String>();
        emailTo.add('gaur.puneet@outlook.com');
        email.setToAddresses(emailTo);
        Messaging.SingleEmailMessage[] emailList = new List<Messaging.SingleEmailMessage>();
        emailList.add(email);
        Messaging.sendEmail(emailList, false);
    }
    /*public void finish(Database.BatchableContext BC){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
           TotalJobItems, CreatedBy.Email
           FROM AsyncApexJob WHERE Id =
           :BC.getJobId()];
        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Sharing Recalculation ' + a.Status);
        mail.setPlainTextBody
        ('The batch Apex job processed ' + a.TotalJobItems +
        ' batches with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     }*/
}
