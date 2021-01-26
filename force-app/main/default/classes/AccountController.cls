/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 01-25-2021
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   01-25-2021   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class AccountController {
    public String accountId{get;set;}
    public Account actObj{get;set;}
    public AccountController() {
        actObj = new Account();
    }  
    @AuraEnabled(cacheable=true)    
    public static List<Account> getAccounts(){
        return [select id,name,type,phone,industry from Account limit 10];
    }
    @AuraEnabled
    public static List<Account> getAccountRecordsList(){
        return [select id,name,type,phone,industry from Account limit 10];
    }
    public pageReference retrieveAccountDetail(){
        if(accountId!=null){
             actObj = [select id,name,type,industry from Account where id=:accountId];
            
        }       
		return null;        
    }

}