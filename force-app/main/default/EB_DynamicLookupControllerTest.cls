@isTest
public with sharing class EB_DynamicLookupControllerTest {
    @isTest
	public static void testSearchRecords() {
		List<String> objectTypes = new List<String>();
		objectTypes.add('Account');
		objectTypes.add('Case');

		Test.startTest();

		EB_DynamicLookupController.searchRecords('Salesforce', objectTypes, JSON.serialize(new Map<String, List<String>>()), JSON.serialize(new Map<String, List<String>>()));

		Test.stopTest();

		//There are no valid tests here as you can't test search
	}

	@isTest
	public static void testSelectClause_ObjectNoId() {
		List<String> objectFields = new List<String>();
		objectFields.add('Subject');
		objectFields.add('Value__c');

		Test.startTest();

		String fieldsClause = EB_DynamicLookupController.generateSelectClause('Case', objectFields);

		Test.stopTest();

		System.assertEquals('Subject,Value__c,Id', fieldsClause);
	}

	@isTest
	public static void testSelectClause_CaseNull() {

		Test.startTest();

		String fieldsClause = EB_DynamicLookupController.generateSelectClause('Case', null);

		Test.stopTest();

		System.assertEquals('Id, Subject', fieldsClause);
	}

	@isTest
	public static void testSelectClause_ObjectNull() {
		Test.startTest();

		String fieldsClause = EB_DynamicLookupController.generateSelectClause('Account', null);


		Test.stopTest();


		System.assertEquals('Id, Name', fieldsClause);
	}

	@isTest
	public static void testWhereClause() {
		List<String> objectFilters = new List<String>();
		objectFilters.add('Id != null');
		objectFilters.add('Name != null');

		Test.startTest();

		String whereClause = EB_DynamicLookupController.generateWhereClause(objectFilters);

		Test.stopTest();

		System.assertEquals(' WHERE Id != null AND Name != null', whereClause);
	}

	@isTest
	public static void testWhereClause_Null() {
		Test.startTest();

		String whereClause = EB_DynamicLookupController.generateWhereClause(null);

		Test.stopTest();

		System.assertEquals('', whereClause);
	}
}
