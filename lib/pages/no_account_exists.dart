import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class NoAccountExists extends StatefulWidget {
  final String emailID;
  NoAccountExists({this.emailID});
  @override
  _NoAccountExistsState createState() => _NoAccountExistsState();
}

class _NoAccountExistsState extends State<NoAccountExists> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Oops!!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Your Account Doesn't Exist for",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.emailID,
                style: TextStyle(fontSize: 18.0, color: Color(0xff0B78FF)),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Do you want to create an new one?',
                style: TextStyle(fontSize: 15.0, color: Color(0xff162038)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Application.router.navigateTo(context,
                        Routes.confirmEmail + "?email_id=" + widget.emailID);
                  },
                  child: Text('Creat an Account'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
