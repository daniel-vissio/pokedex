@isTest
private  class movementsPokeClassTest {
    @isTest
    static void endPoinRequestTest(){
        
        Test.setMock(HttpCalloutMock.class, new movementsPokeCalloutMock());

        Integer movementsNumber = 1;
        HttpResponse response =  movementsPokeClass.endPointRequest(movementsNumber);
        String expectedBody = '{"name": "test", "id": 1, "accuracy": 100, "effect_chance": 50, "target": {"name": "targetTest"}, "priority": 0, "effect_entries":[{"short_effect":"test effect"}], "power": 10, "pp": 20, "type":{"name":"ice","url":"https://pokeapi.co/api/v2/type/15/"}}';
        String notExpectedBody = response.getBody();

        System.assertEquals(200, response.getStatusCode());
        System.assertEquals(notExpectedBody, expectedBody);
        
    }
    
        @isTest
    static void movementsPokeClass() {

        Test.startTest();
		
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new movementsPokeCalloutMock());

        Integer movementsNumber = 1;
        
        PokemonMovements__c pokeMove = movementsPokeClass.getMovementsPoke(movementsNumber);

        // Verify response received contains fake values
        System.assertEquals('test', pokeMove.name); 
        System.assertEquals(1, pokeMove.ExtId__c);  
        System.assertEquals(100, pokeMove.Accuracy__c);  
        System.assertEquals(50, pokeMove.ChanceEffect__c);  
        System.assertEquals('targetTest', pokeMove.TargetName__c);  
        System.assertEquals(0, pokeMove.Priority__c);  
        System.assertEquals('test effect', pokeMove.Effect__c);  
        System.assertEquals(10, pokeMove.Power__c);


        Test.stopTest();
    }
    
    
        @isTest
		static void insertMovePokeTest() {
        
        Test.setMock(HttpCalloutMock.class, new movementsPokeCalloutMock());
        Integer pokeNumber = 1;
			
        //Call the method to test 
        movementsPokeClass.insertMovePoke(pokeNumber);

        //Asserts to validate the results 
        System.assertEquals(1, [SELECT COUNT() FROM PokemonMovements__c]);        
    }
    
    
    
    @isTest
    static void getbashTest() { 										  
    	//Call the method to test 
        Test.setMock(HttpCalloutMock.class, new movementsPokeCalloutMock());
        movementsPokeClass.getbashm(); 

    	//Asserts to validate the results  
        System.assertEquals(2, [SELECT COUNT() FROM PokemonMovements__c]);  
    }
    
    
    
    
    @isTest
	static void deleteMovementsTest(){

    Test.setMock(HttpCalloutMock.class, new movementsPokeCalloutMock());
    Integer movementsNumber = 1;
    PokemonMovements__c pokeMove = movementsPokeClass.getMovementsPoke(movementsNumber);
        
    Test.startTest();
        movementsPokeClass.deleteMovements();
    Test.stopTest();

    System.assertEquals(0, [SELECT COUNT() FROM PokemonMovements__c]); 
} 
    
    

}