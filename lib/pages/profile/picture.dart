import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class Picture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
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
                value: 0.6,
                backgroundColor: Color(0xffDDE1EB),
                valueColor: AlwaysStoppedAnimation(Color(0xff0B78FF)),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Upload your Profile Avatar',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'upload your profile picture',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: SvgPicture.asset('assets/images/pfp-placeholder.svg'),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  'Change',textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff0B78FF), fontSize: 13.0),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                                            Application.router.navigateTo(context, Routes.password);

                  },
                  child: Text('Next',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
