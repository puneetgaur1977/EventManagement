/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 01-01-2021
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   01-01-2021   gaur.puneet@outlook.com   Initial Version
**/
@RestResource(urlMapping='/v1/futurevent')
global class EventManager {
    public EventManager() {
        //services/apexrest/v1/futurevent
        /*
        *Put,Get,Post,Patch
        */
    
    }
    @httpGet
    global static String upcomingEvents(){
        return 'Hello There';
    }
    @httpPost
    global static String postEvent(){
        return 'Hello Post';
    }
}
