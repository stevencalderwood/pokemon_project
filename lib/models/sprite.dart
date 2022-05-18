class Sprite {
  final String front;
  final String back;

  const Sprite({required this.front, required this.back});

  factory Sprite.fromJson(Map<String, dynamic> json) {
    return Sprite(
      front: json['front_default'] as String,
      back: json['back_default'] as String,
    );
  }

  Sprite copyWith({String? front, String? back}) {
    return Sprite(
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }

  @override
  String toString() => 'Sprite(front: $front, back: $back)';
}
