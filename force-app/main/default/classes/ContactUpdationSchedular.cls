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
public with sharing class ContactUpdationSchedular implements Schedulable{
    public void execute(SchedulableContext scon)
    {
        System.abortJob(scon.getTriggerId()); // abort already running schedule job 
        Decimal nextInterval = Decimal.valueOf(System.Label.nextIntervalTime); // config to decide next interval 2,5 or 10 mins etc..
        System.schedule('ContactUpdationSchedular - '+String.valueOf(DateTime.now()), '0 '+DateTime.now().addMinutes(Integer.valueOf(nextInterval)).minute()+' */1 ? * *', this); //Schedule the class to run with specified time
        Database.executeBatch(new ContactUpdateBatch()); // Call you batch class 
    }
}