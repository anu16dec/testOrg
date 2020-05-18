global class ProjectCalloutServiceMockFailure implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest requestVal) {
        HttpResponse responseVal = new HttpResponse();
        responseVal.setHeader('Content-Type', 'application/json');
        responseVal.setStatusCode(204);
        return responseVal;
    }
}