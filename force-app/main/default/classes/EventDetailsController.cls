/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 11-29-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   11-12-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class EventDetailsController {
    @AuraEnabled
    public static List<Event_Speaker__c> getSpeakers(String eventId){
        List<Event_Speaker__c> speakerList = [
            SELECT
                Id,
                Name,
                Speaker__c,
                Speaker__r.Name,
                Speaker__r.Phone__c,
                Speaker__r.Email__c,
                Speaker__r.Company__c
            FROM
                Event_Speaker__c
            WHERE
                Event__c = :eventId
            WITH SECURITY_ENFORCED
        ];
        return speakerList;
    }
    @AuraEnabled
    public static Event__c getLocationDetails(String eventId){
        try {
            Event__c eventRecord = [
                SELECT
                    Id,
                    Name,
                    Location__c,
                    Location__r.Name,
                    Location__r.City__c,
                    Location__r.Country__c, 
                    Location__r.Land_Mark__c, 
                    Location__r.Postal_Code__c, 
                    Location__r.State__c,
                    Location__r.Street__c
                FROM
                    Event__c
                WHERE
                    Id = :eventId
                WITH SECURITY_ENFORCED
            ];
            return eventRecord;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Event_Attendee__c> getEventAttendee(String eventId){
        List<Event_Attendee__c> eventAttendeesList = new List<Event_Attendee__c>();
        try {
            eventAttendeesList = [
                SELECT
                    ID,
                    Name, 
                    Attendee__c,
                    Attendee__r.Name,
                    Attendee__r.Company_Name__c,
                    Attendee__r.Email__c, 
                    Attendee__r.Location__r.Name,
                    Attendee__r.Location__c
                FROM
                    Event_Attendee__c
                WHERE
                    Event__c = :eventId
                WITH SECURITY_ENFORCED
            ];
            return eventAttendeesList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}