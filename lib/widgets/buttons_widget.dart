import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';

class ButtonsWidget extends StatelessWidget {
  final ScrollController scrollController;
  final void Function()? sort;
  final bool? isAlphabetic;
  const ButtonsWidget({Key? key, required this.scrollController, required this.sort, required this.isAlphabetic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ScrollTopButton(scrollController: scrollController),
        if (sort != null) _SortButtonWidget(sort: sort!, isAlphabetic: isAlphabetic!),
      ],
    );
  }
}

class _SortButtonWidget extends StatelessWidget {
  final bool isAlphabetic;
  final void Function() sort;
  const _SortButtonWidget({Key? key, required this.isAlphabetic, required this.sort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: sort,
      child: Text(isAlphabetic ? Label.sortById : Label.sortByName),
    );
  }
}

class _ScrollTopButton extends StatelessWidget {
  final ScrollController scrollController;
  const _ScrollTopButton({Key? key, required this.scrollController}) : super(key: key);

  void _scrollTop() {
    if (scrollController.offset > 0) {
      scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _scrollTop, child: const Text(Label.scrollTop));
  }
}
