import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/widgets/home_widget.dart';
import 'package:pokemon_project/models/version.dart';

class SecondHomeView extends StatelessWidget {
  const SecondHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      action: (value) => Navigator.pop(context),
      version: ProjectVersion.second,
      controllerJson: Provider.json,
    );
  }
}
