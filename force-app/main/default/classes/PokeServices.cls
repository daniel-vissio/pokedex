public with sharing class PokeServices {
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getAllPokemon(String name, String generation, String type){
        String query;

        String condition ='';
        if (String.isNotBlank(name)){
            condition = 'Name LIKE \''+'%' + name + '%\'';
        }
        if (String.isNotBlank(generation)) {
            if (String.isNotBlank(condition)){
                condition +=' AND Generation__c = ' + generation +'';
            } else {
                condition +=' Generation__c = ' + generation +'';
            }
        }
        
        if (String.isNotBlank(type)) {
            if (String.isNotBlank(condition)){
                condition += ' AND PokeType__c LIKE \''+'%' + type + '%\'';
            } else {
                condition +=  ' PokeType__c LIKE \''+'%' + type + '%\'';
            }
        }

        if (String.isNotBlank(condition)) {
            query =
                'SELECT ExtId__c , Name, PokeType__c, ImageFormula__c, ImageUrl__c, PokeHP__c FROM Pokemon__c WHERE ' +
                condition +
                ' ORDER BY ExtId__c';
        } else {
            query = 'SELECT ExtId__c , Name, PokeType__c, ImageFormula__c, ImageUrl__c, PokeHP__c FROM Pokemon__c  ORDER BY ExtId__c';
        }
        List<Pokemon__c> pokemons = Database.query(query);
        return pokemons;
    }
}