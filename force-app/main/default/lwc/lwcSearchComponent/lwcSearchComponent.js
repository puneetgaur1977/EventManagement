import { LightningElement , api , wire , track } from 'lwc';
import {showNotification} from 'c/lwcGlobalUtility';
export default class LwcSearchComponent extends LightningElement {
    @track
    searchKeyword;
    @api
    isrequired = false;
    @api
    searchLabel = 'Search Account'
    renderedCallback(){
        if(!this.isrequired){
            //alert('Hello');
            //showNotification('ERROR','Please Selec','error');
            return;
        }
        let pickListInfo = this.template.querySelector('lightning-input');
        pickListInfo.required = true;
        this.isrequired = false;
    }
    handleChange(event){
        var keyword = event.target.value;
        //alert(keyword);
        if(keyword && keyword.length >= 2){
            //alert(keyword.length);
            let searchEvent = new CustomEvent(
                'search',
                {
                    detail : {
                        value : keyword
                    }
                }
            );
            this.dispatchEvent(searchEvent);
        }
    }
}