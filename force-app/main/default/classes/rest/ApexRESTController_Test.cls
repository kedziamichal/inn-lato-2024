@IsTest
public without sharing class ApexRESTController_Test {
    private static final String ACCOUNT_NAME = 'Test account';
    private static final Integer ACCOUNT_VALUE = 5;

    @IsTest
    private static void testGetMethod() {
        Account account = new Account(Name = ACCOUNT_NAME, Value__c = ACCOUNT_VALUE);
        insert account;


        RestRequest request = new RestRequest();
        request.addParameter('id', account.Id);
        request.requestURI = 'services/apexrest/account';
        RestResponse response = new RestResponse();

        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        ApexRESTController.getAccount();
        Test.stopTest();

        Assert.areEqual(200, response.statusCode);

        String responseBody = response.responseBody.toString();
        ApexRESTController.AccountWrapper accountWrapper =
                (ApexRESTController.AccountWrapper) JSON.deserialize(responseBody, ApexRESTController.AccountWrapper.class);

        Assert.areEqual(account.Name, accountWrapper.name);
        Assert.areEqual(account.Value__c, accountWrapper.value);
    }

    @IsTest
    private static void testPostMethod() {
        ApexRESTController.AccountWrapper accountWrapper = new ApexRESTController.AccountWrapper(ACCOUNT_NAME, ACCOUNT_VALUE);

        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(JSON.serialize(accountWrapper));
        request.requestURI = 'services/apexrest/account';

        RestResponse response = new RestResponse();

        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        ApexRESTController.postAccount();
        Test.stopTest();

        Assert.areEqual(200, response.statusCode);
        Account account = [SELECT Id, Name, Value__c FROM Account LIMIT 1];

        Assert.areEqual(account.Id, response.responseBody.toString());
        Assert.areEqual(account.Name, ACCOUNT_NAME);
        Assert.areEqual(account.Value__c, ACCOUNT_VALUE);
    }
}
