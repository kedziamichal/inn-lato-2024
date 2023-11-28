public with sharing class AsyncBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext param1) {
        System.debug('AsyncBatch - start');
        return Database.getQueryLocator([
                SELECT Id, Value__c
                FROM Account
                WHERE Value__c != NULL
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        System.debug('AsyncBatch - execute ' + scope.size());
        new AccountService().updateAccountValueField(scope, 15);
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('AsyncBatch - finish');
    }
}
