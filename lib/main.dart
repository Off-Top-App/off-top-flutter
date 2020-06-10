import 'package:flutter/material.dart';
import 'package:off_top_mobile/login.dart';
import 'package:off_top_mobile/routing/router.dart' as router;
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:off_top_mobile/themes/themeSelector.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9Z2FoZnxha3xhY2Fjc2JiaWZlaWdlcwMeaDImOzE8PRM0PjI6P30wPD4=');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  Future<void> getCurrentAppTheme() async {
    themeChangeProvider.theme =
        await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Login Page',
            theme: ThemeSelector.themeData(themeChangeProvider.theme, context),
            home:
                const LoginPage(), //changed route to the login page as it's home page
          );
        },
      ),
    );
  }
}
