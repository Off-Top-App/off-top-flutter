import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/main.dart';
import 'package:off_top_mobile/login/login.dart';
import 'package:off_top_mobile/settings/settingsPage.dart';
import 'package:off_top_mobile/recordingSession.dart';

import 'routing_constants.dart';

@Deprecated('removed bottomNavigation, this is now un-needed')
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute<void>(builder: (_) => MyApp());
    case LoginRoute:
      return MaterialPageRoute<void>(builder: (_) => const LoginPage());
    case RecordingRoute:
      return MaterialPageRoute<void>(builder: (_) => const RecordingPage());
    case SettingsRoute:
      return MaterialPageRoute<void>(builder: (_) => MySettingsPage());
    default:
      return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
}
