/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 11-29-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   11-29-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class EventDetailsService {
@AuraEnabled
public static List<Event__c> upcomingEvents(){
    List<Event__c> eventList = new List<Event__c>();
    try {
        eventList = [
            SELECT
                Id,
                Name,
                Name__c,
                Event_Detail__c,
                Location__c,
                Location__r.Name,
                Event_Organizer__c, 
                Event_Organizer__r.Name
            FROM
                Event__c
            WHERE
                Start_Date_Time__c >= Today
            AND
                Live__c = true
            WITH SECURITY_ENFORCED
        ];
        return eventList;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}
}
