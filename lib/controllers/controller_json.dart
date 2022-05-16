import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_project/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/widgets/card.dart';

class ControllerJson {
  final List<Map<String, String>> _jsonData = [];
  late final int _maxLength;
  int _start = 0;

  Future<bool> _loadJson() async {
    try {
      String jsonString = await rootBundle.loadString('data/pokemon_data.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _maxLength = jsonMap['count'] as int;
      for (var entry in jsonMap['results']) {
        _jsonData.add({'name': entry['name'] as String, 'url': entry['url'] as String});
      }
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  List<Widget> _toWidget(List<Pokemon> pokemon) {
    return pokemon.map<Widget>((e) => PokeCard(pokemon: e)).toList();
  }

  Future<List<Widget>> getPokemon() async {
    if (_jsonData.isEmpty) {
      await _loadJson();
    }
    final List<Pokemon> newPokemon = [];
    if (_end == _maxLength) return [];
    for (Map<String, dynamic> pokemon in _jsonData.getRange(_start, _end).toList()) {
      print(pokemon);
      _start++;
      newPokemon.add(Pokemon.fromJson(pokemon));
    }

    return _toWidget(newPokemon);
  }

  int get _end {
    final end = _start + 20;
    return end > _maxLength ? _maxLength : end;
  }
}
