/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 11-12-2020
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
}
