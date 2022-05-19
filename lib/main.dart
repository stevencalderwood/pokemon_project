import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/views/home_view.dart';
import 'package:pokemon_project/views/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Label.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/v1/',
      routes: {
        '/v1/': (context) => HomeView(controllerApi: Provider.controllerApi),
        '/v1/search/': (context) => SearchView(controllerApi: Provider.controllerApi),
        '/v2/': (context) => HomeView(controllerJson: Provider.controllerJson),
        '/v2/search/': (context) => SearchView(controllerJson: Provider.controllerJson),
      },
    );
  }
}
