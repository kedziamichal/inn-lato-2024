public with sharing class AccountService {

    public void updateAccountValueField(List<Account> accounts, Integer value) {
        for (Account account : accounts) {
            account.Value__c = value;
        }
        update accounts;
    }
}
