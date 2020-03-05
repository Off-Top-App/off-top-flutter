import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_top_mobile/main.dart';
import 'package:off_top_mobile/routing_constants.dart';
import 'package:off_top_mobile/websocket.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (_) => MyApp());
    case WebsocketRoute:
      return MaterialPageRoute(builder: (_) => WebsocketPage());
    default:
      return MaterialPageRoute(builder: (_) => MyApp());
  }
}