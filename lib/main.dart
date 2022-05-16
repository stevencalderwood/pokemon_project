import 'package:flutter/material.dart';
import 'package:pokemon_project/views/home_view.dart';
import 'package:pokemon_project/views/second_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon API Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/v1/',
      routes: {
        '/v1/': (context) => const HomeView(),
        '/v2/': (context) => const SecondView(),
      },
    );
  }
}
