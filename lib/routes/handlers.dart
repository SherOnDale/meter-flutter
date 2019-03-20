import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


import 'package:meter/pages/home.dart';
import 'package:meter/pages/email.dart';
import 'package:meter/pages/confirm-email.dart';
import 'package:meter/pages/no_account_exists.dart';
import 'package:meter/pages/profile/details.dart';
import 'package:meter/pages/profile/picture.dart';
import 'package:meter/pages/profile/password.dart';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyHomePage();
  },
);

var emailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return EmailPage();
  },
);

var confirmEmailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String emailID =params['email_id'][0].toString();
    return ConfirmEmailPage(emailID: emailID,);
  },
);

var noAccountExistsHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String emailID =params['email_id'][0].toString();
    return NoAccountExists(emailID: emailID,);
  },
);

var detailsHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Details();
  },
);

var pictureHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Picture();
  },
);

var passwordHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Password();
  },
);