class ServiceResult<T> {
  final String error;
  final T data;
  const ServiceResult({required this.error, required this.data});

  factory ServiceResult.create({String? error, dynamic data}) {
    return ServiceResult<T>(error: error ?? '', data: data);
  }

  @override
  String toString() => '{error: $error, data: $data}';
}

ServiceResult _parseId(String value) {
  try {
    final int id = int.parse(value);
    if ((id >= 1 && id <= 898) || (id >= 10001 && id <= 10228)) {
      return ServiceResult.create(data: id);
    }
    return ServiceResult.create(error: 'Invalid Id');
  } on FormatException {
    return ServiceResult.create(data: value);
  }
}

ServiceResult _parseString({required String value, String regex = r'^[a-z-]{3,}'}) {
  final RegExp validCharacters = RegExp(regex);
  String formattedString = value.replaceAll(' ', '-');
  if (!validCharacters.hasMatch(formattedString)) {
    return ServiceResult.create(error: 'Invalid name');
  }
  return ServiceResult.create(data: formattedString);
}

ServiceResult pokemonValidator(String value) {
  ServiceResult parseResult = _parseId(value);
  if (parseResult.error != '' || parseResult.data is int) return parseResult;
  parseResult = _parseString(value: parseResult.data);
  return parseResult;
}
