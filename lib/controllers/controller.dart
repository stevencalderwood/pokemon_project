import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

abstract class Controller {
  final List<Pokemon> pokemonList = [];

  static Future<PokemonInfo?> getPokemonInfo({
    required String url,
    Future<Map<String, dynamic>> Function(String) apiCall = Api.getRequest,
  }) async {
    Map<String, dynamic> result = await apiCall(url);
    if (result['error'] != null) return null;
    return PokemonInfo.fromJson(result);
  }

  List<Widget> toWidget(List<Pokemon> pokemon) {
    return pokemon.map<Widget>((e) => CardWidget(pokemon: e)).toList();
  }

  List<Widget> search(String filter) {
    String s = filter.toLowerCase();
    List<Pokemon> list = pokemonList.where((e) => e.name.contains(s) || e.id == s).toList();
    return toWidget(list);
  }
}
