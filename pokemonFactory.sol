// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
  }

  struct Ability{
    string name;
    string description;
  }
    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(
      uint newPokemonId,
      string newPokemonName
  );

    modifier validateData(uint _id, string memory _name){
    require(
      _id > 0, "ID debe ser diferente a 0"
    );
    require(
      bytes(_name).length != 0, "Seleccionar nombre"
    );
    _;
  }
     
      function createPokemon (string memory _name, uint _id,  string memory _abilityName, string memory _abilityDescription) public validateData(_id, _name) {
        pokemons.push(Pokemon(_id, _name, _abilityName));
        pokemons.id = _id;
        pokemons.name = _name;
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        addAbility(_abilityName, _abilityDescription);

        emit eventNewPokemon(_id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

   function addAbility(uint _id, string memory _abilityName, string memory _abilityDescription) public {
     pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
   }

}
