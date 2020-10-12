/**
 * @description       : 
 * @author            : Puneet Gaur
 * @group             : 
 * @last modified on  : 10-11-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class TransactionLogHandler {
    public static void doHandlerException(System.Exception ex, String processName){
        Error_Logs__c transactionLog = new Error_Logs__c(
            Log_DateTime__c = System.Now(),
            Log_Details__c = ex.getStackTraceString()+'<br/><strong>Error Message</strong>'+ ex.getMessage()
            + '<br/>' + ex.getCause()+ ' <br/>'+ ex.getTypeName() + '<br/>'+
            ex.getLineNumber(),
            Process_Name__c = processName
        );
        if(Schema.sObjectType.Error_Logs__c.isCreateable()){
            insert transactionLog;
        }
    }
    public static void doHandlerException(String errors, String processName){
        Error_Logs__c transactionLog = new Error_Logs__c(
            Log_DateTime__c = System.Now(),
            Log_Details__c = errors,
            Process_Name__c = processName
        );
        if(Schema.sObjectType.Error_Logs__c.isCreateable()){
            insert transactionLog;
        }
    }
}