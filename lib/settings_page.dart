import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/DynamicListTile.dart';

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

  @override
  void initState() {
    _showProfile = false;
    _showSettings = false;
    super.initState();
  }

  void showProfile() {
    setState(
      () {
        _showProfile = !_showProfile;
        if (_showSettings) {
          _showSettings = !_showSettings;
        }
      },
    );
  }

  void showSettings() {
    setState(
      () {
        _showSettings = !_showSettings;
        if (_showProfile) {
          _showProfile = !_showProfile;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height - 120,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 90,
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: offTopSettingsTitle1),
              ),
              Container(
                color: Colors.white24,
                height: 100,
                width: 100,
                child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/Off-Top_Logo.jpg')),
              ),
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => showProfile(),
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Profile',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                    FlatButton(
                      onPressed: () => showSettings(),
                      padding: const EdgeInsets.fromLTRB(60, 0, 20, 0),
                      child: Text('Settings',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
              Visibility(
                child: Container(
                    height: MediaQuery.of(context).size.height - 390,
                    width: MediaQuery.of(context).size.width - 50,
                    child: _buildProfileForm()),
                visible: _showProfile,
              ),
              Visibility(
                child: Container(
                  height: MediaQuery.of(context).size.height - 440,
                  child: HomeScreen(),
                ),
                visible: _showSettings,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildField('NAME'),
        _buildField('LOCATION'),
        _buildField('EMAIL'),
        _buildField('PROFESSION'),
        const Spacer(),
        _buildFormButtom(context)
      ],
    );
  }

  Widget _buildField(String field) {
    return TextFormField(
      decoration: InputDecoration(labelText: field),
    );
  }
}

Widget _buildFormButtom(BuildContext context) {
  return RaisedButton(
      color: Colors.lightBlue,
      textColor: Colors.white,
      splashColor: Colors.red,
      child: const Text('SAVE'),
      onPressed: () => null);
}

Widget setupAlertDialoadContainer() {
  return Container(
    height: 100.0,
    width: 100.0,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListView(
          children: <Widget>[
            ListTile(
                title: Text('FOOD',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            ListTile(
                title: Text('SPORTS',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            ListTile(
                title: Text('COMPUTER SCIENCE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
          ],
        );
      },
    ),
  );
}

Widget _buildSelectionList() {
  return ListView(
    children: const <Widget>[
      ListTile(onTap: null, title: Text('FOOD')),
      ListTile(onTap: null, title: Text('SPORTS')),
      ListTile(onTap: null, title: Text('COMPUTER SCIENCE'))
    ],
  );
}
