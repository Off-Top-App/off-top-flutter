import 'package:flutter/material.dart';
import 'package:off_top_mobile/login/login.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/settingsPage.dart';

class BottomNavigationTabs extends StatelessWidget {
  const BottomNavigationTabs(this.homePage);
  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            homePage,
            const RecordingPage(),
            MySettingsPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(
                Icons.receipt,
                size: 30.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              text: 'Reports',
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              text: 'Settings',
            ),
          ],
          labelPadding: const EdgeInsets.all(5.0),
          labelColor: Theme.of(context).accentColor,
          indicatorColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).secondaryHeaderColor,
          //indicatorWeight: 0.00001,
        ),
      ),
    );
  }
}
