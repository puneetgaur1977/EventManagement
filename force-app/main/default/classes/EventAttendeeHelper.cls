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
public with sharing class EventAttendeeHelper {
    public
    static void sendConfirmationEmail(List<Event_Attendee__c> newRecordList,Map<Id,Event_Attendee__c> newRecordMap){
        System.debug('Calling Helper');
        Set<Id> attendeesIdSet = new Set<Id>();
        Set<Id> eventIdSet = new Set<Id>();
        Map<Id,Attendee__c> attendeesMap = new Map<Id,Attendee__c>();
        Map<Id,Event__c> eventMap = new Map<Id,Event__c>();
        Attendee__c attendeeRecord = new Attendee__c();
        Event__c eventRecord = new Event__c();
        String emailBody = System.Label.Email_Content;
        String eventLocation;
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> messageList = new List<Messaging.SingleEmailMessage>();

        for(Event_Attendee__c newRecord : newRecordList){
            attendeesIdSet.add(newRecord.Attendee__c);
            eventIdSet.add(newRecord.Event__c);
        }

        attendeesMap = getAttendeeMap(attendeesIdSet);
        eventMap = getEventMap(eventIdSet);

        for(Event_Attendee__c eventAttendeeRecord : newRecordList){
            attendeeRecord = attendeesMap.get(eventAttendeeRecord.Attendee__c);
            eventRecord = eventMap.get(eventAttendeeRecord.Event__c);
            eventLocation ='https://google.com/maps/place/'+ eventRecord.Location__r.Street__c+' '+ 
                            eventRecord.Location__r.City__c+' '+
                            eventRecord.Location__r.State__c+' '+
                            eventRecord.Location__r.Postal_Code__c+' '+
                            eventRecord.Location__r.Country__c;
            eventLocation = '<a href="'+eventLocation+'"'+'target="_blank">Here</a>';
            message.setToAddresses(new List<String>{attendeeRecord.Email__c});
            message.optOutPolicy = 'FILTER';
            message.setSubject('Pass for the '+eventRecord.Name);
            message.setSenderDisplayName(eventRecord.Event_Organizer__r.Name);
            emailBody = emailBody.replace('{AttendeeName}',attendeeRecord.Name);
            emailBody = emailBody.replace('{EventName}',eventRecord.Name);
            emailBody = emailBody.replace('{EventDate}', String.valueOf(eventRecord.Start_Date_Time__c));
            emailBody = emailBody.replace('{EventLocation}',eventRecord.Location__r.Name);
            emailBody = emailBody.replace('{EventLocation}',eventRecord.Location__r.Name);
            emailBody = emailBody.replace('{Location}',eventLocation);
            emailBody = emailBody.replace('{OrganizerName}',eventRecord.Event_Organizer__r.Name);
            message.setHtmlBody(emailBody);
            messageList.add(message);
        }
        try{
            System.debug('messageList'+messageList);
            List<Messaging.SendEmailResult> emailResults =  Messaging.sendEmail(messageList,false);
            for(Messaging.SendEmailResult emailResult : emailResults){
                if(!emailResult.isSuccess()){
                    List<Messaging.SendEmailError> errors = emailResult.getErrors();
                    TransactionLogHandler.doHandlerException(JSON.serialize(errors),'EventAttendeeHelper');
                }
            }
        }catch(Exception ex){
            TransactionLogHandler.doHandlerException(ex,'Event Attendee Email Send');
        }
    }
    private
    static Map<Id,Attendee__c> getAttendeeMap(Set<Id> attendeesIdSet){
        return new Map<Id,Attendee__c>([
            SELECT
                Id,
                Name,
                Email__c
            FROM
                Attendee__c
            WHERE
                ID IN :attendeesIdSet
        ]);
    }
    private
    static Map<Id,Event__c> getEventMap(Set<Id> eventIdSet){
        return new Map<Id,Event__c>([
            SELECT
                Id,
                Name,
                Start_Date_Time__c,
                Event_Organizer__c,
                Event_Organizer__r.Name,
                Location__c,
                Location__r.Name,
                Location__r.City__c,
                Location__r.Country__c,
                Location__r.State__c,
                Location__r.Street__c,
                Location__r.Postal_Code__c
            FROM
                Event__c
            WHERE
                ID IN :eventIdSet
        ]);
    }
    
}