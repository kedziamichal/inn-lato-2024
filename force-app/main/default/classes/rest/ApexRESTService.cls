public with sharing class ApexRESTService {

    public static String sendGetRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:animalsSF/services/apexrest/animals?id=11');

        Http http = new Http();

        HttpResponse response = http.send(request);
        return response.getBody();
    }

    public static void sendPostRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:animalsSF/services/apexrest/animals');
        request.setHeader('Content-Type', 'application/json');
        request.setBody('{\n' +
                '  "status" : "Nowy Status",\n' +
                '  "photo" : null,\n' +
                '  "name" : "REST POST MEthod",\n' +
                '  "id" : null,\n' +
                '  "description" : "desc",\n' +
                '  "breed" : "Dog",\n' +
                '  "age" : 50\n' +
                '}');

        Http http = new Http();

        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
    }

}
