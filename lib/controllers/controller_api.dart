import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:pokemon_project/controllers/controller.dart';

class ControllerApi extends Controller {
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
}
