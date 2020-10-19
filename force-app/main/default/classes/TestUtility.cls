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
@isTest
public class TestUtility {
    public static account prepareAccount(String accName){
        Account acc = new Account(
            Name = accName,
            Description = 'Account With Setup Method',
            Phone = '4849867898',
            Fax = '4849867898'
        );
        return acc;
    }
    public static List<Account> prepareAccount(String accName, Integer numberOfAccounts){
        List<Account> accList = new List<Account>();
        for(Integer numberOfAccount=0; numberOfAccount<=numberOfAccounts;numberOfAccounts++){
            accList.add(new Account(
                Name = accName+' '+ String.valueOf(numberOfAccount),
                Description = 'Account With Setup Method'+' '+ String.valueOf(numberOfAccount),
                Phone = '4849867898',
                Fax = '4849867898'
            ));
        }
        return accList;
    }
    public static Contact prepareContact(String accountId, String firstName, String lastName, String emailAdd){
        
        return new Contact(
            firstName = firstName,
            AccountId = accountId,
            Email = emailAdd,
            LastName = lastName
        );
    }
    public static List<Contact> prepareContact(String accountId, String firstName, String lastName, String emailAdd, Integer recordCount){
        List<Contact> contactList = new List<Contact>();
        for(Integer recordCount = 0; recordCount<)recordCount; recordCount++){
            contactList.add(new Contact(
            firstName = firstName +' '+ String.valueOf(recordCount),
            AccountId = accountId,
            Email = emailAdd,
            LastName = lastName+' '+ String.valueOf(recordCount)
            ));
        }
        return contactList;
    }
}
