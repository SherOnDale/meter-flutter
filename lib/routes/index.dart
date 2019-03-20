import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'handlers.dart';

class Routes {
  static String root = "/";
  static String email = "/email";
  static String confirmEmail = "/confirm_email";
  static String noAccountExists = "/no_account_exists";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(email, handler: emailHandler);
    router.define(confirmEmail,handler: confirmEmailHandler);
    router.define(noAccountExists,handler: noAccountExistsHandler);
  }
}
