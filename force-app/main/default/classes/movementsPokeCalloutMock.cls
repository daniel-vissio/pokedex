@isTest
global class movementsPokeCalloutMock implements HttpCalloutMock{

    global HTTPResponse respond (HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"name": "test", "id": 1, "accuracy": 100, "effect_chance": 50, "target": {"name": "targetTest"}, "priority": 0, "effect_entries":[{"short_effect":"test effect"}], "power": 10, "pp": 20, "type":{"name":"ice","url":"https://pokeapi.co/api/v2/type/15/"}}');
        res.setStatusCode(200);

        return res;
    }
}