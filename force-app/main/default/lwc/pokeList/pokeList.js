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
		{ label : 'Todos', value: ''},
		{ label : 'Bug (Bicho)', value: 'Bug'},
		{ label : 'Dark (Oscuro)', value: 'Dark'},
		{ label : 'Dragon (Dragón)', value: 'Dragon'},
		{ label : 'Electric (Eléctrico)', value: 'Electric'},
		{ label : 'Fairy (Hada)', value: 'Fairy'},
		{ label : 'Fighting (Luchador)', value: 'Fighting'},
		{ label : 'Fire (Fuego)', value: 'Fire'},
		{ label : 'Flying (Volador)', value: 'Flying'},
		{ label : 'Ghost (Fantasma)', value: 'Ghost'},
		{ label : 'Grass (Planta)', value: 'Grass'},
		{ label : 'Ground (Tierra)', value: 'Ground'},
		{ label : 'Ice (Hielo)', value: 'Ice'},
		{ label : 'Normal (Normal)', value: 'Normal'},
		{ label : 'Poison (Veneno)', value: 'Poison'},
		{ label : 'Psychic (Psíquico)', value: 'Psychic'},
		{ label : 'Rock (Roca)', value: 'Rock'},
		{ label : 'Steel (Acero)', value: 'Steel'},
		{ label : 'Water (Agua)', value: 'Water'}
	]
    
	generationOptions = [
        { label: 'Todas', value: ''},
        { label: 'Generación 1', value: '1' },
        { label: 'Generación 2', value: '2' },
        { label: 'Generación 3', value: '3' },
        { label: 'Generación 4', value: '4' },
        { label: 'Generación 5', value: '5' },
        { label: 'Generación 6', value: '6' },
        { label: 'Generación 7', value: '7' },
        { label: 'Generación 8', value: '8' }
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