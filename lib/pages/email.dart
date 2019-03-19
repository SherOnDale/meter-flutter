import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailPage extends StatefulWidget {
  bool changed = false;
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailController = TextEditingController();
  bool changed = false;

  @override
  void initState() {
    super.initState();
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
            !widget.changed
                ? Text('', style: TextStyle(fontSize: 12.0))
                : Text(
                    'Email Address',
                    style: TextStyle(fontSize: 12.0, color: Color(0xff8D93A9)),
                  ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              onChanged: (value) {
                widget.changed = true;
                print(widget.changed);
                print(value);
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Email Address',
                hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffDDE1EB), width: 1.0)),
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
                disabledTextColor: Colors.white,
                onPressed: emailController.text == ''
                    ? null
                    : () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            '/confirm-email', ModalRoute.withName('/'));
                      },
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
