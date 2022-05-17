import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

abstract class Provider {
  static ControllerApi api = ControllerApi();
  static ControllerJson json = ControllerJson();
}

abstract class Controller {
  final List<Pokemon> pokemonList = [];
  List<Pokemon> _searchResults = [];
  int _start = 0;

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

  List<Pokemon> _search(String value) {
    String s = value.toLowerCase();
    return pokemonList.where((e) => e.name.contains(s) || e.id == s).toList();
  }

  List<Widget> searchFromMemory(String filter) {
    if (filter == '') {
      reset();
      return [];
    }
    if (filter != 'SCROLL') {
      _searchResults = _search(filter);
      _start = 0;
    }
    if (_searchResults.length > 20 && _start == _maxLength) {
      return [];
    }
    final List<Pokemon> newPokemon = [];
    for (Pokemon pokemon in _searchResults.getRange(_start, _end).toList()) {
      _start++;
      newPokemon.add(pokemon);
    }
    return toWidget(newPokemon);
  }

  int get results => _searchResults.length;

  int get _end {
    final end = _start + 20;
    return end > _maxLength ? _maxLength : end;
  }

  int get _maxLength => results;

  void reset() {
    _searchResults = [];
    _start = 0;
  }
}
