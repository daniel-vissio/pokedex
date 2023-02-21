public with sharing class skillsPokeClass {
    public static PokemonSkill__c getSkillPoke(Integer skillNumber) {

        //Instancio y accedo a los campos
        PokemonSkill__c skill = new PokemonSkill__c();
        HttpResponse resp = endPointRequest(skillNumber);


        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
            
            skill.name      = (String) result.get('name');
            skill.ExtId__c  = (Integer) result.get('id');
            
            List<Object> effects = (List<Object>) result.get('effect_entries');
            Map<String,Object> effects0 = (Map<String, Object>) effects[1];
            
            
            skill.Effect__c = (String) effects0.get('short_effect');

        }

        return skill;
    }

    public static HttpResponse endPointRequest(Integer skillNumber){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + skillNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
            return resp;
    }


    

        //insert one skill
        public static void insertSkillPoke(Integer i) {
        PokemonSkill__c pokeSk = getSkillPoke(i);
        insert pokeSk;
        }
    
        //insert multi skill
        public static void getbashs() {
        List<PokemonSkill__c> pokemSkill = new List<PokemonSkill__c>();
        for(Integer i =231 ;i<=233;i++){
            PokemonSkill__c skillpokemon = getSkillPoke(i);
            pokemSkill.add(skillpokemon);
        }
        insert pokemSkill;
    }
    
    //Delete all Skill
    public static void deleteSkill(){
        
    delete [SELECT Id FROM PokemonSkill__c];
    }
}


