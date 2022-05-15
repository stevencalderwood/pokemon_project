import 'package:pokemon_project/constants/constants.dart';

class ServiceResult<T> {
  final String? error;
  final T? data;
  ServiceResult({this.error, this.data});

  @override
  String toString() => '{error: $error, data: $data}';
}

ServiceResult _parseId(String value) {
  try {
    final int id = int.parse(value);
    if ((id >= 1 && id <= 898) || (id >= 10001 && id <= 10228)) {
      return ServiceResult(data: id);
    }
    return ServiceResult(error: 'Invalid Id');
  } on FormatException {
    return ServiceResult(data: value);
  }
}

ServiceResult _parseString({required String value, required String regex}) {
  final RegExp validCharacters = RegExp(regex);
  String formattedString = value.replaceAll(' ', '-');
  if (!validCharacters.hasMatch(formattedString)) {
    return ServiceResult(error: 'Invalid name');
  }
  return ServiceResult(data: formattedString);
}

ServiceResult pokemonValidator({required String value, String regex = Constants.regex}) {
  ServiceResult parseResult = _parseId(value);
  if (parseResult.error != null || parseResult.data is int) return parseResult;
  parseResult = _parseString(value: parseResult.data, regex: regex);
  return parseResult;
}
