import { LightningElement , api , track} from 'lwc';
import getSpeakers from '@salesforce/apex/EventDetailsController.getSpeakers';
import getLocation from '@salesforce/apex/EventDetailsController.getLocationDetails';
import getAttendeeList from '@salesforce/apex/EventDetailsController.getEventAttendee';
import { NavigationMixin } from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils'; 
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
const columnsAttendees = [
    {   
        label: 'Name', 
        fieldName: 'Name',
        cellAttributes:{
            iconName: 'standard:user',
            iconPosition: 'right'
        }
    },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'CompanyName', fieldName: 'CompanyName', type: 'CompanyName' },
    { label: 'Location', fieldName: 'Location', 
        cellAttributes:{
        iconName: 'utility:location',
        iconPosition: 'right'
        } 
    }
];
export default class EventDetail extends NavigationMixin(LightningElement) {
    @api recordId;
    @track speakerList;
    @track eventRecord;
    @track eventAttendeeList;
    errors;
    columnsList = columns;
    columnsAttendeeList = columnsAttendees;
    handleSpeakerAcive(){
        getSpeakers({
            eventId : this.recordId
        })
        .then((result) => {
            //alert(JSON.stringify(result));
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
        getLocation({
             eventId : this.recordId
         })
         .then((result) => {
             //alert(JSON.stringify(result));
             if(result.Location__c){
                 this.eventRecord = result;
             }else{
                 this.eventRecord = undefined
             }
             this.errors = undefined;
         }).catch((err) =>{
             this.errors = err;
         })


     }
    handleAttendeeAcive(){
        getAttendeeList({
            eventId : this.recordId
        })
        .then((result) => {
            result.forEach(att => {
                att.Name = att.Attendee__r.Name;
                att.Email = att.Attendee__r.Email__c;
                att.CompanyName = att.Attendee__r.Company_Name__c;
                if(att.Attendee__r.Location__c){
                    att.Location = att.Attendee__r.Location__r.Name;
                }else{
                    att.Location = 'Preferred No to Say';
                }
            });
            this.eventAttendeeList = result;
            this.errors = undefined;
        }).catch((err) =>{
            this.errors = err;
        })
    }
    errorCallback(error, stack){
        this.errors = error;
    }
    createSpeaker(){
        const defaultValues = encodeDefaultFieldValues({
            Event__c: this.recordId
        });
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes:{
                objectApiName: "Event_Speaker__c",
                actionName: "new"
            },
            state:{
                defaultFieldValues: defaultValues
            }
        });
    }
    createAttendee(){
        const defaultValues = encodeDefaultFieldValues({
            Event__c: this.recordId
        });
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes:{
                objectApiName: "Event_Attendee__c",
                actionName: "new"
            },
            state:{
                defaultFieldValues: defaultValues
            }
        });
    }
}