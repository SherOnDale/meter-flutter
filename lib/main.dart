import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Meter',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Gilroy',
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          buttonColor: Color(0xff0BB1A1),
          disabledColor: Color(0xffBFC5D0)),
      onGenerateRoute: Application.router.generator,
    );
  }
}
