import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/views/first_home_view.dart';
import 'package:pokemon_project/views/first_search_view.dart';
import 'package:pokemon_project/views/second_home_view.dart';
import 'package:pokemon_project/views/second_search_view.dart';

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
        '/v1/': (context) => const FirstHomeView(),
        '/v2/': (context) => const SecondHomeView(),
        '/v1/search/': (context) => const FirstSearchView(),
        '/v2/search/': (context) => const SecondSearchView(),
      },
    );
  }
}
