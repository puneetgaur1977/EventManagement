import { LightningElement , track , api} from 'lwc';
import {createRecord} from 'lightning/uiRecordApi';
import EVENT_OBJECT from '@salesforce/schema/Event__c';
import Name_F from '@salesforce/schema/Event__c.Name__c';
import Event_Organizer__c from '@salesforce/schema/Event__c.Event_Organizer__c';
import Start_Date_Time__c from '@salesforce/schema/Event__c.Start_Date_Time__c';
import End_Date_Time__c from '@salesforce/schema/Event__c.End_Date_Time__c';
import Location__c from '@salesforce/schema/Event__c.Location__c';
import Event_Detail__c from '@salesforce/schema/Event__c.Event_Detail__c';
import Max_Seats__c from '@salesforce/schema/Event__c.Max_Seats__c';
import { NavigationMixin } from 'lightning/navigation';
import {showNotification} from 'c/globalUtility';
const ERROR_CAR_TYPE_TYPE= 'Record is not saved';
const ERROR = 'error';
const SUCCESS_MESSAGE_TYPE= 'Record has been saved successfully';
const SUCCESS = 'success';
export default class AddEvent extends NavigationMixin(LightningElement) {
    @api recordId;
    @api isModalOpen;
    @track eventRecord = {
        Name__c : '',
        Event_Organizer__c : '',
        Start_Date_Time__c : null,
        End_Date_Time__c : null,
        Max_Seats__c : null,
        Location__c : '',
        Event_Detail__c : ''

    }
    @track errors;
    handleChange(event){
        let value = event.target.value;
        let name = event.target.name;
        this.eventRecord[name] = value;
    }
    handleLookup(event){
        let selectedRecordId = event.detail.selectedRecordId;
        let parentField = event.detail.parentidfield;
        this.eventRecord[parentField] = selectedRecordId;
    }
    handleClick(){
        const fields = {};
        fields[Name_F.fieldApiName] = this.eventRecord.Name__c;
        fields[Event_Organizer__c.fieldApiName] = this.eventRecord.Event_Organizer__c;
        fields[Start_Date_Time__c.fieldApiName] = this.eventRecord.Start_Date_Time__c;
        fields[End_Date_Time__c.fieldApiName] = this.eventRecord.End_Date_Time__c;
        fields[Max_Seats__c.fieldApiName] = this.eventRecord.Max_Seats__c;
        fields[Location__c.fieldApiName] = this.eventRecord.Location__c;
        fields[Event_Detail__c.fieldApiName] = this.eventRecord.Event_Detail__c;
        const eventRecord = {apiName : EVENT_OBJECT.objectApiName , fields};
        createRecord(eventRecord)
        .then((eventRec) =>{
            this.isModalOpen = false;
            showNotification('Event Success',SUCCESS_MESSAGE_TYPE,SUCCESS);
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    actionName: "view",
                    recordId: eventRec.id,
                }
            });
            
        }).catch((err) =>{
            this.errors = JSON.stringify(err.messa);
            showNotification(ERROR_CAR_TYPE_TYPE,this.errors,ERROR);
            console.log(err);
        });

    }
    handleCancel(){
        this.isModalOpen = false;
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                actionName: "home",
                objectApiName: "Event__c"
            }
        });
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

}