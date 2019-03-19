import 'package:flutter/material.dart';

import 'package:meter/pages/home.dart';
import 'package:meter/pages/email.dart';
import 'package:meter/pages/confirm-email.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Gilroy',
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          buttonColor: Color(0xff0BB1A1),
          disabledColor: Color(0xffBFC5D0)),
      routes: {
        '/': (_) => MyHomePage(),
        '/email': (_) => EmailPage(),
        '/confirm-email': (_) => ConfirmEmailPage()
      },
    );
  }
}
