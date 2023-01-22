public with sharing class callPoke {
        

    public static void getCallPoke() {

        List <PokemonSkill__c> skillDB = [SELECT Id, Name FROM PokemonSkill__c];

        String  pokeName;
        Integer pokeId;
        Double  pokeHeight;
        Double  pokeWeight;

        String pokeSkill;
        //Instancio y accedo a los campos
        Pokemon__c pokemon = new Pokemon__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + 1);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());

            List<Object> abilities = (List<Object>) result.get('abilities');

            Map<String,Object> skill0 = (Map<String, Object>) abilities[0];
            
            Map<String,Object> skill1 = (Map<String, Object>) skill0.get('ability');



            pokeName   = (String) result.get('name');
            pokeId     = (Integer) result.get('id');
            pokeHeight = (Double) result.get('height');
			pokeWeight = (Double) result.get('weight');

            pokeSkill  = (String) skill1.get('name');

            for(PokemonSkill__c a : skillDB){
                if (a.name == pokeSkill) {
                    pokemon.Skills__c = a.id;
                }
            }
        }




        pokemon.name       = pokeName;
        pokemon.ExtId__c   = pokeId;
        pokemon.Height__c  = pokeHeight;


        insert pokemon;
    }
}