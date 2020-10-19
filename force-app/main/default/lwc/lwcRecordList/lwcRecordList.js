import { LightningElement,api } from 'lwc';
import {showNotification} from 'c/lwcGlobalUtility';
export default class LwcRecordList extends LightningElement {
    @api 
    rec;
    @api
    iconname = 'standard:account';
    handleSelect(event){
        let selectEvent = new CustomEvent(
            'select',
            {
                detail : {
                    selRec : this.rec
                }
            }
        );
        this.dispatchEvent(selectEvent);
    }
    handleRemove(event){
        let selectEvent = new CustomEvent(
            'select',
            {
                detail : {
                    selRec : undefined
                }
            }
        );
        this.dispatchEvent(selectEvent);
    }
}