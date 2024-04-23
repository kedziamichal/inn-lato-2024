@RestResource(UrlMapping='/account/*')
global with sharing class ApexRESTController {

    @HttpGet
    global static void getAccount() {
        RestRequest request = RestContext.request;
        Map<String, String> params = request.params;
        String accountId = params.get('id');

        Account account = [SELECT Id, Name, Value__c, Description FROM Account WHERE Id = :accountId];

        AccountWrapper wrapper = new AccountWrapper(account.Name, account.Value__c);

        RestContext.response.statusCode = 200;
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(wrapper));
    }

    @HttpPost
    global static void postAccount() {
        String jsonBody = RestContext.request.requestBody.toString();
        AccountWrapper wrapper = (AccountWrapper) JSON.deserialize(jsonBody, AccountWrapper.class);

        Account account = new Account(Name = wrapper.name, Value__c = wrapper.value);
        insert account;

        RestContext.response.statusCode = 200;
        RestContext.response.responseBody = Blob.valueOf(account.Id);
    }

    @HttpPut
    global static void putAccount() {

    }

    @HttpPatch
    global static void patchAccount() {

    }

    @HttpDelete
    global static void deleteAccount() {

    }

    public class AccountWrapper {
        public String name;
        public Integer value;

        public AccountWrapper() {
        }

        public AccountWrapper(String name, Decimal value) {
            this.name = name;
            this.value = Integer.valueOf(value);
        }
    }
}
