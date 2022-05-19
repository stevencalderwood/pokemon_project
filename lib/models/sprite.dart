class Sprite {
  final String? front;
  final String? back;

  const Sprite({required this.front, required this.back});

  //TODO: some pokemon may not have a front or back sprite and having a null value
  factory Sprite.fromJson(Map<String, dynamic> json) {
    return Sprite(
      front: json['front_default'],
      back: json['back_default'],
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
