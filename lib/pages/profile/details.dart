import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  StreamController<bool> streamController;

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    firstNameController.clear();
    lastNameController.clear();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<bool>.broadcast();
    firstNameController
      ..addListener(() {
        checkFormStatus();
      });
    lastNameController
      ..addListener(() {
        checkFormStatus();
      });
  }

  void checkFormStatus() {
    if (firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty) {
      streamController.sink.add(true);
    } else {
      streamController.sink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Application.router.navigateTo(context, Routes.root, clearStack: true);
      },
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/left-arrow.svg'),
            onPressed: () {
              Application.router.navigateTo(context, Routes.root, clearStack: true);
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
                value: 0.3,
                backgroundColor: Color(0xffDDE1EB),
                valueColor: AlwaysStoppedAnimation(Color(0xff0B78FF)),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'What\'s your Name?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Enter your Full Name',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: firstNameController,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Color(0xff8D93A9)),
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
              TextFormField(
                controller: lastNameController,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Color(0xff8D93A9)),
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
                              Application.router.navigateTo(context, Routes.picture);
                            }
                          : null,
                      child: Text('Next',style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
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
