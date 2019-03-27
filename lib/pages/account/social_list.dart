import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class SocialList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.navigateTo(context, Routes.waitingPage);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/close.svg'),
            onPressed: () {
              Application.router.navigateTo(context, Routes.waitingPage);
            },
          ),
          title: Text(
            'To Add Connection',
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
              Text(
                'Connect your Social Accounts to import contacts.',
                style: TextStyle(fontSize: 15.0, height: 1.5),
              ),
              SizedBox(
                height: 30.0,
              ),
              SocialLayout(
                title: 'Google',
                assetPath: 'assets/images/google.svg',
              ),
              SocialLayout(
                title: 'Facebook',
                assetPath: 'assets/images/fb.svg',
              ),
              SocialLayout(
                title: 'LinkedIn',
                assetPath: 'assets/images/linkedin.svg',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLayout extends StatelessWidget {
  final String assetPath;
  final String title;
  SocialLayout({@required this.title, @required this.assetPath});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Application.router.navigateTo(context, Routes.connectionList);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDDE1EB), width: 1.0),
                borderRadius: BorderRadius.circular(2.0)),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                  child: SvgPicture.asset(assetPath),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 40.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff5E657E),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
