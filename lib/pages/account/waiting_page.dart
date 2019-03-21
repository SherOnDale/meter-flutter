import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class WaitingPage extends StatefulWidget {
  final String emailID;
  WaitingPage({this.emailID});

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  void emailOpen() async {
    var emailUrl = "mailto:";
    if (await canLaunch(emailUrl)) launch(emailUrl);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.navigateTo(context, Routes.root, clearStack: true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "We'll notify you once your",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xff162038),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Text(
                      "Account is ready",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xff162038),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 40.0,
              ),
              SvgPicture.asset('assets/images/email-new.svg'),
              SizedBox(
                height: 40.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  'people who invite will move up higher on the list to recieve and test the wallet and other new features',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.0, color: Color(0xff8D93A9), height: 1.5),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: RaisedButton(
                  onPressed: () {
                    Application.router.navigateTo(context, Routes.socialList);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      'Send Invites',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
