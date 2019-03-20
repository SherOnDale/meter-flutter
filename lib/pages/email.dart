import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailController = TextEditingController();
  StreamController<bool> streamController;
  GlobalKey<FormState> formKey;
  Pattern emailPattern;

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<bool>.broadcast();
    formKey = GlobalKey<FormState>();
    emailPattern =
        r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    emailController
      ..addListener(() {
        if (formKey.currentState.validate()) {
          streamController.sink.add(true);
          formKey.currentState.save();
        } else {
          streamController.sink.add(false);
        }
      });
  }

  String validateEmail(String value, Map<String, String> emailErrorMessage) {
    RegExp mailRegex = new RegExp(emailPattern);
    if (value.trim().isEmpty) {
      return emailErrorMessage["enterEmailAddress"];
    } else if (!mailRegex.hasMatch(value.trim()))
      return emailErrorMessage["validEmailAddress"];
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/left-arrow.svg'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: SvgPicture.asset('assets/images/tiny-logo.svg'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    validator: (String email) {
                      return validateEmail(email, {
                        "enterEmailAddress": "E-mail is required",
                        "validEmailAddress": "Valid email address is required"
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle:
                          TextStyle(color: Theme.of(context).disabledColor),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                      errorBorder:  OutlineInputBorder(
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
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/confirm-email',
                                      ModalRoute.withName('/'));
                                }
                              : null,
                          child: Text('Continue'),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
