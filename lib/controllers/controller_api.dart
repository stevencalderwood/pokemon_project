import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/interface.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/pokemon_info.dart';
import 'package:pokemon_project/models/service_result.dart';
import 'package:pokemon_project/services/api.dart';
import 'package:pokemon_project/widgets/card_widget.dart';

/// Class for the App first version
///
/// It has the methods [getPokemon], [searchPokemon] and [reset].
class ControllerApi extends Interface {
  /// Value needed to know if the return of the [searchPokemon] method is from the API or the memory.
  bool _apiMatch = false;

  /// Value need to know what to display next when the user is scrolling the main feed.
  String _requestUrl = Constant.pokemonAPI;

  @override

  /// Make an API call to full pokemon based on the variable [_requestUrl].
  /// Accordingly it also manages the scroll action in the [HomeView].
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

  /// Used to clear user search history
  void reset() {
    _apiMatch = false;
    super.reset();
  }

  @override

  /// When the [searchPokemon] returns a result from the [Api], it will always be one.
  ///
  /// The super class [searchInMemory] won't be called and its [searchResults] would be zero.
  int get searchResults {
    if (_apiMatch) return 1;
    return super.searchResults;
  }

  /// TRUE (Default) : if the search result comes from memory.
  ///
  /// FALSE: if it comes from an API call.
  bool get isPartialResult => !_apiMatch;
}
