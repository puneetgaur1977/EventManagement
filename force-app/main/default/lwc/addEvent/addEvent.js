import { LightningElement , track } from 'lwc';
import {createRecord} from 'lightning/uiRecordApi';
import EVENT_OBJECT from '@salesforce/schema/Event__c';
import Name from '@salesforce/schema/Event__c.Name__c';
import Event_Organizer__c from '@salesforce/schema/Event__c.Event_Organizer__c';
import Start_Date_Time__c from '@salesforce/schema/Event__c.Start_Date_Time__c';
import End_Date_Time__c from '@salesforce/schema/Event__c.End_Date_Time__c';
import Location__c from '@salesforce/schema/Event__c.Location__c';
import Event_Detail__c from '@salesforce/schema/Event__c.Event_Detail__c';
export default class AddEvent extends LightningElement {
    @track eventRecord = {
        Name : '',
        Event_Organizer__c : '',
        Start_Date_Time__c : null,
        End_Date_Time__c : null,
        Max_Seats__c : null,
        Location__c : '',
        Event_Detail__c : ''

    }
    handleChange(event){
        let value = event.target.value;
        let name = event.target.name;
        this.eventRecord[name] = value;
    }
    handleLookup(event){
        let selectedRecordId = event.detail.selectedRecordId;
        let parentField = event.detail.parentfield;
        this.eventRecord[parentField] = selectedRecordId;
    }
    handleClick(){
        alert('Hello');
        const fields = {};
        fields[Name.fieldApiName] = this.eventRecord.Name;
        fields[Event_Organizer__c.fieldApiName] = this.eventRecord.Event_Organizer__c;
        fields[Start_Date_Time__c.fieldApiName] = this.eventRecord.Start_Date_Time__c;
        fields[End_Date_Time__c.fieldApiName] = this.eventRecord.End_Date_Time__c;
        fields[Max_Seats__c.fieldApiName] = this.eventRecord.Max_Seats__c;
        fields[Location__c.fieldApiName] = this.eventRecord.Location__c;
        fields[Event_Detail__c.fieldApiName] = this.eventRecord.Event_Detail__c;

        const eventRecord = {apiName : EVENT_OBJECT.objectApiName , fields};
        createRecord(eventRecord)
        .then((eventRec) =>{
            alert('Record save'+eventRec.Id)
        }).catch((err) =>{
            alert('Err');
            console.log(err);
        });

    }

}