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
global class ContactUpDateBatch implements Database.Batchable<sObject>, Database.Stateful {
    // If we remove the stateful from Implemente then below variable values won't display updated values in the email
    // If we remove Stateful then email will be received with 0 in all three variables
    global Integer total_size = 0;
    global Integer fail_size = 0;
    global Integer success_size = 0;
    global Database.queryLocator start(Database.BatchableContext bc){
        String contactQuery = 'select Id, Name, Fax, Email, MobilePhone, Description, Account.Name, Account.Rating, Account.Phone, Account.Fax, Account.Industry from Contact Where AccountId != null';
        AsyncApexJob[] apexJobs = [
            SELECT
                Id,
                ApexClassId,
                ApexClass.Name,
                NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems,
                Status,
                JobType
            FROM
                AsyncApexJob
            WHERE
                Id = :bc.getJobId()
        ];
        System.debug('Start Method-'+apexJobs);
        return Database.getQueryLocator(contactQuery);
    }
    global void execute(Database.BatchableContext bc, List<Contact> conactList){
        Integer contactRecordSize = conactList.size();
        AsyncApexJob[] apexJobs = [
            SELECT
                Id,
                ApexClassId,
                ApexClass.Name,
                NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems,
                Status,
                JobType
            FROM
                AsyncApexJob
            WHERE
                Id = :bc.getJobId()
        ];
        System.debug('Execute Method-'+apexJobs);
        AsyncApexJob[] apexChildJobs = [
            SELECT
                Id,
                ApexClassId,
                ApexClass.Name,
                NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems,
                Status,
                JobType
            FROM
                AsyncApexJob
            WHERE
                Id = :bc.getChildJobId()
        ];
        System.debug('Execute Child Method-'+apexJobs);

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
        Database.SaveResult[] updateResults =  Database.update(conactList, false);
        for(Database.SaveResult updateResult : updateResults){
            if(updateResult.isSuccess()){
                success_size += 1;
            }else{
                fail_size += 1;
            }
        }
    }
    global void finish(Database.BatchableContext bc){
        AsyncApexJob[] apexJobs = [
            SELECT
                Id,
                ApexClassId,
                ApexClass.Name,
                NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems,
                Status,
                JobType
            FROM
                AsyncApexJob
            WHERE
                Id = :bc.getJobId()
        ];
        System.debug('Finish Method-'+apexJobs);
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setSubject('Status if Batch Class : ContactBatch');
        email.setSenderDisplayName('Puneet Gaur');
        email.setHtmlBody('Dear User, Batch Processed'+
        '<br/> Total Records='+total_size +
        '<br/> Success Records='+success_size +
        '<br/> Failed Records='+fail_size);
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