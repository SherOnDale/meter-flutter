import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class ConfirmEmailPage extends StatefulWidget {
  final String emailID;
  ConfirmEmailPage({this.emailID});

  @override
  _ConfirmEmailPageState createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {

  void emailOpen() async {
  var emailUrl = "mailto:";
  if(await canLaunch(emailUrl))
      launch(emailUrl);
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.navigateTo(context, Routes.root, clearStack: true);
      },
      child: Scaffold(
        backgroundColor: Color(0xff151F37),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Confirm your Email Address to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Text(
                      "Create an Account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 50.0,
              ),
              SvgPicture.asset('assets/images/email-open.svg'),
              SizedBox(
                height: 40.0,
              ),
              Container(
                child: Text(
                  'Check your Email',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'To confirm your Email address, Tap the button in the email we sent to ',
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 1.5,
                        color: Color(0xff8B9FB1),
                      ),
                    ),
                    TextSpan(
                      text: widget.emailID,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: RaisedButton(
                  onPressed: emailOpen,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Open Email App',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Application.router.navigateTo(context, Routes.details);
                  },
                  child: Text("Skip, I’ll Confirm later",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xff54A0FF))),
                ),
              ),
              Expanded(
                child: SafeArea(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Didn’t recieve the confirmation email? check your spam",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.0, color: Color(0xff7E8CAF)),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text('Resend the Email',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff5AA4FF))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Application.router
                                          .navigateTo(context, Routes.email);
                                    },
                                    child: Text('Try another Email',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color(0xff5AA4FF))),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
