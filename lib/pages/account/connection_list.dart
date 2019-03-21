import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';

class ConnectionList extends StatefulWidget {
  @override
  _ConnectionListState createState() => _ConnectionListState();
}

class _ConnectionListState extends State<ConnectionList> {
  List<String> selectedNames;
  StreamController<bool> streamController;
  @override
  void initState() {
    super.initState();
    selectedNames = [];
    streamController = StreamController<bool>.broadcast();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/inbox.svg'),
            onPressed: () {
              Application.router.pop(context);
            },
          ),
          title: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Connection Request',
                  style: TextStyle(
                      color: Color(0xff162038),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'You have 34 Connection',
                  style: TextStyle(color: Color(0xff5E657E), fontSize: 12.0),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Center(
                child: Text(
                  'Skip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff0B78FF),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: ConnectionsListLayout(
          selectedNames: selectedNames,
          streamController: streamController,
        ),
        bottomNavigationBar: SafeArea(
          child: BottomAppBar(
            elevation: 0,
            child: Container(
                height: 65.0,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Container(
                        height: 65.0,
                        margin: EdgeInsets.only(left:35.0,right:35.0,bottom:15.0),
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: streamController.stream,
                          initialData: selectedNames.isNotEmpty,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return RaisedButton(
                              child: Text('Request',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: selectedNames.isNotEmpty
                                  ? () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Do you want to send connection request to your social contacts?',
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontSize: 17,
                                                    color: Color(0xff162038),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xff5E657E))),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Yes",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff0088FF),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  : null,
                            );
                          },
                        )))),
          ),
        ),
      ),
    );
  }
}

class ConnectionsListLayout extends StatefulWidget {
  const ConnectionsListLayout(
      {Key key, @required this.selectedNames, @required this.streamController})
      : super(key: key);

  final List<String> selectedNames;
  final StreamController<bool> streamController;

  @override
  _ConnectionsListLayoutState createState() => _ConnectionsListLayoutState();
}

class _ConnectionsListLayoutState extends State<ConnectionsListLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(221, 225, 235, 0.192255),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search for Friends',
                hintStyle: TextStyle(color: Color(0xff8D93A9)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff8D93A9),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xffDDE1EB),
                        width: 1.0,
                        style: BorderStyle.none)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xffDDE1EB),
                        width: 1.0,
                        style: BorderStyle.none)),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(20, (index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    if (!widget.selectedNames
                        .contains('Text${index.toString()}')) {
                      widget.selectedNames.add('Text${index.toString()}');
                    } else {
                      if (widget.selectedNames
                          .contains('Text${index.toString()}')) {
                        widget.selectedNames.remove('Text${index.toString()}');
                      }
                    }
                    widget.streamController.sink
                        .add(widget.selectedNames.isNotEmpty);
                  });
                },
                leading: SvgPicture.asset(
                  'assets/images/pfp-placeholder.svg',
                  height: 40.0,
                  width: 40.0,
                ),
                title: Text(
                  'Text${index.toString()}',
                  style: TextStyle(
                      color: Color(0xff162038),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  child:
                      widget.selectedNames.contains('Text${index.toString()}')
                          ? SvgPicture.asset(
                              'assets/images/checked.svg',
                              height: 20.0,
                              width: 20.0,
                            )
                          : SvgPicture.asset(
                              'assets/images/unchecked.svg',
                              height: 20.0,
                              width: 20.0,
                            ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
