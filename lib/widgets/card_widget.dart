import 'package:flutter/material.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/views/info_view.dart';
import 'package:pokemon_project/models/pokemon_info.dart';

class CardWidget extends StatelessWidget {
  final Pokemon pokemon;
  final PokemonInfo? pokemonInfo;
  const CardWidget({Key? key, required this.pokemon, this.pokemonInfo}) : super(key: key);

  void _navigateToPokemonScreen(Pokemon pokemon, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return InfoView(pokemon: pokemon, pokemonInfo: pokemonInfo);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pokemon.hashAndName),
        trailing: IconButton(
          onPressed: () => _navigateToPokemonScreen(pokemon, context),
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
