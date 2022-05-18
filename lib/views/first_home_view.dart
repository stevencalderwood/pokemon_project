import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/widgets/home_widget.dart';

class FirstHomeView extends StatelessWidget {
  const FirstHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeWidget(controllerApi: Provider.fullApi);
  }
}
