abstract class Constant {
  static const String pokemonAPI = 'https://pokeapi.co/api/v2/pokemon/';
  static const int pokemonMin = 1;
  static const int pokemonMax = 898;

  /// char var: a-z and hyphen (-)
  ///
  /// constraints: hyphen is not allowed in first or last position
  static const String regex = r'^(?!-|.*-$)^[a-z-]+$';
  static const String jsonPath = 'data/pokemon_data.json';
}

abstract class Label {
  static const String appName = 'Pokemon API Project';
  static const String error = 'There was a problem. Please try later';
  static const String invalidId = 'Invalid Id';
  static const String invalidName = 'Invalid name';
  static const String titleFirst = 'Pokemon Project v1';
  static const String titleSecond = 'Pokemon Project v2';
  static const String titleSearch = 'Search Pokemon';
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
  static String resultsNumber({required int displayed, required int total}) => '$displayed of $total results';
}
