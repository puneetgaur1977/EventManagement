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
@isTest
public class TestAttendeesFactory {
    private
    String attendeeName;
    private
    String companyName;
    private
    String attendeeEmail;
    private
    Id attendeeLocation;
    private
    Id ownerId;
    private
    String attendeePhoneNumber;

    public
    TestAttendeesFactory setAttendeeName(String attendeeName){
        this.attendeeName = attendeeName;
        return this;
    }
    public
    TestAttendeesFactory setCompanyName(String companyName){
        this.companyName = companyName;
        return this;
    }
    public
    TestAttendeesFactory setAttendeeEmail(String attendeeEmail){
        this.attendeeEmail = attendeeEmail;
        return this;
    }
    public
    TestAttendeesFactory setAttendeeLocation(Id attendeeLocation){
        this.attendeeLocation = attendeeLocation;
        return this;
    }
    public
    TestAttendeesFactory setOwnerId(Id ownerId){
        this.ownerId = ownerId;
        return this;
    }
    public
    TestAttendeesFactory setAttendeePhoneNumber(String attendeePhoneNumber){
        this.attendeePhoneNumber = attendeePhoneNumber;
        return this;
    }
    public
    Attendee__c build(){
        Attendee__c buildAttendeeObj = new Attendee__c(
            Name = attendeeName,
            Company_Name__c = companyName,
            Email__c = attendeeEmail,
            Location__c = attendeeLocation,
            OwnerId = ownerId,
            Phone__c = attendeePhoneNumber
        );
        return buildAttendeeObj;
    }
    public
    Attendee__c buildAndSave(){
        Attendee__c attendeeRecord = build();
        insert attendeeRecord;
        return attendeeRecord;
    }
}
