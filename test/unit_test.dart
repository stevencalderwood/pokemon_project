import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_project/controllers/api.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/controllers/validator.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/service_result.dart';

void main() {
  final List<String> values = ['0', '1', 'aa', 'abc', 'a/cdg', '01ff', '--ff', '-f-', 'abu-abu'];
  final List<bool> error = [true, false, true, false, true, true, true, true, false];
  final List<Type> dataTypes = [Null, int, Null, String, Null, Null, Null, Null, String];
  group('data types return from serviceResult', () {
    test('serviceResult errors', () {
      for (int i = 0; i < values.length; i++) {
        final ServiceResult result = Validator.validatePokemon(input: values[i]);
        expect(result.error != null, error[i]);
      }
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
      final PokemonInfo? result = await Controller.getPokemonInfo(url: 'https://pokeapi.co/api/v2/pokemon/bulbasaur');
      expect(result != null, true);
      expect(result!.height, 7);
    });
    // test('test api call first 20 pokemon', () async {
    //   final ControllerApi controller = Provider.fullApi;
    //   final List<Widget> results = await controller.getPokemon();
    //   expect(results.length, 20);
    //   expect(controller.url, 'https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20');
    //  // SUCCESS
    // });
  });
}
