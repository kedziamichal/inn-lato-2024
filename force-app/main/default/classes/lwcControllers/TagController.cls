public with sharing class TagController {
    @AuraEnabled
    public static void saveTags(String recordId, String tags) {
        update new Contact(Id = recordId, Tags__c = tags);
    }
}