import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';

class ResultsWidget extends StatelessWidget {
  final int total;

  /// Displays the maximum number of Pokemon Widgets the Controller will return.
  const ResultsWidget({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: total > 0 ? Center(child: Text(Label.resultsNumber(total))) : null,
    );
  }
}
