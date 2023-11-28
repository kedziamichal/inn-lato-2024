@IsTest
global with sharing class ApexRESTService_Test {

    global class AnimalMock implements HttpCalloutMock {

        global HttpResponse respond(HttpRequest param1) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('OK');

            return response;
        }
    }


    @IsTest
    private static void testGetMethod() {
        test.setMock(HttpCalloutMock.class, new AnimalMock());

        test.startTest();
        String responseBody = ApexRESTService.sendGetRequest();
        test.stopTest();

        Assert.areEqual('OK', responseBody);
    }
}
