import { LightningElement , api , track } from 'lwc';
import searchRecords from '@salesforce/apex/CustomSearchController.searchRecord';
export default class Customlwclookup extends LightningElement {
    @api
    objectName = 'Account';
    @api
    fieldName = 'Name';
    @api
    iconname = 'standard:record';
    @api
    label = 'Account';
    @api
    parentidfield = 'AccountId';
    @track
    records;
    @track
    selectedRecord;
    limitValue = 100;

    handleSearch(event){
        var searchVal = event.detail.value;
        console.log(searchVal);
        //alert(searchVal);
        searchRecords({
            objName : this.objectName,
            fieldName : this.fieldName,
            searchKey : searchVal,
            limitValue : this.limitValue
        })
        .then(data => {
            if(data){
                //alert(JSON.stringify(data));
                let parsedResponse = JSON.parse(data);
                let searchRecordList = parsedResponse[0];
                for(let i=0; i< searchRecordList.length; i++){
                    let record = searchRecordList[i];
                    record.Name = record[this.fieldName];
                }
                this.records = searchRecordList;
            }
        })
        .catch(error =>{
            alert(error);
        });
    }
    handleSelect(event){
        var selectedVal = event.detail.value;
        this.selectedRecord = selectedVal;
        let finalRecEvent = new CustomEvent(
            'select',
            {
                detail : {
                    selectedRecordId : this.selectedRecordId,
                    parentidfield : this.parentidfield
                }
            }
        );
        this.dispatchEvent(finalRecEvent);
    }
    handleRemove(event){
        this.selectedRecord = undefined;
        this.records = undefined;
        let finalRecEvent = new CustomEvent(
            'select',{
                detail : {
                    selectedRecordId : undefined,
                    parentidfield : this.parentidfield
                }
            }
        );
        this.dispatchEvent(finalRecEvent);
    }
}