public with sharing class skillsPokeClass {
    public static PokemonSkill__c getSkillPoke(Integer skillNumber) {
        
        String  skillName;
        Integer skillId;
        String  skillEffect;


        //Instancio y accedo a los campos
        PokemonSkill__c skill = new PokemonSkill__c();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + skillNumber);
        request.setMethod('GET');
        HttpResponse resp = http.send(request);
        if(resp.getStatusCode()== 200){
            Map<String, Object> result =(Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
            
            skillName   = (String) result.get('name');
            skillId     = (Integer) result.get('id');
            
            List<Object> effects = (List<Object>) result.get('effect_entries');
            Map<String,Object> effects0 = (Map<String, Object>) effects[1];
            
            
            skillEffect = (String) effects0.get('short_effect');


        }

        skill.name       = skillName;
        skill.ExtId__c   = skillId;
        skill.Effect__c  = skillEffect;

        return skill;
    }
    
        public static void insertSkillPoke(Integer i) {
        PokemonSkill__c pokeSk = getSkillPoke(i);
        insert pokeSk;
        }
    
        public static void getbashs() {
        List<PokemonSkill__c> pokemSkill = new List<PokemonSkill__c>();
        for(Integer i =231 ;i<=233;i++){
            PokemonSkill__c skillpokemon = getSkillPoke(i);
            pokemSkill.add(skillpokemon);
        }
        insert pokemSkill;

    	}
    
    public static void deleteSkill(){
        
    delete [SELECT Id FROM PokemonSkill__c];
    }
}


