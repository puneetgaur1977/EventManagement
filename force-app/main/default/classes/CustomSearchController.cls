/**
 * @description       : 
 * @author            : gaur.puneet@outlook.com
 * @group             : 
 * @last modified on  : 10-19-2020
 * @last modified by  : gaur.puneet@outlook.com
 * Modifications Log 
 * Ver   Date         Author                    Modification
 * 1.0   10-18-2020   gaur.puneet@outlook.com   Initial Version
**/
public with sharing class CustomSearchController {
    @AuraEnabled
    public static string searchRecord(
        String objName,
        String fieldName,
        String searchKey,
        String limitValue
    ){
        System.debug('objName='+objName);
        System.debug('fieldName='+fieldName);
        System.debug('searchKey='+searchKey);
        System.debug('limitValue='+limitValue);
        String searchKeyword = searchKey + '*';
        String returningQuery = objName+' ( Id,'+fieldName+')';
        String queryResult = 'FIND :searchKeyword IN ALL FIELDS RETURNING '+returningQuery;
        if(!String.isEmpty(limitValue)){
            queryResult = queryResult+' LIMIT '+limitValue;
        }
        System.debug('queryResult='+queryResult);
        List<List<sObject>> sObjectList = Search.query(queryResult);
        System.debug('JSON.serialize(sObjectList)='+JSON.serialize(sObjectList));
        return JSON.serialize(sObjectList);
    }
}
