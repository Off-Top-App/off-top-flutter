import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/main.dart';
import 'package:off_top_mobile/login.dart';
import 'package:off_top_mobile/settings_page.dart';
import 'package:off_top_mobile/recordingSession.dart';

import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (_) => MyApp());
    case LoginRoute:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case RecordingRoute:
      return MaterialPageRoute(builder: (_) => RecordingPage());
    case SettingsRoute:
      return MaterialPageRoute(builder: (_) => MySettingsPage());
    default:
      return MaterialPageRoute(builder: (_) => LoginPage());
  }
}
