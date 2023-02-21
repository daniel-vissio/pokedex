@isTest
public class PokeServicesTest{
    @isTest
    static void getAllPokemonTest(){
       // Test.setMock(HttpCalloutMock.class, new servicesCalloutMock());
        //Call the method 
        List<Pokemon__c> pokemons = PokeServices.getAllPokemon('Pikachu', '1', 'grass');
		List<Pokemon__c> allPokemons = PokeServices.getAllPokemon('', '', '');
        
        //Verify the results 
        System.assertEquals(0, pokemons.size());
        //Si no coloco nada me traera los 850 pokes
        System.assertNotEquals(850, allPokemons.size());
        
    }
}