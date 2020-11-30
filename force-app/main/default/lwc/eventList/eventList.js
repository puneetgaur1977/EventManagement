import { LightningElement , wire , track} from 'lwc';
import getUpcomingEvents from '@salesforce/apex/EventDetailsService.upcomingEvents';
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
    @track result;
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

}