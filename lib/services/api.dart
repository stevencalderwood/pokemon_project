import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_project/models/service_result.dart';
import 'package:pokemon_project/models/pokemon_info.dart';

abstract class Api {
  /// Makes a GET request to any [url] passed to the function.
  ///
  /// Returns a [ServiceResult] with the data or the error if it fails.
  static Future<ServiceResult> getRequest(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final http.Response response = await http.get(uri);
      final Map<String, dynamic> decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return ServiceResult<Map<String, dynamic>>(data: decoded);
    } catch (e) {
      return ServiceResult(error: e.toString());
    }
  }

  static Future<PokemonInfo?> getPokemonInfo({required String url, Function apiCall = Api.getRequest}) async {
    final ServiceResult result = await apiCall(url);
    if (result.error != null) return null;
    return PokemonInfo.fromJson(result.data as Map<String, dynamic>);
  }
}
