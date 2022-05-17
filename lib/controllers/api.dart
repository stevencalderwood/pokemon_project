import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_project/models/service_result.dart';

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
}
