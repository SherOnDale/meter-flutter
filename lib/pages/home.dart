import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (t) {
      t.cancel();
      // Navigator.pushNamed(context, '/email').then((value) {
      //   startTimer();
      // });
      Application.router.navigateTo(context, Routes.email).then((value) {
        startTimer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                  child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 100.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    'Meter',
                    style: TextStyle(
                        fontSize: 35.0, fontWeight: FontWeight.w800, height: 2.5),
                  ),
                  Text(
                    'A Revolution Backed by Energy',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w800, height: 1.7),
                  ),
                  Text(
                    'Stable, Fast, Secured, Scalable, Investor',
                    style: TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.w200, height: 2),
                  ),
                  Text('Protection',
                      style:
                          TextStyle(fontSize: 13.0, fontWeight: FontWeight.w200)),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
