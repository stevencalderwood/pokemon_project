import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';

class SortButtonWidget extends StatelessWidget {
  final bool isAlphabetic;
  final void Function() sort;
  const SortButtonWidget({Key? key, required this.isAlphabetic, required this.sort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: sort,
      child: Text(isAlphabetic ? Label.sortById : Label.sortByName),
    );
  }
}
