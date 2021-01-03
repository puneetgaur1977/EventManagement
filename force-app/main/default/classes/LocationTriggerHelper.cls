/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 10-18-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   10-18-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class LocationTriggerHelper {
    @future(callout = true)
    public
    static void validateLocationAddress(Set<Id> recordId){
        List<Location__c> locationUpdateList = new List<Location__c>();
        List<Location__c> newLocationList = [
            SELECT
                Id,
                Street__c,
                City__c,
                State__c,
                Postal_Code__c,
                Verified__c
            FROM
                Location__c
            WHERE
                ID IN :recordId
        ];
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpResp;
        Http http;
        String responseBody ;
        String baseAddressVerification = 'https://smartystreets.com/products/apis/us-street-api?auth-id=f4eb5c5f-6f5b-69e6-aad3-3e18a70be9f7&auth-token=XPrOQEAqH7xGxtzuHrtX';
        
        for(Location__c locationRecord : newLocationList){
            baseAddressVerification = 'https://smartystreets.com/products/apis/us-street-api?auth-id=f4eb5c5f-6f5b-69e6-aad3-3e18a70be9f7&auth-token=XPrOQEAqH7xGxtzuHrtX';
            baseAddressVerification+= '&street='+ EncodingUtil.urlEncode(locationRecord.Street__c,'UTF-8');
            baseAddressVerification+= '&city='+EncodingUtil.urlEncode(locationRecord.City__c,'UTF-8');
            baseAddressVerification+= '&state='+EncodingUtil.urlEncode(locationRecord.State__c,'UTF-8');
            baseAddressVerification+= '&zipcode='+EncodingUtil.urlEncode(locationRecord.Postal_Code__c,'UTF-8');
            baseAddressVerification+= '&match=invalid';
            System.debug('baseAddressVerification='+baseAddressVerification);
            httpReq.setMethod('GET');
            httpReq.setEndpoint(baseAddressVerification);
            httpReq.setHeader('Content-Type','application/json');
            http = new Http();
            httpResp = new HttpResponse();
            try{
                httpResp = http.send(httpReq);
                System.debug('httpResp='+httpResp.getBody());
                if(httpResp.getStatusCode()==200 && httpResp.getStatus() == 'Ok'){
                    responseBody = httpResp.getBody();
                    if(!String.isEmpty(responseBody) && responseBody.length()>2){
                        locationRecord.Verified__c = true;
                        locationUpdateList.add(locationRecord);
                    }else{
                        locationRecord.Verified__c = false;
                    }
                }else{
                    //locationRecord.addError('Incorrect Address');
                    TransactionLogHandler.doHandlerException(httpResp.getBody(),'validateLocationAddress');
                }

            }catch(System.CalloutException ex){
                TransactionLogHandler.doHandlerException(ex,'validateLocationAddress');

            }
        }
        update locationUpdateList;
    }
}