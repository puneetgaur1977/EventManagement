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
public with sharing class CustomSearchController {
    @AuraEnabled
    public static string searchRecord(
        String objName,
        String fieldName,
        String searchKey,
        String limitValue
    ){
        String searchKeyword = searchKey + '*';
        String returningQuery = objName+' ( Id,'+fieldName+')';
        String queryResult = 'FIND :searchKeyword IN ALL FIELDS RETURNING '+returningQuery;
        if(!String.isEmpty(limitValue)){
            queryResult = queryResult+' LIMIT '+limitValue;
        }
        List<List<sObject>> sObjectList = Search.query(queryResult);
        return JSON.serialize(sObjectList);
    }
}
