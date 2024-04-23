public with sharing class ApexRESTService {

    public static RequestResponseWrapper sendGetRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:SFCredential/services/apexrest/animals?id=11');

        Http http = new Http();
        HttpResponse response = http.send(request);

        String requestBody = response.getBody();
        RequestResponseWrapper wrapper = (RequestResponseWrapper) JSON.deserialize(requestBody, RequestResponseWrapper.class);
        wrapper.print();
        return wrapper;
    }

    public static String sendPostRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SFCredential/services/apexrest/animals');
        request.setHeader('Content-Type', 'application/json');

        RequestResponseWrapper wrapper = new RequestResponseWrapper();
        wrapper.status = 'Nowy Status';
        wrapper.photo = null;
        wrapper.name = 'REST POST MEthod"';
        wrapper.id = '';
        wrapper.description = '';
        wrapper.breed = null;
        wrapper.age = 40;
        request.setBody(JSON.serialize(wrapper));

        Http http = new Http();

        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
        return response.getBody();
    }
}