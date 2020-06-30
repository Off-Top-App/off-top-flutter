import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/DynamicListTile/DynamicListTile.dart';
import 'package:off_top_mobile/login/login.dart';
import 'package:off_top_mobile/login/googleSignIn.dart';
import 'package:off_top_mobile/components/settings/settingsWidgets.dart';

class MySettingsPage extends StatefulWidget {
  //constructor

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  //State and Behavior
  bool _showProfile;
  bool _showSettings;
  bool _showPreferences;
  UserAuthentication auth;
  SettingsWidgets widgets;

  @override
  void initState() {
    auth = UserAuthentication();
    widgets = SettingsWidgets(context);
    _showProfile = false;
    _showSettings = true;
    _showPreferences = false;
    super.initState();
  }

  void showProfile() {
    setState(() {
      _showProfile = !_showProfile;
      if (_showSettings) {
        _showSettings = !_showSettings;
      }
    });
  }

  void showSettings() {
    setState(() {
      _showSettings = !_showSettings;
      if (_showProfile) {
        _showProfile = !_showProfile;
      }
    });
  }

  void showPreferences() {
    setState(() {
      _showPreferences = !_showPreferences;
      if (_showPreferences) {
        PreferenceScreen();
      }
    });
  }

  void signOutAndRedirect() {
    auth.signOutGoogle();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const LoginPage()),
        (Route<void> route) => false);
  }

  Column dynamicProfileButton() {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => showProfile(),
          child: Text('Profile', style: widgets.textStyle()),
        ),
        widgets.createUnderlineBorder(_showProfile),
      ],
    );
  }

  Column dynamicSettingsButton() {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => showSettings(),
          child: Text('Settings', style: widgets.textStyle()),
        ),
        widgets.createUnderlineBorder(_showSettings),
      ],
    );
  }

  Visibility dynamicSignOutButton() {
    return Visibility(
      visible: !_showPreferences,
      child: FlatButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'LOGOUT',
              style: TextStyle(
                fontSize: 24.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            FaIcon(FontAwesomeIcons.signOutAlt),
          ],
        ),
        onPressed: () => signOutAndRedirect(),
      ),
    );
  }

  Column buildSettingsPage() {
    return Column(
      children: <Widget>[
        FlatButton(
          child: const Text(
            'PREFERENCES',
            style: TextStyle(
              fontSize: 24.0,
              letterSpacing: 2.0,
            ),
          ),
          onPressed: () => showPreferences(),
        ),
        const Divider(
          thickness: 2.0,
        ),
        Visibility(
          visible: _showPreferences,
          child: Expanded(
            child: Container(
              child: PreferenceScreen(),
            ),
          ),
        ),
        dynamicSignOutButton(),
        const Divider(
          thickness: 2.0,
        ),
      ],
    );
  }

  Row buildSettingsBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: dynamicProfileButton(),
        ),
        Expanded(
          child: dynamicSettingsButton(),
        )
      ],
    );
  }

  Visibility profileTab() {
    return widgets.buildTabs(
      widgets.buildProfileForm(),
      _showProfile,
    );
  }

  Visibility settingsTab() {
    return widgets.buildTabs(
      buildSettingsPage(),
      _showSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              widgets.buildTitle(),
              widgets.buildImage(),
              const SizedBox(
                height: 10.0,
              ),
              buildSettingsBar(),
              profileTab(),
              settingsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
