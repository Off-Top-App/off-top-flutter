import 'package:flutter/material.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';

class AppBarBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      showSelectedLabels: true, 
      backgroundColor: Colors.deepPurple, 
      items: [
        new BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 30.0),
              onPressed: () => Navigator.pushNamed(context, RecordingRoute)),
          title: Text('Home'),
          backgroundColor: Colors.white),
        new BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt,
            color: Colors.white,
            size: 30.0,
          ),
          title: Text('Reports'),
          backgroundColor: Colors.white),
        new BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 30.0),
              onPressed: () => Navigator.pushNamed(context, SettingsRoute),
            ),
            title: Text('Settings'),
            backgroundColor: Colors.white),
      ]
    );
  }
}
