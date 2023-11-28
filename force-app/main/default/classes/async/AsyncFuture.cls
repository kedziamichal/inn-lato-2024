public with sharing class AsyncFuture {

    public static void updateAccounts(List <Account> accounts) {
        Set<Id> accountIds = new Set<Id>();
        for (Account account : accounts) {
            if (account.Value__c != null) {
                accountIds.add(account.Id);
            }
        }

        futureUpdateAccounts(accountIds);
    }

    @Future
    public static void futureUpdateAccounts(Set<Id> accountIds) {
        List<Account> accounts = [SELECT Id, Value__c FROM Account WHERE Id IN :accountIds];
        new AccountService().updateAccountValueField(accounts, 10);
    }











//    @Future(Callout=true)
//    public static void futureCallout(Set<Id> accountIds) {
//        callout
//    }


//    @Future
//    public static void futureZFuture(Set<Id> accountIds) {
//        futureUpdateAccounts(new Set<Id>());
//    }
}
