import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:flutter/material.dart';

class ControllerJson extends Controller {
  final int _maxLength = Constant.pokemonMax;
  int _start = 0;

  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString('data/pokemon_data.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    for (Map<String, dynamic> entry in jsonMap['results']) {
      pokemonList.add(Pokemon.fromJson(entry));
    }
  }

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

  int get _end {
    final end = _start + 20;
    return end > _maxLength ? _maxLength : end;
  }
}
