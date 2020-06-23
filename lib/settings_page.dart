import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/DynamicListTile/DynamicListTile.dart';
import 'package:off_top_mobile/login.dart';

void main() => runApp(MySettingsPage());

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

  @override
  void initState() {
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
        PrefScreen();
      }
    });
  }

  Column buildProfileButton() {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => showProfile(),
          child: Text('Profile',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ),
        lineUnderButtons(_showProfile),
      ],
    );
  }

  Column buildSettingsButton() {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => showSettings(),
          child: Text('Settings',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ),
        lineUnderButtons(_showSettings),
      ],
    );
  }

  Visibility lineUnderButtons(bool visible) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: const Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
    );
  }

  Visibility buildSignOutButton() {
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
        onPressed: () {
          signOutGoogle();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const LoginPage()),
              (Route<void> route) => false);
        },
      ),
    );
  }

  Column buildSettingsForms() {
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
              child: PrefScreen(),
            ),
          ),
        ),
        buildSignOutButton(),
        const Divider(
          thickness: 2.0,
        ),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildField('NAME'),
                _buildField('LOCATION'),
                _buildField('EMAIL'),
                _buildField('PROFESSION'),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: _buildFormButton(context)),
        ],
      ),
    );
  }

  TextFormField _buildField(String field) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }

  RaisedButton _buildFormButton(BuildContext context) {
    return RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).secondaryHeaderColor,
        splashColor: Theme.of(context).accentColor,
        child: const Text('SAVE'),
        onPressed: () => null);
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
              Container(
                height: 90.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: offTopSettingsTitle1(context),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 100.0,
                width: 100.0,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Off-Top_Logo.jpg'),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: buildProfileButton(),
                  ),
                  Expanded(
                    child: buildSettingsButton(),
                  )
                ],
              ),
              Visibility(
                child: Expanded(
                  child: _buildProfileForm(),
                ),
                visible: _showProfile,
              ),
              Visibility(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                    child: buildSettingsForms(),
                  ),
                ),
                visible: _showSettings,
              )
            ],
          ),
        ),
      ),
    );
  }
}
