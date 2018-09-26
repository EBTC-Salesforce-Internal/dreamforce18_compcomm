public with sharing class EB_DynamicLookupController {
	@AuraEnabled
    public static List<SObject> searchRecords(String term, List<String> objectTypes, String objectFieldsString,  String objectFiltersString){
        Map<String, List<String>> objectFields = (Map<String, List<String>>) JSON.deserialize(objectFieldsString, Map<String, List<String>>.class);
        Map<String, List<String>> objectFilters = (Map<String, List<String>>) JSON.deserialize(objectFiltersString, Map<String, List<String>>.class);

        String searchString = 'FIND {' + term + '} IN ALL FIELDS RETURNING';
        for(String objectType:objectTypes){
            searchString += ' ' + objectType + '(';
            searchString += generateSelectClause(objectType, objectFields.get(objectType));
            searchString += generateWhereClause(objectFilters.get(objectType));
            searchString += '),';
        }
        searchString = searchString.removeEnd(',');
        //8 is arbitrary. Can be whatever (probably configurable).
        searchString += ' LIMIT 8';
            
        List<List<SObject>> results = Search.query(searchString);
        
        List<SObject> finalResults = new List<SObject>();
        for(List<SObject> resultList:results){
            finalResults.addAll(resultList);
        }
        
        return finalResults;
    }

    public static String generateSelectClause(String objectType, List<String> objectFields){
        if(objectFields == null){
            //TODO Should use the nameField attribute
            if(objectType == 'Task' || objectType == 'Event' || objectType == 'Case'){
                return 'Id, Subject';   
            }else{
                return 'Id, Name';   
            }
        }else{
            if(objectFields.contains('Id') == false){
                objectFields.add('Id');
            }
            return String.join(objectFields, ',');
        }
    }

    public static String generateWhereClause(List<String> objectFilters){
        if(objectFilters == null){
            return '';
        }

        return ' WHERE ' + String.join(objectFilters, ' AND ');
    }
}
