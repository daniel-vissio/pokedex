public with sharing class callPoke {
        

    public static Pokemon__c getCallPoke(Integer pokeNumber) {

        List <PokemonSkill__c> skillDB = [SELECT Id, Name FROM PokemonSkill__c];
        //Instancio y accedo a los campos
        Pokemon__c pokemon = new Pokemon__c();
        HttpResponse resp = endPointRequest(pokeNumber);


        if(resp.getStatusCode() == 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());

            List<Object> abilities = (List<Object>) result.get('abilities');
            Map<String,Object> skill0 = (Map<String, Object>) abilities[0];
            Map<String,Object> skill1 = (Map<String, Object>) skill0.get('ability');

            List<Object> height = (List<Object>) result.get('game_indices');

            List<Object> weight = (List<Object>) result.get('types');


            List<Object> stats = (List<Object>) result.get('stats');
            Map<String,Object> php = (Map<String, Object>) stats[0];

            Map<String,Object> pokeSprites = (Map<String,Object>) result.get('sprites');

            List<Object> statsD = (List<Object>) result.get('stats');
            Map<String,Object> pdefense = (Map<String, Object>) statsD[2];

            List<Object> statsA = (List<Object>) result.get('stats');
            Map<String,Object> pAttack = (Map<String, Object>) statsA[1];

            List<Object> statsS = (List<Object>) result.get('stats');
            Map<String,Object> pSpeed = (Map<String, Object>) statsS[5];

            List<Object> types = (List<Object>) result.get('types');
            Map<String,Object> pokeTypes = (Map<String,Object>) types[0];
            Map<String,Object> nameType = (Map<String,Object>) pokeTypes.get('type');
            
            pokemon.name         = (String) result.get('name');
            pokemon.ExtId__c     = (Integer) result.get('id');
            pokemon.Height__c    = (Integer) result.get('height');
			pokemon.Weight__c    = (Integer) result.get('weight');
            pokemon.PokeHP__c    = (Integer) php.get('base_stat');
            pokemon.Defense__c   = (Integer) pdefense.get('base_stat');
            pokemon.Attack__c    = (Integer) pAttack.get('base_stat');
            pokemon.Speed__c     = (Integer) pSpeed.get('base_stat');
            pokemon.PokeType__c  = (String)  nameType.get('name');
            pokemon.ImageUrl__c  = (String) pokeSprites.get('front_default');
            //pokeSkill  = (String) skill1.get('name');

            for(PokemonSkill__c a : skillDB){
                if (a.name == (String) skill1.get('name')) {
                    pokemon.Skills__c = a.id;
                }
            }
        }
        return pokemon;
    }

    public static HttpResponse endPointRequest(Integer pokeNumber){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+ pokeNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
            return resp;
        
    }


    //Insert One Pokemon
    public static void insertPokemon(Integer i) {
        Pokemon__c poke = getCallPoke(i);
        insert poke;
    }

    //Insert Multi Pokemon
    public static void getbash() {
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        for(Integer i =601 ;i<=602;i++){
            Pokemon__c pokemon = getCallPoke(i);
            pokemons.add(pokemon);
        }
        insert pokemons;
    }

    //Delete all Pokemon
    public static void deletePokemons(){
        
        delete [SELECT Id FROM Pokemon__c];
    }
}