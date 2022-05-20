import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/interface.dart';
import 'package:pokemon_project/models/pokemon.dart';

/// Class for the App second version.
///
/// It has the methods [getPokemon], [searchPokemon] and [reset].
class ControllerJson extends Interface {
  /// Value to keep track of the sort method of the [pokemonList].
  bool _isAlphabetic = false;

  /// Value need to know what to display next when the user is scrolling the main feed.
  int _start = 0;

  @override

  /// When this method is called for the absolute first time the local Json is loaded.
  ///
  /// Using the [_start] property and the getter [_end] it will be able to determine
  /// which portion of the [pokemonList] to return.
  ///
  /// Accordingly it also manages the scroll action in the [HomeView].
  Future<List<Widget>> getPokemon() async {
    if (pokemonList.isEmpty) {
      await _loadJson();
    }
    if (_start == Constant.pokemonMax) return [];
    final List<Pokemon> newPokemon = [];
    for (Pokemon pokemon in pokemonList.getRange(_start, _end).toList()) {
      _start++;
      newPokemon.add(pokemon);
    }
    return super.toWidget(newPokemon);
  }

  /// This class won't actually make API calls but relies entirely on the local memory.
  @override
  Future<List<Widget>> searchPokemon(String input) {
    return Future<List<Widget>>.value(super.searchInMemory(input));
  }

  /// Used when the [HomeView] is disposed to correctly restart form the top when the page is initialized again.
  @override
  void reset() {
    _start = 0;
    super.reset();
  }

  /// It will sort the [PokemonList] by name if [isAlphabetic] is false.
  ///
  /// Otherwise by Id.
  void sortPokemon() {
    _isAlphabetic = !_isAlphabetic;
    if (_isAlphabetic) {
      pokemonList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      pokemonList.sort((a, b) => a.id.compareTo(b.id));
    }
    reset();
  }

  /// Performed only when the [pokemonList] is empty.
  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString(Constant.jsonPath);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    for (Map<String, dynamic> entry in jsonMap['results']) {
      pokemonList.add(Pokemon.fromJson(entry));
    }
  }

  /// Returns [_start] + 20 until it reaches the value of [Constant.pokemonMax].
  int get _end {
    final end = _start + 20;
    return end > Constant.pokemonMax ? Constant.pokemonMax : end;
  }

  /// Use to check in what order the Pokemon list is given to the UI.
  ///
  /// By default it's ordered by Id.
  bool get isAlphabetic => _isAlphabetic;
}
