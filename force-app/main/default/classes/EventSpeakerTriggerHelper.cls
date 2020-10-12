/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-25-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-24-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class EventSpeakerTriggerHelper {
    public
    static void rejectDuplicateEventBookings(List<Event_Speaker__c> newRecordList){
        Set<Id> speakerIdSet = new Set<Id>();
        Set<Id> eventIdSet = new Set<Id>();
        Map<Id, DateTime> requestedEvents = new Map<Id, DateTime>();
        List<Event__c> eventList = new List<Event__c>();
        List<Event_Speaker__c> relatedEventSpeakers = new List<Event_Speaker__c>();
        for(Event_Speaker__c eventSpeaker : newRecordList){
            speakerIdSet.add(eventSpeaker.Speaker__c);
            eventIdSet.add(eventSpeaker.Event__c);
        }
        if(!eventIdSet.isEmpty()){
            eventList = getRelatedEvenetList(eventIdSet);
            for(Event__c event : eventList){
                requestedEvents.put(event.Id, event.Start_Date_Time__c);
            }
        }
        if(!speakerIdSet.isEmpty()){
            relatedEventSpeakers = getEventSpeakerList(speakerIdSet);

        }
        if(!requestedEvents.isEmpty() && !relatedEventSpeakers.isEmpty()){
            for(Event_Speaker__c eventSpeaker : newRecordList){
                DateTime eventBookingTime = requestedEvents.get(eventSpeaker.Event__c);
                for(Event_Speaker__c existingEventSpeaker : relatedEventSpeakers){
                    if(eventSpeaker.Speaker__c == existingEventSpeaker.Speaker__c && eventBookingTime == existingEventSpeaker.Event__r.Start_Date_Time__c){
                        eventSpeaker.addError('The speaker is already booked at that time');
                    }
                }

            }
        }
    }
    /*
    @Author : Puneet Gaur
    @Description : Get Event Records for the Selected Id Set
    */
    public
    static List<Event__c> getRelatedEvenetList(Set<Id> eventIdSet){
        return[
            SELECT
                Id,
                Start_Date_Time__c
            FROM
                Event__c
            WHERE
                Id
            IN :eventIdSet
        ];
    }
    /*
    @Author : Puneet Gaur
    @Description : Get Event Speaker Records for the Selected Id Set
    */
    public
    static List<Event_Speaker__c> getEventSpeakerList(Set<Id> speakerIdSet){
        return[
            SELECT
                Id,
                Event__c,
                Speaker__c,
                Event__r.Start_Date_Time__c
            FROM
                Event_Speaker__c
            WHERE
                Speaker__c
            IN :speakerIdSet
        ];
    }

}