import 'package:flutter/material.dart';
import 'package:off_top_mobile/login.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/settings_page.dart';

class Tabs extends StatelessWidget {
  Tabs(this.homePage);
  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            homePage,
            RecordingPage(),
            MySettingsPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.white,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(
                Icons.receipt,
                size: 30.0,
                color: Colors.white,
              ),
              text: 'Reports',
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.white,
              ),
              text: 'Settings',
            ),
          ],
          labelPadding: const EdgeInsets.all(5.0),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.white,
          //indicatorWeight: 0.00001,
        ),
      ),
    );
  }
}
