import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/interface.dart';
import 'package:pokemon_project/models/pokemon.dart';

class ControllerJson extends Interface {
  final int _maxLength = Constant.pokemonMax;
  bool _isAlphabetic = false;
  int _start = 0;

  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString(Constant.jsonPath);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    for (Map<String, dynamic> entry in jsonMap['results']) {
      pokemonList.add(Pokemon.fromJson(entry));
    }
  }

  @override
  Future<List<Widget>> getPokemon() async {
    if (pokemonList.isEmpty) {
      await _loadJson();
    }
    if (_start == _maxLength) return [];
    final List<Pokemon> newPokemon = [];
    for (Pokemon pokemon in pokemonList.getRange(_start, _end).toList()) {
      _start++;
      newPokemon.add(pokemon);
    }
    return super.toWidget(newPokemon);
  }

  void sortPokemon() {
    _isAlphabetic = !_isAlphabetic;
    if (_isAlphabetic) {
      pokemonList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      pokemonList.sort((a, b) => a.id.compareTo(b.id));
    }
    reset();
  }

  @override
  Future<List<Widget>> searchPokemon(String input) {
    return Future<List<Widget>>.value(super.searchInMemory(input));
  }

  int get _end {
    final end = _start + 20;
    return end > _maxLength ? _maxLength : end;
  }

  bool get isAlphabetic => _isAlphabetic;

  @override
  void reset() {
    _start = 0;
    super.reset();
  }
}
