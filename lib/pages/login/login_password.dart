import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class LoginPassword extends StatefulWidget {
  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  TextEditingController passwordController = TextEditingController();
  StreamController<bool> streamController;
  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<bool>.broadcast();
    passwordController
      ..addListener(() {
        if (passwordController.text.isNotEmpty) {
          streamController.sink.add(true);
        } else {
          streamController.sink.add(false);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/left-arrow.svg'),
            onPressed: () {
              Application.router.pop(context);
            },
          ),
          title: SvgPicture.asset('assets/images/tiny-logo.svg'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(top: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                'What\'s your Password?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Your Accoutn is already existed. Please, enter your Password.',
                style: TextStyle(
                  fontSize: 15.0,
                  height: 1.5
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff8D93A9)),
                  suffix: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot?',
                      style:
                          TextStyle(color: Color(0xff0B78FF), fontSize: 12.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              StreamBuilder(
                stream: streamController.stream,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      onPressed: snapshot.data
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Application.router.navigateTo(
                                  context,
                                  Routes.waitingPage);
                            }
                          : null,
                      child: Text('Login'),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
