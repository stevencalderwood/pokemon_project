import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_project/services/api.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/models/service_result.dart';
import 'package:pokemon_project/widgets/card_widget.dart';
import 'package:pokemon_project/models/pokemon_info.dart';

class ControllerApi extends Controller {
  bool noResults = false;
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

  /// First makes an API call looking for an exact match.
  ///
  /// If no pokemon is found checks for a partial match inside the object memory.
  ///
  /// NOTE: This could lead to multiple results depending on the user activity.
  Future<List<Widget>> searchPokemon(String search) async {
    reset();
    final String url = '${Constant.pokemonAPI}$search';
    final PokemonInfo? result = await Controller.getPokemonInfo(url: url);
    if (result != null) {
      return [CardWidget(pokemon: result.subCopy(), pokemonInfo: result)];
    }
    final List<Widget> memoryResult = super.searchFromMemory(search);
    if (memoryResult.isEmpty) {
      noResults = true;
      return [];
    }
    return memoryResult;
  }

  @override
  void reset() {
    noResults = false;
    super.reset();
  }
}
