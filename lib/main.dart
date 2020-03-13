import 'package:flutter/material.dart';
import 'package:off_top_mobile/routing_constants.dart';
import 'router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      title: 'title',
      initialRoute: LoginRoute,
    );
  }
}
