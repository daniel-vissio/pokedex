@isTest
global class callPokeCalloutMock implements HttpCalloutMock{

    global HTTPResponse respond (HTTPRequest req){
        HttpResponse res = new HttpResponse(); 
        res.setHeader ('Content-Type', 'application/json'); 
        res.setBody ('{"name": "Bulbasaur", "id": 1,"height": 7,"weight": 69,"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi/v2/ability/65/"}}],"game_indices":[{"game_index":1,"version":{"name":"red-blue","url":"https://pokeapi/v2/version/1/"}}],"types":[{"type":{"name":"grass","url":"https://pokeapi/v2/type/12/"}}],"stats":[{"stat":{"name":"speed","url":"https://pokeapi/v2/stat/6/"}}],"sprites":{"front_default":"http://imgURL"},"stats":[{"base_stat":45},{"base_stat":49},{"base_stat":49},{"base_stat":45},{"base_stat":45},{"base_stat":45}]}');
        res.setStatusCode (200); 

        return res;
    }

}