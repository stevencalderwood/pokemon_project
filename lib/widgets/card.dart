import 'package:flutter/material.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/views/info_view.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokeCard({Key? key, required this.pokemon}) : super(key: key);

  void _navigateToPokemonScreen(Pokemon poke, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return InfoView(pokemon: poke);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${pokemon.id} ${pokemon.name}'),
        onTap: () => _navigateToPokemonScreen(pokemon, context),
        trailing: const Icon(Icons.star),
      ),
    );
  }
}
