import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/widgets/home_widget.dart';
import 'package:pokemon_project/models/version.dart';

class FirstHomeView extends StatelessWidget {
  const FirstHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      action: (value) => Navigator.pushNamed(context, '/v2/'),
      version: ProjectVersion.first,
      controllerApi: Provider.fullApi,
    );
  }
}
