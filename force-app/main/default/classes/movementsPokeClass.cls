public with sharing class movementsPokeClass {

    public static PokemonMovements__c getMovementsPoke(Integer movementsNumber) {
        
        //Instancio y accedo a los campos
        PokemonMovements__c pokeMove = new PokemonMovements__c();
        HttpResponse resp = endPointRequest(movementsNumber);
        

        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());

            Map<String,Object> pokeMovess = (Map<String,Object>) result.get('target');

            List<Object> effectpoke = (List<Object>) result.get('effect_entries');
            Map<String,Object> shortEffect = (Map<String, Object>) effectpoke[0];

            Map<String,Object> typepoke = (Map<String,Object>) result.get('type');

            pokeMove.name       = (String)  result.get('name');
            pokeMove.ExtId__c         = (Integer) result.get('id');
            pokeMove.Accuracy__c   = (Integer) result.get('accuracy');
            pokeMove.ChanceEffect__c  = (Integer)  result.get('effect_chance');
            pokeMove.TargetName__c = (String)  pokeMovess.get('name');
            pokeMove.Priority__c   = (Integer) result.get('priority');
            pokeMove.Effect__c     = (String)  shortEffect.get('short_effect');
            pokeMove.Power__c      = (Integer) result.get('power');
            pokeMove.PP__c         = (Integer) result.get('pp');
            pokeMove.TypeName__c   =(String)typepoke.get('name'); 

        }
        return pokeMove;
    }

    public static HttpResponse endPointRequest(Integer movementsNumber){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/' + movementsNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
            return resp;
    }

    //Insert only one movement
    public static void insertMovePoke(Integer i) {
        PokemonMovements__c pokeMv = getMovementsPoke(i);
        insert pokeMv;
    }
    //Insert multis movements
    public static void getbashm() {
        List<PokemonMovements__c> pokeMov = new List<PokemonMovements__c>();
        for(Integer i =1 ;i<=2;i++){
            PokemonMovements__c movePokemon = getMovementsPoke(i);
            pokeMov.add(movePokemon);
        }
        insert pokeMov;

    }

    //Delete all movements :D
    public static void deleteMovements(){
        
        delete [SELECT Id FROM PokemonMovements__c];
        }

}