import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class ConnectionList extends StatefulWidget {
  @override
  _ConnectionListState createState() => _ConnectionListState();
}

class _ConnectionListState extends State<ConnectionList> {
  List<String> contactsList, selectedNames;
  StreamController<bool> streamController;
  @override
  void initState() {
    super.initState();
    contactsList = [];
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
        Application.router.navigateTo(context, Routes.waitingPage);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/inbox.svg'),
            onPressed: () {
              Application.router.navigateTo(context, Routes.waitingPage);
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
            GestureDetector(
              onTap: () {
                Application.router.navigateTo(context, Routes.waitingPage);
              },
              child: Container(
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
            ),
          ],
        ),
        body: ConnectionsListLayout(
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
                        margin: EdgeInsets.only(
                            left: 35.0, right: 35.0, bottom: 15.0),
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
                              onPressed: snapshot.data
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
  const ConnectionsListLayout({Key key, @required this.streamController})
      : super(key: key);

  final StreamController<bool> streamController;

  @override
  _ConnectionsListLayoutState createState() => _ConnectionsListLayoutState();
}

class _ConnectionsListLayoutState extends State<ConnectionsListLayout> {
  List<String> contactsList, selectedNames;
  StreamController<String> searchController;
  TextEditingController searchTextController;
  bool hasLoadedContacts;
  Future<bool> futureTask() async {
    bool fetchStatus = false;
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission == PermissionStatus.granted) {
      await loadContacts();
      fetchStatus = true;
    } else {
      await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.contacts);
      if (permission == PermissionStatus.granted) {
        await loadContacts();
        fetchStatus = true;
      }
    }
    setState(() {
      hasLoadedContacts = true;
    });
    return fetchStatus;
  }

  Future<Null> loadContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    if (contacts.isNotEmpty) {
      widget.streamController.sink.add(true);
      contacts.forEach((contact) {
        contactsList.add(contact.displayName);
      });
      contactsList = contactsList.toSet().toList();
      selectedNames = contactsList.toList();
    }
  }

  @override
  void initState() {
    super.initState();
    contactsList = [];
    selectedNames = [];
    hasLoadedContacts = false;
    searchController = StreamController<String>.broadcast();
    searchTextController = TextEditingController(text: '');
    searchTextController
      ..addListener(() {
        searchController.sink.add(searchTextController.text.trim());
      });
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
    searchController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(221, 225, 235, 0.192255),
            child: TextFormField(
              enabled: hasLoadedContacts && contactsList.isNotEmpty,
              controller: searchTextController,
              onFieldSubmitted: (String text) {
                searchController.sink.add(
                    text.trim().isNotEmpty ? text.trim().toLowerCase() : '');
              },
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
          FutureBuilder(
            future: !hasLoadedContacts ? futureTask() : null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Fetching Contacts...',
                            style: TextStyle(
                                color: Color(0xff5E657E), fontSize: 12.0))
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data == false) {
                return Expanded(
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          hasLoadedContacts = false;
                        });
                      },
                      child: Text('Allow Contacts Permission',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              }
              return Expanded(
                child: StreamBuilder(
                    stream: searchController.stream,
                    initialData: searchTextController.text.trim().toLowerCase(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: contactsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data == null ||
                                    snapshot.data.isEmpty
                                ? buildListTile(index)
                                : contactsList[index]
                                        .trim()
                                        .toLowerCase()
                                        .contains(
                                            snapshot.data.trim().toLowerCase())
                                    ? buildListTile(index)
                                    : new Container();
                          });
                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(int index) {
    return ListTile(
      onTap: () {
        setState(() {
          if (selectedNames.contains(contactsList[index])) {
            selectedNames.remove(contactsList[index]);
          } else {
            if (!selectedNames.contains(contactsList[index])) {
              selectedNames.add(contactsList[index]);
            }
          }
          widget.streamController.sink.add(selectedNames.isNotEmpty);
        });
      },
      leading: SvgPicture.asset(
        'assets/images/pfp-placeholder.svg',
        height: 40.0,
        width: 40.0,
      ),
      title: Text(
        contactsList[index],
        style: TextStyle(
            color: Color(0xff162038),
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
      trailing: Container(
        child: selectedNames.contains(contactsList[index])
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
  }
}
