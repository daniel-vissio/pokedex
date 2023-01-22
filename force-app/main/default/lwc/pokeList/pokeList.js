import { LightningElement } from 'lwc';

export default class PokeList extends LightningElement {

    pokemonList = [
        {
            Name: "Pikachu",
            Description: "Rata trueno",
            Image_URL_c: "https://pokefanaticos.com/pokedex/assets/images/pokemon_imagenes/1.png",
            Location__c: "Casa de pablito"
        },
        {
            Name: "Raichu",
            Description: "Rata trueno evolucionada",
            Image_URL_c: "https://pokefanaticos.com/pokedex/assets/images/pokemon_imagenes/26.png",
            Location__c: "Casa de pablito"
        },
        {
            Name: "Charmander",
            Description: "PokePsiquico",
            Image_URL_c: "https://pokefanaticos.com/pokedex/assets/images/pokemon_imagenes/4.png",
            Location__c: "Casa de pablito"
        }
    ];

}