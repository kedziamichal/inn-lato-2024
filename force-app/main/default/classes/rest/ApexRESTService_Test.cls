@IsTest
global with sharing class ApexRESTService_Test {
    private static final String NAME = 'Test Name';
    private static final String DESCRIPTION = 'Test Description';
    private static final String FAKE_ID = '1234abcd';


    global class AnimalMockGet implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest param1) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);

            RequestResponseWrapper responseWrapper = new RequestResponseWrapper();
            responseWrapper.name = NAME;
            responseWrapper.description = DESCRIPTION;

            response.setBody(JSON.serialize(responseWrapper));

            return response;
        }
    }

    global class AnimalMockPost implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest param1) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(FAKE_ID);
            return response;
        }
    }

    @IsTest
    private static void testGetMethod() {
        Test.setMock(HttpCalloutMock.class, new AnimalMockGet());

        Test.startTest();
        RequestResponseWrapper responseWrapper = ApexRESTService.sendGetRequest();
        Test.stopTest();

        Assert.areEqual(NAME, responseWrapper.name);
        Assert.areEqual(DESCRIPTION, responseWrapper.description);
    }

    @IsTest
    private static void testPostMethod() {
        Test.setMock(HttpCalloutMock.class, new AnimalMockPost());

        Test.startTest();
        String id = ApexRESTService.sendPostRequest();
        Test.stopTest();

        Assert.areEqual(FAKE_ID, id);
    }
}
