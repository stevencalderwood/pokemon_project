import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';

void infoDialog({required BuildContext context, required bool isFirstVersion}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(isFirstVersion ? Label.titleFirst : Label.titleSecond),
        content: Text(isFirstVersion ? Label.designFirst : Label.designSecond),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Have fun!"),
          ),
        ],
      );
    },
  );
}
