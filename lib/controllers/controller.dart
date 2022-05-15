import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card.dart';

abstract class Controller {
  static Service home = Service();
}

class Service {
  final List<Pokemon> _pokemonList = [];
  String _requestUrl = Constants.allPokemonAPI;

  static Future<List> getPokemonInfo(
      {required String url, Future<Map<String, dynamic>> Function(String) apiCall = Api.getRequest}) async {
    Map<String, dynamic> result = await apiCall(url);
    if (result['error'] != null) return [];
    return [PokemonInfo.fromJson(result)];
  }

  Future<List<Widget>> getPokemon({Future<Map<String, dynamic>> Function(String) apiCall = Api.getRequest}) async {
    if (_requestUrl == '') return [];
    Map<String, dynamic> result = await apiCall(_requestUrl);
    if (result['error'] != null) return [];
    _requestUrl = result['next'] ?? '';
    final List<Pokemon> newPokemon = [];
    for (Map<String, dynamic> pokemon in result['results']) {
      newPokemon.add(Pokemon.fromJson(pokemon));
    }
    _pokemonList.addAll(newPokemon);
    return _toWidget(newPokemon);
  }

  List<Widget> _toWidget(List<Pokemon> pokemon) {
    return pokemon.map<Widget>((e) => PokeCard(pokemon: e)).toList();
  }

  List<Widget> search(String filter) {
    String s = filter.toLowerCase();
    List<Pokemon> list = _pokemonList.where((e) => e.name.contains(s) || e.id.startsWith(s)).toList();
    return _toWidget(list);
  }

  List<Pokemon> get pokemonList => List<Pokemon>.unmodifiable(<Pokemon>[..._pokemonList]);
}
