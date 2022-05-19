import 'package:pokemon_project/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

abstract class Interface {
  final List<Pokemon> pokemonList = [];
  final List<Pokemon> _searchResults = [];
  int _start = 0;

  Future<List<Widget>> getPokemon();
  Future<List<Widget>> searchPokemon(String input);

  List<Widget> toWidget(List<Pokemon> pokemon) {
    return pokemon.map<Widget>((e) => CardWidget(pokemon: e)).toList();
  }

  List<Pokemon> _search(String value) {
    String s = value.toLowerCase();
    return pokemonList.where((e) => e.name.contains(s) || (e.id).toString() == s).toList();
  }

  List<Widget> scrollSearchResults() {
    if (_searchResults.length > 20 && _start == searchResults) {
      return [];
    }
    return _iterateSearchResults();
  }

  List<Widget> _iterateSearchResults() {
    final List<Pokemon> newPokemon = [];
    for (Pokemon pokemon in _searchResults.getRange(_start, _end).toList()) {
      _start++;
      newPokemon.add(pokemon);
    }
    return toWidget(newPokemon);
  }

  List<Widget> searchInMemory(String filter) {
    reset();
    if (filter == '') return [];
    _searchResults.addAll(_search(filter));
    return _iterateSearchResults();
  }

  int get searchResults => _searchResults.length;
  int get _end {
    final end = _start + 20;
    return end > searchResults ? searchResults : end;
  }

  /// Resets search results
  void reset() {
    _searchResults.clear();
    _start = 0;
  }
}
