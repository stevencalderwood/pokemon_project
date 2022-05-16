import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:flutter/material.dart';

class ControllerJson extends Controller {
  late final int _maxLength;
  int _start = 0;

  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString('data/pokemon_data.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _maxLength = jsonMap['count'] as int;
    for (Map<String, dynamic> entry in jsonMap['results']) {
      pokemonList.add(Pokemon.fromJson(entry));
    }
  }

  Future<List<Widget>> getPokemon() async {
    if (pokemonList.isEmpty) {
      await _loadJson();
    }
    final List<Pokemon> newPokemon = [];
    if (_end == _maxLength) return [];
    for (Pokemon pokemon in pokemonList.getRange(_start, _end).toList()) {
      _start++;
      newPokemon.add(pokemon);
    }
    return super.toWidget(newPokemon);
  }

  int get _end {
    final end = _start + 20;
    return end > _maxLength ? _maxLength : end;
  }
}
