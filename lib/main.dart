import 'package:flutter/material.dart';
import 'package:off_top_mobile/routing/router.dart' as router;
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmggJzYlNj0+MiEiJjYpYmpqaxM0PjI6P30wPD4=');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      title: 'Login Page',
      initialRoute: LoginRoute,
    );
  }
}
