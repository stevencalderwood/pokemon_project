import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/widgets/main_widget.dart';

class FirstView extends StatelessWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      action: (value) => Navigator.pushNamed(context, '/v2/'),
      version: ProjectVersion.first,
      controllerApi: ControllerApi(),
    );
  }
}
