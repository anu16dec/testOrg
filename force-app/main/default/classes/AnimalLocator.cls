Public class AnimalLocator
{
    Public static String getAnimalNameById(Integer animalId)
    {
        String animalName;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getBody() +'|||||||||||||||||||||||||||');
        system.debug('<<<<<<<<<<<<<<<'+response.getStatusCode());
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            //Deserialize the JSON string into collections of primitive data types.
            JSON2Apex an= (JSON2Apex) JSON.deserialize(response.getBody(),JSON2Apex .class);
            System.debug('**************'+an);
              animalName = an.animal.Name;
        }
        
        return animalName;
        
    }
    
    
}