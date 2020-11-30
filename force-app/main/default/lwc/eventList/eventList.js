import { LightningElement , wire , track} from 'lwc';
import getUpcomingEvents from '@salesforce/apex/EventDetailsService.upcomingEvents';
import Icon_Conditional_Formatting_png from '@salesforce/contentAssetUrl/Icon_Conditional_Formatting_png';
const columns = [
    {
        label: "View",
        fieldName: "URL",
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
        fieldName: 'Name__c',
        cellAttributes:{
            iconName: 'standard:event',
            iconPosition: 'right'
        }
    },
    {   
        label: 'Name', 
        fieldName: 'EVNT_ORG',
        cellAttributes:{
            iconName: 'standard:event',
            iconPosition: 'right'
        }
    },
    { label: 'Location', fieldName: 'Location', type: 'text' },
    { label: 'Details', fieldName: 'Event_Detail__c', type: 'text' , wrapText:true}

];
export default class EventList extends LightningElement {
    columnsList = columns;
    error;
    startdatetime;
    @track result;
    @track recordoDisplay;
    connectedCallback(){
        this.upcomingEvents();
    }

    upcomingEvents(){
        getUpcomingEvents()
        .then((data) =>{
            data.forEach(event => {
                event.URL = "https://"+location.host+'/'+event.Id;
                event.EVNT_ORG = event.Event_Organizer__r.Name;
                if(event.Location__c){
                    event.Location = event.Location__r.Name;
                }else{
                    event.Location = 'Virtual Location';
                }
            });
            this.result = data;
            this.recordoDisplay = data;
            this.error = undefined;
        }).catch((err) =>{
            this.error = err;
            this.result = undefined;
        });
    }
    /*@wire(getUpcomingEvents)
    wiredData({ error, data }) {
      if (data) {
        data.forEach(event => {
            event.URL = "https://"+location.host+'/'+event.Id;
            event.EVNT_ORG = event.Event_Organizer__r.Name;
            if(event.Location__c){
                event.Location = event.Location__r.Name;
            }else{
                event.Location = 'Virtual Location';
            }
        });
        this.result = data;
        this.error = undefined;
      } else if (error) {
         this.error = error;
         this.result = undefined;
      }
    }*/
    handleSearch(event){
        let keyWord = event.detail.value;
        let filteredEvent = this.result.filter((record, index,arrayobject) => {
            return record.Name__c.toLowerCase().includes(keyWord.toLowerCase());
        });
        if(keyWord && keyWord.length >=2){
            this.recordoDisplay = filteredEvent;
        }
        else{
            this.recordoDisplay = this.result;
        }
    }
    handleStartDate(event){
        //Start_Date_Time__c
        let valueDateTime = event.target.value;
        let filteredEvent = this.result.filter((record, index,arrayobject) => {
            return record.Start_Date_Time__c >= valueDateTime;
        });
        this.recordoDisplay = filteredEvent;
    }
    handleLocationSearch(event){
        let keyWord = event.detail.value;
        let filteredEvent = this.result.filter((record, index,arrayobject) => {
            return record.Location.toLowerCase().includes(keyWord.toLowerCase());
        });
        if(keyWord && keyWord.length >=2){
            this.recordoDisplay = filteredEvent;
        }
        else{
            this.recordoDisplay = this.result;
        }       
    }
}