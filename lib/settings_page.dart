import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:off_top_mobile/components/NavBarClass.dart';
import 'router.dart' as router;
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
  var _showContainer;
  var _showSettings;

  @override
  void initState() {
    _showContainer = false;
    _showSettings = false;
    super.initState();
  }

  void showProfile() {
    setState(() {
      _showContainer = !_showContainer;
      if (_showSettings) {
        _showSettings = !_showSettings;
      }
    });
  }

  void showSettings() {
    setState(() {
      _showSettings = !_showSettings;
      if (_showContainer) {
        _showContainer = !_showContainer;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
            height: MediaQuery.of(context).size.height-120,
            alignment: Alignment.center,
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              new Container(
                height: 90,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: offTopSettingsTitle1),
              ),
              new Container(
                color: Colors.white24,
                height: 100,
                width: 100,
                child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/Off-Top_Logo.jpg')),
              ),
              new Container(
                  height: (100),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: new ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                        onPressed: () => showProfile(),
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Profile",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ),
                      new FlatButton(
                        onPressed: () => showSettings(),
                        padding: EdgeInsets.fromLTRB(60, 0, 20, 0),
                        child: Text("Settings",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  )),
              Visibility(
                child: new Container(
                    height: (MediaQuery.of(context).size.height -
                        440),
                    width: (MediaQuery.of(context).size.width - 50),
                    child: _buildProfileForm()),
                visible: _showContainer,
              ),
              Visibility(
                child: new Container(
                  height: (MediaQuery.of(context).size.height -
                      440),
                  child: MyDynamicListTile(),
                ),
                visible: _showSettings,
              )
            ]))
            ),
            bottomNavigationBar: AppBarBuilder(),);
  }

  Widget _buildProfileForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildNameField(),
        _buildLocationField(),
        _buildEmailField(),
        _buildProfessionField(),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'NAME:'),
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'LOCATION:'),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'EMAIL:'),
    );
  }

  Widget _buildProfessionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'PROFESSION:'),
    );
  }
}

