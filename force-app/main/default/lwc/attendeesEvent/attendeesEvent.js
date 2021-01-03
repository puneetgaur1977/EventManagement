import { LightningElement , api, track } from 'lwc';
import getUpcomingEvents from '@salesforce/apex/AttendeeEventService.getUpcomingEvents';
import getPastEvent from '@salesforce/apex/AttendeeEventService.getPastEvents';
const columns = [
    {
        label: "Event Name",
        fieldName: "detailPage",
        type: "url",
        wrapText: "true",
        typeAttributes:{
            label:{
                fieldName : "Name__c"
            },
            target: "_blank"
        }
    },
    {   
        label: 'Name', 
        fieldName: 'EVNTORG',
        cellAttributes:{
            iconName: 'standard:event',
            iconPosition: 'right'
        }
    },
    { label: 'Event Date', fieldName: 'StartDateTime', type: 'datetime' },
    { label: 'Location', fieldName: 'Location', type: 'text' }

];
export default class AttendeesEvent extends LightningElement {
    @api recordId;
    @track events;
    @track pastevents;
    errors;
    columnList = columns;
    connectedCallback(){
        this.upcomingEventList();
        this.getPastEventList();
    }
    upcomingEventList(){
        getUpcomingEvents({ attendeeId: this.recordId })
        .then(result => {
            result.forEach(attendee => {
                attendee.Name = attendee.Event__r.Name;
                attendee.detailPage = "https://"+window.location.host+'/'+attendee.Event__c;
                attendee.EVNTORG = attendee.Event__r.Event_Organizer__r.Name;
                attendee.StartDateTime = attendee.Event__r.Start_Date_Time__c;
                if(attendee.Event__r.Location__c){
                    attendee.Location = attendee.Event__r.Location__r.Name;
                }else{
                    attendee.Location = 'Not Defined- Virtual Event Defined';
                }
            });
            this.events = result;
        })
        .catch(error => {
            this.events = undefined;
            this.errors = JSON.stringify(error);
        });
    }
    getPastEventList(){
        getPastEvent({ attendeeId: this.recordId })
        .then(result => {
            result.forEach(attendee => {
                attendee.Name = attendee.Event__r.Name;
                attendee.detailPage = "https://"+window.location.host+'/'+attendee.Event__c;
                attendee.EVNTORG = attendee.Event__r.Event_Organizer__r.Name;
                attendee.StartDateTime = attendee.Event__r.Start_Date_Time__c;
                if(attendee.Event__r.Location__c){
                    attendee.Location = attendee.Event__r.Location__r.Name;
                }else{
                    attendee.Location = 'Not Defined- Virtual Event Defined';
                }
            });
            this.pastevents = result;
        })
        .catch(error => {
            this.pastevents = undefined;
            this.errors = JSON.stringify(error);
        });
    }
}