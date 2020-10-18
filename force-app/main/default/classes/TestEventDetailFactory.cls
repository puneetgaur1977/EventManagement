/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 10-11-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   10-11-2020   gaur.puneet@outlook.com   Initial Version
**/
@isTest
public class TestEventDetailFactory {
    private
    String eventName;
    private
    String eventType;
    private
    Id eventOrganizer;
    private
    String eventFrequency;
    private
    DateTime eventEndDateTime;
    private
    DateTime eventStartDateTime;
    private
    String eventStatus;
    private
    Boolean eventRecurring;
    private
    Integer eventMaxSeat;
    private
    Id eventLocation;
    private
    Boolean eventLive;
    public
    TestEventDetailFactory setEventEndDateTime(DateTime eventEndDateTime){
        this.eventEndDateTime = eventEndDateTime;
        return this;
    }
    public
    TestEventDetailFactory setEventStartDateTime(DateTime eventStartDateTime){
        this.eventStartDateTime = eventStartDateTime;
        return this;
    }
    public
    TestEventDetailFactory setEventMaxSeat(DateTime eventMaxSeat){
        this.eventMaxSeat = eventMaxSeat;
        return this;
    }
    public
    TestEventDetailFactory setEventLocation(Id eventLocation){
        this.eventLocation = eventLocation;
        return this;
    }
    public
    TestEventDetailFactory setEventRecurring(Boolean eventRecurring){
        this.eventRecurring = eventRecurring;
        return this;
    }

}
