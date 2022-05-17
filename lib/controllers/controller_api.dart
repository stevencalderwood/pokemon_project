import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:pokemon_project/controllers/controller.dart';
import '../widgets/card_widget.dart';

class ControllerApi extends Controller {
  bool noResults = false;
  String _requestUrl = Constant.pokemonAPI;

  Future<List<Widget>> getPokemon({Future<Map<String, dynamic>> Function(String) apiCall = Api.getRequest}) async {
    if (_requestUrl == '') return [];
    Map<String, dynamic> result = await apiCall(_requestUrl);
    if (result['error'] != null) return [];
    _requestUrl = result['next'] ?? '';
    final List<Pokemon> newPokemon = [];
    for (Map<String, dynamic> pokemon in result['results']) {
      newPokemon.add(Pokemon.fromJson(pokemon));
    }
    pokemonList.addAll(newPokemon);
    return super.toWidget(newPokemon);
  }

  /// First makes an API call looking for an exact match.
  ///
  /// If no pokemon is found checks for a partial match inside the object memory.
  ///
  /// NOTE: This could lead to multiple results depending on the user activity.
  Future<List<Widget>> searchPokemon(String search) async {
    noResults = false;
    final String url = '${Constant.pokemonAPI}$search';
    final PokemonInfo? result = await Controller.getPokemonInfo(url: url);
    if (result != null) {
      final Pokemon pokemon = Pokemon(name: result.name, url: '${Constant.pokemonAPI}${result.id}');
      return [CardWidget(pokemon: pokemon, pokemonInfo: result)];
    }
    final List<Widget> memoryResult = super.searchFromMemory(search);
    if (memoryResult.isEmpty) {
      noResults = true;
      return [];
    }
    return memoryResult;
  }
}
