import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
const showNotification = function(notificationTitle,notificationMessage,notificationVariant){
    const evt = new ShowToastEvent({
        title: notificationTitle,
        message: notificationMessage,
        variant: notificationVariant
    });
  dispatchEvent(evt);
}
const navigateToNewRecordPage = function(navigateObjectName){
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes:{
            objectApiName: navigateObjectName,
            actionName: 'new'
        }
    });
}
export{showNotification};
export{navigateToNewRecordPage};