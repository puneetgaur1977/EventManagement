/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 12-30-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   11-30-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class AttendeeEventService {
    @AuraEnabled
    public static List<Event_Attendee__c> getUpcomingEvents(String attendeeId){
        List<Event_Attendee__c> upcomingEventAttendeeList = new List<Event_Attendee__c>();
        try {
            upcomingEventAttendeeList = [
                SELECT
                    Id,
                    Name,
                    Event__c,
                    Event__r.Name,
                    Event__r.Event_Organizer__r.Name,
                    Event__r.Start_Date_Time__c,
                    Event__r.Event_Organizer__c,
                    Event__r.Location__c,
                    Event__r.Location__r.Name
                FROM
                    Event_Attendee__c
                WHERE
                    Attendee__c = :attendeeId
                AND
                    Event__r.Start_Date_Time__c >= TODAY
                AND
                    Event__r.Live__c = true
                WITH SECURITY_ENFORCED
                ];
            return upcomingEventAttendeeList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Event_Attendee__c> getPastEvents(String attendeeId){
        List<Event_Attendee__c> upcomingEventAttendeeList = new List<Event_Attendee__c>();
        try {
            upcomingEventAttendeeList = [
                SELECT
                    Id,
                    Name,
                    Event__c,
                    Event__r.Name,
                    Event__r.Event_Organizer__r.Name,
                    Event__r.Start_Date_Time__c,
                    Event__r.Event_Organizer__c,
                    Event__r.Location__c,
                    Event__r.Location__r.Name
                FROM
                    Event_Attendee__c
                WHERE
                    Attendee__c = :attendeeId
                AND
                    Event__r.Start_Date_Time__c < TODAY
                WITH SECURITY_ENFORCED
                ];
            return upcomingEventAttendeeList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}