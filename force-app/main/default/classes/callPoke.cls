public with sharing class callPoke {
        

    public static Pokemon__c getCallPoke(Integer pokeNumber) {

        List <PokemonSkill__c> skillDB = [SELECT Id, Name FROM PokemonSkill__c];

        String  pokeName;
        Integer pokeId;
        Integer  pokeHeight;
        Integer  pokeWeight;
        Integer pokeHp;
        String  pokeImage;
        Integer PokeDef;
        String pokeSkill;
        Integer pokeAttack;
        Integer pokeSpeed;
        String pokeType;
        //Instancio y accedo a los campos
        Pokemon__c pokemon = new Pokemon__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+ pokeNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
        if(resp.getStatusCode()== 200){
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
            



            pokeName   = (String) result.get('name');
            pokeId     = (Integer) result.get('id');
            pokeHeight = (Integer) result.get('height');
			pokeWeight = (Integer) result.get('weight');
            pokeHp     = (Integer) php.get('base_stat');
            pokeDef    = (Integer) pdefense.get('base_stat');
            pokeAttack = (Integer) pAttack.get('base_stat');
            pokeSpeed  = (Integer) pSpeed.get('base_stat');
            pokeType   = (String)  nameType.get('name');

            pokeSkill  = (String) skill1.get('name');
            pokeImage   = (String) pokeSprites.get('front_default');


            for(PokemonSkill__c a : skillDB){
                if (a.name == pokeSkill) {
                    pokemon.Skills__c = a.id;
                }
            }
        }




        pokemon.name        = pokeName;
        pokemon.ExtId__c    = pokeId;
        pokemon.Height__c   = pokeHeight;
        pokemon.Weight__c   = pokeWeight;
        pokemon.PokeHP__c   = pokeHp;
        pokemon.ImageUrl__c = pokeImage;
        pokemon.Defense__c  = pokeDef;
        pokemon.Attack__c   = pokeAttack;
        pokemon.Speed__c    = pokeSpeed;
        pokemon.PokeType__c = pokeType;
        


        return pokemon;
        
		
        
    }
    //Insert One
    public static void insertPokemon(Integer i) {
        Pokemon__c poke = getCallPoke(i);
        insert poke;
            }
    //Insert Multi
    public static void getbash() {
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        for(Integer i =1 ;i<=40;i++){
            Pokemon__c pokemon = getCallPoke(i);
            pokemons.add(pokemon);
        }
        insert pokemons;

    }
    //Delete
    public static void deletePokemons(){
        
        delete [SELECT Id FROM Pokemon__c];
    }
}