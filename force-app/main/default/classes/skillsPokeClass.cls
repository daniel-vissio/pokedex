public with sharing class skillsPokeClass {
    public static void getSkillPoke() {
        
        String  pokeName;
        Integer pokeId;


        //Instancio y accedo a los campos
        PokemonSkill__c skill = new PokemonSkill__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + 2);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
            pokeName   = (String) result.get('name');
            pokeId     = (Integer) result.get('id');

        }

        skill.name       = pokeName;
        skill.ExtId__c   = pokeId;


        insert skill;
    }
}


