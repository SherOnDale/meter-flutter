import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'handlers.dart';

class Routes {
  static String root = "/";
  static String email = "/email";
  static String confirmEmail = "/confirm_email";
  static String noAccountExists = "/no_account_exists";
  static String details = "/details";
  static String picture = "/picture";
  static String password = "/password";
  static String loginPassword = "/login_password";
  static String waitingPage = "/waiting_page";
  static String socialList = "/social_list";
  static String connectionList = "/connection_list";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(email, handler: emailHandler);
    router.define(confirmEmail, handler: confirmEmailHandler);
    router.define(noAccountExists, handler: noAccountExistsHandler);
    router.define(details, handler: detailsHandler);
    router.define(picture, handler: pictureHandler);
    router.define(password, handler: passwordHandler);
    router.define(loginPassword, handler: loginPasswordHandler);
    router.define(waitingPage, handler: waitingPageHandler);
    router.define(socialList, handler: socialListHandler);
    router.define(connectionList, handler: connectionListHandler);
  }
}
