@IsTest
public with sharing class AsyncSchedulable_Test {
    @TestSetup
    private static void beforeEach() {
        insert new List<Account>{
                new Account(Name = 'Firma A', Value__c = 0),
                new Account(Name = 'Firma B', Value__c = 10)
        };
    }


    @IsTest
    private static void testSchedule() {
        //when
        Test.startTest();
        System.schedule('AsyncSchedulable', '', new AsyncSchedulable());
        Test.stopTest();


        //then
        List<Account> accounts = [SELECT Id, Name, Value__c FROM Account ORDER BY Name];

        Assert.areEqual('Firma A', accounts[0].Name);
        Assert.areEqual('Firma B', accounts[1].Name);

        Assert.areEqual(10, accounts[0].Value__c);
        Assert.areEqual(20, accounts[1].Value__c);
    }
}
