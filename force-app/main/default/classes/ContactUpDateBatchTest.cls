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
public  class ContactUpDateBatchTest {
    @TestSetup
    static void setupData(){
        Account acc = TestUtility.prepareAccount('Srishti Gaur');
        Insert acc;
        List<Contact> contactList = TestUtility.prepareContact(acc.Id, 'Puneet','Gaur','gaur.puneet@outlook.com',20);
        Insert contactList;
    }
    public static TestMethod void batchContacttest(){
        Test.startTest();
            Id batchId = Database.executeBatch(new ContactUpDateBatch(),20);
        Test.stopTest();
    }
}
