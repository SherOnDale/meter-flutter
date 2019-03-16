import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('What\'s your Email?'),
            Text('We need it to lookup your Account or create a new one.'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            RaisedButton(
              onPressed: () => {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/confirm-email', ModalRoute.withName('/'))
                  },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
