import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/pushNotifications/pushNotificationsManager.dart';
import 'package:off_top_mobile/login.dart';
import 'package:off_top_mobile/themes/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmggJzYlNj0+MiEiJjYpYmpqaxM0PjI6P30wPD4=');
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
    themeChangeProvider.primaryColor =
        await themeChangeProvider.themePreference.getPrimaryTheme() ??
            0xFF9505E3;
    themeChangeProvider.secondaryColor =
        await themeChangeProvider.themePreference.getSecondaryTheme() ??
            0xFFFAFAFA;
    themeChangeProvider.accentColor =
        await themeChangeProvider.themePreference.getAccentTheme() ??
            0xFF3D393B;
    themeChangeProvider.backgroundColor =
        await themeChangeProvider.themePreference.getBackgroundTheme() ??
            0xFFFFFFFF;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Login Page',
            theme: ThemeData(
              primaryColor: Color(themeChangeProvider.primaryColor),
              secondaryHeaderColor: Color(themeChangeProvider.secondaryColor),
              accentColor: Color(themeChangeProvider.accentColor),
              backgroundColor: Color(themeChangeProvider.backgroundColor),
            ),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
