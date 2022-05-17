import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/version.dart';

void infoDialog({required BuildContext context, required ProjectVersion version}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(version == ProjectVersion.first ? Label.titleFirst : Label.titleSecond),
        content: Text(version == ProjectVersion.first ? Label.designFirst : Label.designSecond),
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
