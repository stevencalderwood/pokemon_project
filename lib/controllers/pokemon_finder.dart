import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/service_result.dart';

ServiceResult _parseId(String value) {
  try {
    final int id = int.parse(value);
    if ((id >= 1 && id <= 898) || (id >= 10001 && id <= 10228)) {
      return ServiceResult<int>(data: id);
    }
    return const ServiceResult(error: Label.invalidID);
  } on FormatException {
    return ServiceResult<String>(data: value);
  }
}

ServiceResult _parseString({required String value, required String regex}) {
  final RegExp validCharacters = RegExp(regex);
  String formattedString = value.replaceAll(' ', '-');
  if (!validCharacters.hasMatch(formattedString)) {
    return const ServiceResult(error: Label.invalidName);
  }
  return ServiceResult<String>(data: formattedString);
}

ServiceResult pokemonValidator({required String value, String regex = Constant.regex}) {
  ServiceResult parseResult = _parseId(value);
  if (parseResult.error != null || parseResult.data is int) return parseResult;
  parseResult = _parseString(value: parseResult.data, regex: regex);
  return parseResult;
}
