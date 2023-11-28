@IsTest
public without sharing class ApexRESTController_Test {


    @IsTest
    private static void testGetMethod() {
        Account account = new Account(Name = 'Test account', Value__c = 5);
        insert account;


        RestRequest request = new RestRequest();
        request.addParameter('id', account.Id);
        request.requestURI = 'services/apexrest/account';
        RestResponse response = new RestResponse();

        RestContext.request = request;
        RestContext.response = response;

        test.startTest();
        ApexRESTController.getAccount();
        Test.stopTest();

        Assert.areEqual(200,response.statusCode );
        Assert.areEqual('{"value":5,"name":"Test account"}' , response.responseBody.toString());

    }


}
