import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/main_widget.dart';

class SecondView extends StatelessWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      action: (value) => Navigator.pop(context),
      version: ProjectVersion.second,
      controllerJson: ControllerJson(),
    );
  }
}
