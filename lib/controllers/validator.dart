import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/service_result.dart';

abstract class Validator {
  static ServiceResult _parseId(String value) {
    try {
      final int id = int.parse(value);
      if (id >= Constant.pokemonMin && id <= Constant.pokemonMax) {
        return ServiceResult<int>(data: id);
      }
      return const ServiceResult(error: Label.invalidId);
    } on FormatException {
      return ServiceResult<String>(data: value);
    }
  }

  static ServiceResult _parseString({required String value, required String regex}) {
    final RegExp validCharacters = RegExp(regex);
    String formattedString = value.replaceAll(' ', '-');
    if (!validCharacters.hasMatch(formattedString)) {
      return const ServiceResult(error: Label.invalidName);
    }
    return ServiceResult<String>(data: formattedString);
  }

  /// Perform necessary controls before using the [input] as parameter for the API Call.
  ///
  /// First tries to parse the input as int, if successful then checks if range is valid according to
  /// [Constant.pokemonMin] & [Constant.pokemonMax].
  ///
  /// Otherwise validate the input using the [Constant.regex].
  ///
  /// NOTE: It will replace blank spaces with hyphen.
  static ServiceResult validatePokemon({required String input, String regex = Constant.regex}) {
    ServiceResult parseResult = _parseId(input);
    if (parseResult.error != null || parseResult.data is int) return parseResult;
    parseResult = _parseString(value: parseResult.data, regex: regex);
    return parseResult;
  }
}
