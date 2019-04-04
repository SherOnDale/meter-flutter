import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:meter/routes/application.dart';
import 'package:meter/routes/index.dart';

class Picture extends StatefulWidget {
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  File _image;

  Future getImage(ImageSource imgSrc) async {
    try {
      var image = await ImagePicker.pickImage(source: imgSrc);
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: 512,
        maxHeight: 512,
      );
      setState(() {
        _image = croppedFile ?? _image;
      });
    } catch (e) {}
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
              _image == null
                  ? Container(
                      width: 100.0,
                      height: 100.0,
                      child:
                          SvgPicture.asset('assets/images/pfp-placeholder.svg'),
                    )
                  : Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: FileImage(_image),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                              title: Text("Camera/Gallery"),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    return getImage(ImageSource.gallery);
                                  },
                                  child: const Text('Pick From Gallery'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    return getImage(ImageSource.camera);
                                  },
                                  child: const Text('Take A New Picture'),
                                ),
                              ]);
                        });
                  },
                  child: Text(
                    'Change',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff0B78FF), fontSize: 13.0),
                  ),
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
