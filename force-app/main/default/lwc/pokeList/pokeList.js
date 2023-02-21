import { LightningElement, track, wire } from 'lwc';
import getAllPokemon from '@salesforce/apex/PokeServices.getAllPokemon';

export default class PokeList extends LightningElement {

    name = "";
    generation = "";
    type = "";
    @track pokemonList;
    error;
    @wire(getAllPokemon, {name: '$name', generation:'$generation', type:'$type'})
    wiredPokemons({error, data}){
        if(data){
            this.pokemonList = data;
        }
    }

	typeOptions = [
		{ label : 'All', value: ''},
		{ label : 'Bug', value: 'Bug'},
		{ label : 'Dark', value: 'Dark'},
		{ label : 'Dragon', value: 'Dragon'},
		{ label : 'Electric', value: 'Electric'},
		{ label : 'Fairy', value: 'Fairy'},
		{ label : 'Fighting', value: 'Fighting'},
		{ label : 'Fire', value: 'Fire'},
		{ label : 'Flying', value: 'Flying'},
		{ label : 'Ghost', value: 'Ghost'},
		{ label : 'Grass', value: 'Grass'},
		{ label : 'Ground', value: 'Ground'},
		{ label : 'Ice', value: 'Ice'},
		{ label : 'Normal', value: 'Normal'},
		{ label : 'Poison', value: 'Poison'},
		{ label : 'Psychic', value: 'Psychic'},
		{ label : 'Rock', value: 'Rock'},
		{ label : 'Steel', value: 'Steel'},
		{ label : 'Water', value: 'Water'}
	]
    
	generationOptions = [
        { label: 'All', value: ''},
        { label: 'Generatión 1', value: '1' },
        { label: 'Generatión 2', value: '2' },
        { label: 'Generatión 3', value: '3' },
        { label: 'Generatión 4', value: '4' },
        { label: 'Generatión 5', value: '5' },
        { label: 'Generatión 6', value: '6' },
        { label: 'Generatión 7', value: '7' },
        { label: 'Generatión 8', value: '8' }
]


    handleInputChange(event){
        const searchPokes = event.target.value;
        if(searchPokes.length >= 2 || searchPokes === ""){
            this.name = searchPokes;
        }
    }
    
    handleGenerationChange(event){
        this.generation = event.target.value;
        
    }
        
    handleTypeChange(event){
        this.type = event.target.value;
        
    }
}