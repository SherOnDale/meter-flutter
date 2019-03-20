import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailController = TextEditingController();
  StreamController<bool> streamController;
  Pattern emailPattern;
  RegExp emailRegex;
  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<bool>.broadcast();
    emailPattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    emailRegex =RegExp(emailPattern);
    emailController
      ..addListener(() {
        if (emailRegex.hasMatch(emailController.text.trim())) {
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
        Application.router.navigateTo(context, Routes.root, clearStack: true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/left-arrow.svg'),
            onPressed: () {
              Application.router
                  .navigateTo(context, Routes.root, clearStack: true);
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
                'What\'s your Email?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'We need it to lookup your Account or create a new one.',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Color(0xff8D93A9)),
                  hintStyle:
                      TextStyle(color: Theme.of(context).disabledColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffDDE1EB), width: 1.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffDDE1EB), width: 1.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffDDE1EB), width: 1.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffDDE1EB), width: 1.0)),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              StreamBuilder(
                stream: streamController.stream,
                initialData: false,
                builder:
                    (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
                                  Routes.noAccountExists +
                                      "?email_id=" +
                                      emailController.text.toString());
                            }
                          : null,
                      child: Text('Continue'),
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
