import 'package:flutter/material.dart';
import 'package:off_top_mobile/login.dart';
import 'package:off_top_mobile/routing/router.dart' as router;
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/tabs.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9Z2FoZnxha3xhY2Fjc2JiaWZlaWdlcwMeaDImOzE8PRM0PjI6P30wPD4=');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*onGenerateRoute: router.generateRoute,
      title: 'Login Page',
      initialRoute: LoginRoute,*/
      title: 'Login Page',
      home: LoginPage(), //changed route to the login page as it's home page
    );
  }
}
