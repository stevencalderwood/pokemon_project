import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/views/home_view.dart';
import 'package:pokemon_project/views/search_view.dart';
import 'package:pokemon_project/views/second_view.dart';

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
        '/v1/': (context) => const FirstView(),
        '/v2/': (context) => const SecondView(),
        '/v1/search/': (context) => const SearchViewFirst(),
        '/v2/search/': (context) => const SearchViewSecond(),
      },
    );
  }
}
