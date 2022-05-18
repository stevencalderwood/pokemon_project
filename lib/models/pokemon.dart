class Pokemon {
  final String name;
  final String url;
  const Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Pokemon copyWith({String? name, String? url}) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  int get id => int.parse(url.split('/')[6]);
  String get fullName => '#$id ${name[0].toUpperCase()}${name.substring(1)}';

  @override
  toString() => 'Pokemon(name: $name, url: $url)';
}
