abstract class Constant {
  static const String pokemonAPI = 'https://pokeapi.co/api/v2/pokemon/';
  static const int pokemonMin = 1;
  static const int pokemonMax = 898;

  /// char var: a-z, 0-9 and hyphen (-)
  /// constraints:
  /// hyphen is not allowed in first or last position
  /// numbers are not allowed in the first position
  static const String regex = r'^(?![0-9-]|.*-$)^[a-z0-9-]+$';
  static const String jsonPath = 'data/pokemon_data.json';
}

abstract class Label {
  static const String v1 = 'v1';
  static const String v2 = 'v2';
  static const String appName = 'Pokemon API Project';
  static const String error = 'There was a problem. Please try later';
  static const String invalidId = 'Invalid Id';
  static const String invalidName = 'Invalid name';
  static const String inputHint = 'Please insert name or ID (1-898)';
  static const String pokemonNotFound = 'No pokemon was found';
  static const String maybeLookingFor = 'Maybe you were looking for...';
  static const String designFirst = 'All the data is gathered through API calls.\n'
      'Sadly this comes with some functionality limitations.\n'
      'Please also check out Version 2.';
  static const String designSecond = 'This version loads much faster and has an improved search function.\n'
      'The initial data is taken from a local JSON.\n'
      'While the info about a specific Pokemon comes from the API.';
  static const String sortById = 'SORT BY ID';
  static const String sortByName = 'SORT BY NAME';
  static const String scrollTop = 'SCROLL TO TOP';
  static const String haveFun = 'Have fun!';
  static String titleHome(bool isFirstVersion) => 'Pokemon Project ${isFirstVersion ? v1 : v2}';
  static String titleSearch(bool isFirstVersion) => 'Search Pokemon ${isFirstVersion ? v1 : v2}';
  static String resultsNumber(int total) => '$total ${total == 1 ? 'result' : 'results'}';
}
