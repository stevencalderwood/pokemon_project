import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';

/// Allows to create references to the same controller's instance everywhere in the App.
abstract class Provider {
  static ControllerApi controllerApi = ControllerApi();
  static ControllerJson controllerJson = ControllerJson();
}
