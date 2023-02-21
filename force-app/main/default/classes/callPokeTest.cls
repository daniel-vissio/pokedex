@isTest
private class callPokeTest {
    @isTest
    static void endPoinRequestTest(){
        
        Test.setMock(HttpCalloutMock.class, new callPokeCalloutMock());

        Integer pokeNumber = 2;
        HttpResponse response =  callPoke.endPointRequest(pokeNumber);
        String expectedBody = '{"name": "Bulbasaur", "id": 1,"height": 7,"weight": 69,"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi/v2/ability/65/"}}],"game_indices":[{"game_index":1,"version":{"name":"red-blue","url":"https://pokeapi/v2/version/1/"}}],"types":[{"type":{"name":"grass","url":"https://pokeapi/v2/type/12/"}}],"stats":[{"stat":{"name":"speed","url":"https://pokeapi/v2/stat/6/"}}],"sprites":{"front_default":"http://imgURL"},"stats":[{"base_stat":45},{"base_stat":49},{"base_stat":49},{"base_stat":45},{"base_stat":45},{"base_stat":45}]}';
        String notExpectedBody = response.getBody();

        System.assertEquals(200, response.getStatusCode());
        System.assertEquals(notExpectedBody, expectedBody);
        
    }
    @isTest
    static void callPokeTest() {

        Test.startTest();
		
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new callPokeCalloutMock());
		List <PokemonSkill__c> skillDB = [SELECT Id, Name FROM PokemonSkill__c];
        Integer pokeNumber = 1;
        Pokemon__c pokemon = callPoke.getCallPoke(pokeNumber);

        // Verify response received contains fake values
        System.assertEquals('Bulbasaur', pokemon.Name);
        System.assertEquals(1, pokemon.ExtId__c);
        System.assertEquals(7, pokemon.Height__c);
		System.assertEquals(69, pokemon.Weight__c);
		System.assertEquals(45, pokemon.PokeHP__c);
		System.assertEquals(49, pokemon.Defense__c);
		System.assertEquals(49, pokemon.Attack__c);
		System.assertEquals(45, pokemon.Speed__c);
		System.assertEquals('grass', pokemon.PokeType__c);
        for(PokemonSkill__c a : skillDB){
                if (a.name == 'overgrow') {
                    System.assertEquals('overgrow', pokemon.Skills__c);
                }
            }

        Test.stopTest();
    }
    
    @isTest
	static void insertPokemonTest() {
        
        Test.setMock(HttpCalloutMock.class, new callPokeCalloutMock());
        Integer pokeNumber = 1;
			
        //Call the method to test 
        callPoke.insertPokemon(pokeNumber);

        //Asserts to validate the results 
        System.assertEquals(1, [SELECT COUNT() FROM Pokemon__c]);        
    }
    @isTest
    static void getbashTest() { 										  
    	//Call the method to test 
        Test.setMock(HttpCalloutMock.class, new callPokeCalloutMock());
        callPoke.getbash(); 

    	//Asserts to validate the results  
        System.assertEquals(2, [SELECT COUNT() FROM Pokemon__c]);  
    }
	@isTest
	static void deletePokemonsTest() { 
    Test.setMock(HttpCalloutMock.class, new callPokeCalloutMock());
    Integer i = 601; 
    Pokemon__c poke = callPoke.getCallPoke(i); 
    poke.name = 'Bulbasaur'; 

    insert poke;  

    Test.startTest();  
        callPoke.deletePokemons();  
    Test.stopTest();  

    List<Pokemon__c> deletedPokemons = [SELECT Id FROM Pokemon__c WHERE name = 'Bulbasaur'];  

    System.assertEquals(0, deletedPokemons .size());  
	}    	
}