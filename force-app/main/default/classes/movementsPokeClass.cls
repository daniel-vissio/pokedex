public with sharing class movementsPokeClass {
    public static PokemonMovements__c getMovementsPoke(Integer movementsNumber) {
        
        String  movementsName;
        Integer movementsId;
        Integer movementsAccuracy;
        Integer  movementsEffChance;
        String  movementsTargetName;
        Integer movementsPriority;
        String  movementsEffect;
        Integer movementsPower;
        Integer movementsPp;
        String  movementsType;




        //Instancio y accedo a los campos
        PokemonMovements__c pokeMove = new PokemonMovements__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/' + movementsNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());

            Map<String,Object> pokeMovess = (Map<String,Object>) result.get('target');

            List<Object> effectpoke = (List<Object>) result.get('effect_entries');
            Map<String,Object> shortEffect = (Map<String, Object>) effectpoke[0];

            Map<String,Object> typepoke = (Map<String,Object>) result.get('type');


            movementsName       = (String)  result.get('name');
            movementsId         = (Integer) result.get('id');
            movementsAccuracy   = (Integer) result.get('accuracy');
            movementsEffChance  = (Integer)  result.get('effect_chance');
            movementsTargetName = (String)  pokeMovess.get('name');
            movementsPriority   = (Integer) result.get('priority');
            movementsEffect     = (String)  shortEffect.get('short_effect');
            movementsPower      = (Integer) result.get('power');
            movementsPp         = (Integer) result.get('pp');
            movementsType       = (String)  typepoke.get('name'); 

            


        }

        pokeMove.name               = movementsName;
        pokeMove.ExtId__c           = movementsId;
        pokeMove.Accuracy__c        = movementsAccuracy;
        pokeMove.ChanceEffect__c    = movementsEffChance;
        pokeMove.TargetName__c      = movementsTargetName;
        pokeMove.Priority__c        = movementsPriority;
        pokeMove.Effect__c          = movementsEffect;
        pokeMove.Power__c           = movementsPower;
        pokeMove.PP__c              = movementsPp;
        pokeMove.TypeName__c        = movementsType;


        return pokeMove;
    }


    public static void insertMovePoke(Integer i) {
        PokemonMovements__c pokeMv = getMovementsPoke(i);
        insert pokeMv;
    }

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