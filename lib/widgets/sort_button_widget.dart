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

// class SortButtonWidget extends StatefulWidget {
//   final void Function(bool) sort;
//   const SortButtonWidget({Key? key, required this.sort}) : super(key: key);
//
//   @override
//   State<SortButtonWidget> createState() => _SortButtonWidgetState();
// }
//
// class _SortButtonWidgetState extends State<SortButtonWidget> {
//   bool _isAlphabetic = false;
//
//   void _sort() {
//     _isAlphabetic = !_isAlphabetic;
//     widget.sort(_isAlphabetic);
//   }
//
//   /// Il controller permane anche quando si esce dalla pagina
//   /// mentre questo widget viene distrutto perdendo il suo stato
//   /// ciò crea una discrepanza tra l'ordine della lista e il nome del bottone
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: _sort,
//       child: Text(_isAlphabetic ? Label.sortById : Label.sortByName),
//     );
//   }
// }
