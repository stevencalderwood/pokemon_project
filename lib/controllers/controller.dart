import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';

abstract class Controller {
  static ControllerApi api = ControllerApi();
  static ControllerJson json = ControllerJson();
  static Future<PokemonInfo?> getPokemonInfo({
    required String url,
    Future<Map<String, dynamic>> Function(String) apiCall = Api.getRequest,
  }) async {
    Map<String, dynamic> result = await apiCall(url);
    if (result['error'] != null) return null;
    return PokemonInfo.fromJson(result);
  }
}
