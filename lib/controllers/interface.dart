import 'package:pokemon_project/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

/// It stores all the Pokemon and handle all the search functionalities.
///
/// Provides the methods [toWidget], [searchInMemory] and [scrollSearchResults].
abstract class Interface {
  /// All the pokemon loaded based on the user's activity.
  final List<Pokemon> pokemonList = [];

  /// All the results obtained from the current search input.
  final List<Pokemon> _searchResults = [];

  /// Start index for the search results list.
  int _startSearchResults = 0;

  /// Main method for the [HomeView]
  Future<List<Widget>> getPokemon();

  /// Main method for the [SearchView]
  Future<List<Widget>> searchPokemon(String input);

  /// Converts Pokemon objects into [CardWidget].
  /// Maximum should be 20.
  List<CardWidget> toWidget(List<Pokemon> pokemon) {
    return pokemon.map<CardWidget>((e) => CardWidget(pokemon: e)).toList();
  }

  /// Returns the next 20 search results or what is left.
  List<CardWidget> scrollSearchResults() {
    if (_searchResults.length > 20 && _startSearchResults == searchResults) {
      return [];
    }
    return _iterateSearchResults();
  }

  /// Search inside the object memory and returns [CardWidget] for the Pokemon found.
  /// If the results are more than 20, use [scrollSearchResults] to get the next [CardWidget].
  List<CardWidget> searchInMemory(String filter) {
    reset();
    if (filter == '') return [];
    _searchResults.addAll(_search(filter));
    return _iterateSearchResults();
  }

  /// Search in the object memory where the input is contained in a Pokemon name or is equal to a Pokemon Id.
  List<Pokemon> _search(String value) {
    String s = value.toLowerCase();
    return pokemonList.where((e) => e.name.contains(s) || (e.id).toString() == s).toList();
  }

  /// Handle the range of [_searchResults] to convert in [CardWidget]
  /// when [searchInMemory] or [scrollSearchResults] are called.
  List<CardWidget> _iterateSearchResults() {
    final List<Pokemon> newPokemon = [];
    for (Pokemon pokemon in _searchResults.getRange(_startSearchResults, _endSearchResults).toList()) {
      _startSearchResults++;
      newPokemon.add(pokemon);
    }
    return toWidget(newPokemon);
  }

  /// Total number of the current search results
  int get searchResults => _searchResults.length;

  /// End index for the search results list
  int get _endSearchResults {
    final end = _startSearchResults + 20;
    return end > searchResults ? searchResults : end;
  }

  /// Resets search results
  void reset() {
    _searchResults.clear();
    _startSearchResults = 0;
  }
}
