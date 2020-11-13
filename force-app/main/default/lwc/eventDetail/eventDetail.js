import { LightningElement , api , track} from 'lwc';
import getSpeakers from '@salesforce/apex/EventDetailsController.getSpeakers';
const columns = [
    {   label: 'Name', fieldName: 'Name',
        cellAttributes:{
            iconName: 'standard:user',
            iconPosition: 'right'
        }
    },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Company Name', fieldName: 'CompanyName'}
];
export default class EventDetail extends LightningElement {
    @api recordId;
    @track speakerList;
    errors;
    columnsList = columns;
    handleSpeakerAcive(){
        getSpeakers({
            eventId : this.recordId
        })
        .then((result) => {
            alert(JSON.stringify(result));
            result.forEach(speaker => {
                speaker.Name = speaker.Speaker__r.Name,
                speaker.Email = speaker.Speaker__r.Email__c,
                speaker.CompanyName = speaker.Speaker__r.Company__c,
                speaker.Phone = speaker.Speaker__r.Phone__c
                
            });
            this.speakerList = result;
            this.errors = undefined;
        }).catch((err) =>{
            this.errors = err;
        })
    }
    handleLocationAcive(){

    }
    handleAttendeeAcive(){

    }
}