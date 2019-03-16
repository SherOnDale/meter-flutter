import 'package:flutter/material.dart';

import 'package:meter/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {'/': (_) => MyHomePage()},
    );
  }
}
