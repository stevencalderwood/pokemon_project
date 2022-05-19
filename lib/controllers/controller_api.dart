import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/interface.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/pokemon_info.dart';
import 'package:pokemon_project/models/service_result.dart';
import 'package:pokemon_project/services/api.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

class ControllerApi extends Interface {
  bool _apiMatch = false;
  String _requestUrl = Constant.pokemonAPI;

  @override
  Future<List<Widget>> getPokemon({Future<ServiceResult> Function(String) apiCall = Api.getRequest}) async {
    if (_requestUrl == '') return [];
    final ServiceResult result = await apiCall(_requestUrl);
    if (result.error != null) return [];
    _requestUrl = result.data['next'] ?? '';
    final List<Pokemon> newPokemon = [];
    for (Map<String, dynamic> pokemon in result.data['results']) {
      newPokemon.add(Pokemon.fromJson(pokemon));
    }
    pokemonList.addAll(newPokemon);
    return super.toWidget(newPokemon);
  }

  @override

  /// First calls the [Api] looking for an exact match.
  ///
  /// If no [PokemonInfo] is found checks for a partial match inside the [Interface] memory.
  /// NOTE: This could lead to multiple results depending on the user activity.
  Future<List<Widget>> searchPokemon(String input) async {
    reset();
    final String url = '${Constant.pokemonAPI}$input';
    final PokemonInfo? result = await Api.getPokemonInfo(url: url);
    if (result != null) {
      _apiMatch = true;
      return [CardWidget(pokemon: result.subCopy(), pokemonInfo: result)];
    }
    final List<Widget> memoryResult = super.searchInMemory(input);
    return memoryResult;
  }

  @override
  int get searchResults {
    if (_apiMatch) return 1;
    return super.searchResults;
  }

  @override
  void reset() {
    _apiMatch = false;
    super.reset();
  }

  bool get partialResult => !_apiMatch;
}
