import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';

///
abstract class Provider {
  static ControllerApi controllerApi = ControllerApi();
  static ControllerJson controllerJson = ControllerJson();
}
