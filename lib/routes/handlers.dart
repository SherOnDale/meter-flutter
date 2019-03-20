import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


import 'package:meter/pages/home.dart';
import 'package:meter/pages/email.dart';
import 'package:meter/pages/confirm-email.dart';
import 'package:meter/pages/no_account_exists.dart';

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