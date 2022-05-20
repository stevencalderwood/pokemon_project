// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/pokemon_info.dart';
import 'package:pokemon_project/services/api.dart';
import 'package:pokemon_project/services/validator.dart';
import 'package:pokemon_project/models/service_result.dart';
import 'package:flutter/material.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final List<String> values = ['0', '1', 'aa', 'abc', 'a/cdg', '01ff', '--ff', '-f-', 'abu-abu'];
  final List<bool> error = [true, false, false, false, true, true, true, true, false];
  final List<Type> dataTypes = [Null, int, String, String, Null, Null, Null, Null, String];
  group('data types return from serviceResult', () {
    test('serviceResult errors', () {
      for (int i = 0; i < values.length; i++) {
        final ServiceResult result = Validator.validatePokemon(input: values[i]);
        expect(result.error != null, error[i]);
      }
    });
    test('check regex against all pokemon names', () async {
      ControllerJson controller = ControllerJson();
      await controller.getPokemon();
      final List<Pokemon> allPokemon = controller.pokemonList;
      for (Pokemon pokemon in allPokemon) {
        print(pokemon.name);
        final ServiceResult result = Validator.validatePokemon(input: pokemon.name);
        expect(result.error, null);
      }
      // final ServiceResult result = Validator.validatePokemon(input: "2porygon2");
      // expect(result.error, null);
    });
    test('serviceResult data', () {
      for (int i = 0; i < values.length; i++) {
        final ServiceResult result = Validator.validatePokemon(input: values[i]);
        expect(result.data.runtimeType, dataTypes[i]);
      }
    });
    test('test api error', () async {
      final ServiceResult result = await Api.getRequest('https://pokeapi.co/api/v2/pokemon/bul');
      expect(result.error != null, true);
    });
    test('test api success', () async {
      final ServiceResult result = await Api.getRequest('https://pokeapi.co/api/v2/pokemon/bulbasaur');
      expect(result.data != null, true);
    });
    test('test single pokemon api call', () async {
      final PokemonInfo? result = await Api.getPokemonInfo(url: 'https://pokeapi.co/api/v2/pokemon/bulbasaur');
      expect(result != null, true);
      expect(result!.height, 7);
    });
    test('test api call first 20 pokemon', () async {
      final ControllerApi controller = Provider.controllerApi;
      final List<Widget> results = await controller.getPokemon();
      expect(results.length, 20);
      // expect(controller.url, 'https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20');
    });
    test('check pokemon values returned from the API', () async {
      for (int i = 1; i <= Constant.pokemonMax; i++) {
        print(i);
        final PokemonInfo? info = await Api.getPokemonInfo(url: '${Constant.pokemonAPI}$i');
        expect(info != null, true);
        print('waiting for next...');
        await Future.delayed(const Duration(seconds: 2));
      }
    });
    test('catching a failed null check', () async {
      late final PokemonInfo pokemon;
      bool error = false;
      PokemonInfo? pokemonInfo;
      String url = 'fake url';
      try {
        pokemon = (pokemonInfo?.copyWith() ?? await Api.getPokemonInfo(url: url))!;
      } catch (e) {
        print(e);
        error = true;
      }
      expect(error, true);
    });
  });
}
