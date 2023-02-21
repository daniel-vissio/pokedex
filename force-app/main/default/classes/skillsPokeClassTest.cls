@isTest
private class skillsPokeClassTest {

    @isTest
    static void endPoinRequestTest(){
        
        Test.setMock(HttpCalloutMock.class, new skillsPokeCalloutMock());

        Integer skillsNumber = 1;
        HttpResponse response =  skillsPokeClass.endPointRequest(skillsNumber);
        String expectedBody = '{"effect_entries":[{"effect":"Whenever a Pokémon.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Damages opponents using leeching moves for as much as they would heal."},{"effect":"Wenn ein Pokémon.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Gegnern die absorbierende."}],"id":64,"name":"liquid-ooze"}';
        String notExpectedBody = response.getBody();

        System.assertEquals(200, response.getStatusCode());
        System.assertEquals(notExpectedBody, expectedBody);
        
    }


    @isTest
    static void skillsPokeClass() {

        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new skillsPokeCalloutMock());

        Integer skillsNumber = 1;
        
        PokemonSkill__c pokeSkill = skillsPokeClass.getSkillPoke(skillsNumber);

        // Verify response received contains fake values
        System.assertEquals('liquid-ooze', pokeSkill.name); 
        System.assertEquals(64, pokeSkill.ExtId__c); 
        System.assertEquals('Gegnern die absorbierende.', pokeSkill.Effect__c);

        Test.stopTest();
    }
    
        @isTest
		static void insertSkillPokeTest() {
        
        Test.setMock(HttpCalloutMock.class, new skillsPokeCalloutMock());
        Integer skillNumber = 1;
			
        //Call the method to test 
        skillsPokeClass.insertSkillPoke(skillNumber);

        //Asserts to validate the results 
        System.assertEquals(1, [SELECT COUNT() FROM PokemonSkill__c]);        
    }
    
    
        @isTest
    static void getbashTest() { 										  
    	//Call the method to test 
    Test.setMock(HttpCalloutMock.class, new skillsPokeCalloutMock());
    skillsPokeClass.getbashs(); 

    	//Asserts to validate the results  
    System.assertEquals(3, [SELECT COUNT() FROM PokemonSkill__c]);  
    }
    
    
    
    	@isTest
	static void deleteSkillTest() { 
    Test.setMock(HttpCalloutMock.class, new skillsPokeCalloutMock());
    Integer i = 1; 
    PokemonSkill__c pokeSkill = skillsPokeClass.getSkillPoke(i); 
    pokeSkill.name = 'liquid-ooze'; 

    insert pokeSkill;  

    Test.startTest();  
        skillsPokeClass.deleteSkill();  
    Test.stopTest();  

    List<PokemonSkill__c> deleteSkill = [SELECT Id FROM PokemonSkill__c WHERE name = 'liquid-ooze'];  

    System.assertEquals(0, deleteSkill .size());  
	}  

}