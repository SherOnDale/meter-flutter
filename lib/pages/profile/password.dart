import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController passwordController = TextEditingController();
  StreamController<bool> streamController;
  Pattern passwordPattern;
  bool isTextObscured;
  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<bool>.broadcast();
    passwordPattern = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$";
    isTextObscured = true;
    passwordController
      ..addListener(() {
        checkFormStatus();
      });
  }

  void checkFormStatus() {
    String password = passwordController.text.trim();
    RegExp passwordRegex = RegExp(passwordPattern);
    if ((password != null && password.isNotEmpty) &&
        passwordRegex.hasMatch(password)) {
      streamController.sink.add(true);
    } else {
      streamController.sink.add(false);
    }
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
          title: Text(
            'Setup your Profile',
            style: TextStyle(
                color: Color(0xff162038),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(top: 10.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              LinearProgressIndicator(
                value: 0.9,
                backgroundColor: Color(0xffDDE1EB),
                valueColor: AlwaysStoppedAnimation(Color(0xff0B78FF)),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Choose a Password',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: isTextObscured,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff8D93A9)),
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTextObscured = !isTextObscured;
                      });
                    },
                    child: Text(
                      isTextObscured ? 'SHOW' : 'HIDE',
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
                height: 10.0,
              ),
              Container(
                  child: Text(
                'Password must be minimum of 8 character with atleast 1 Uppercase , 1 lowercase and 1 digit',
                style: TextStyle(color: Color(0xff8D93A9), fontSize: 12.0,height: 1.2),
              )),
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
                      onPressed: snapshot.data ? () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Application.router.navigateTo(
                                  context,
                                  Routes.waitingPage);
                      } : null,
                      child: Text('Create an Account',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(height: 1.2),
                    children: [
                      TextSpan(
                        text: 'by using ',
                        style: TextStyle(color: Color(0xff8D93A9),fontSize: 12.0)
                      ),
                      TextSpan(
                        text: 'Meter ',
                        style: TextStyle(color: Color(0xff8D93A9),fontSize: 12.0,fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: 'you must agree to Our ',
                        style: TextStyle(color: Color(0xff8D93A9),fontSize: 12.0)
                      ),
                      TextSpan(
                        text: 'Terms & Condition ',
                        style: TextStyle(color: Color(0xff0B78FF),fontSize: 12.0)
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(color: Color(0xff8D93A9),fontSize: 12.0)
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: Color(0xff0B78FF),fontSize: 12.0)
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
