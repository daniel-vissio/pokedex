@isTest
global class skillsPokeCalloutMock implements HttpCalloutMock{

    global HTTPResponse respond (HTTPRequest req){
        HttpResponse res = new HttpResponse(); 
        res.setHeader ('Content-Type', 'application/json'); 
        res.setBody ('{"effect_entries":[{"effect":"Whenever a Pokémon.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Damages opponents using leeching moves for as much as they would heal."},{"effect":"Wenn ein Pokémon.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Gegnern die absorbierende."}],"id":64,"name":"liquid-ooze"}');
        res.setStatusCode (200); 

        return res;
    }

}