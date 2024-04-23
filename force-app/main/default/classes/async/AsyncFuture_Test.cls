@IsTest
public with sharing class AsyncFuture_Test {

    @TestSetup
    private static void testSetup() {
        insert new List<Account>{
                new Account(Name = 'Firma A', Value__c = 0),
                new Account(Name = 'Firma B', Value__c = 10)
        };
    }

    @IsTest
    private static void shouldUpdateValueFieldOnAccounts() {
        //given
        List<Account> accounts = [SELECT Id, Value__c FROM Account];


        // ??????????
        //when
        Test.startTest();
        AsyncFuture.futureUpdateAccounts(new Set<Id>{
                accounts[0].Id, accounts[1].Id
        });
        Test.stopTest();

        //then
        accounts = [SELECT Id, Name, Value__c FROM Account ORDER BY Name];

        Assert.areEqual('Firma A', accounts[0].Name);
        Assert.areEqual('Firma B', accounts[1].Name);

        Assert.areEqual(10, accounts[0].Value__c);
        Assert.areEqual(10, accounts[1].Value__c);
    }
}
