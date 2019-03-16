import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 1,
          ),
          Center(
            child: Text('A Revolution Backed by Energy'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: RaisedButton(
              onPressed: () => {Navigator.pushNamed(context, '/email')},
              child: Text('Continue with email'),
            ),
          )
        ],
      ),
    );
  }
}
