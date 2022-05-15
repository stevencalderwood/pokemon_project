import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Api {
  static Future<Map<String, dynamic>> getRequest(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final http.Response response = await http.get(uri);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
