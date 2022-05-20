import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';

void infoDialog({required BuildContext context, required bool isFirstVersion}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(Label.titleHome(isFirstVersion)),
        content: Text(isFirstVersion ? Label.designFirst : Label.designSecond),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(Label.haveFun),
          ),
        ],
      );
    },
  );
}
