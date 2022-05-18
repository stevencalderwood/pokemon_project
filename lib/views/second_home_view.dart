import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/widgets/home_widget.dart';

class SecondHomeView extends StatelessWidget {
  const SecondHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeWidget(controllerJson: Provider.json);
  }
}
