import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'router.dart' as router;
import 'package:off_top_mobile/components/offTopTitle.dart';

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

  void show1() {
    setState(() {
      _showContainer = !_showContainer;
      if (_showSettings) {
        _showSettings = !_showSettings;
      }
    });
  }

  void show2() {
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
        appBar: customBar,
        body: new Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: new SingleChildScrollView(
                child: new Column(children: <Widget>[
              new Container(
                height: 90,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: offTopTitle1),
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
                        onPressed: () => show1(),
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Profile",
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ),
                      new FlatButton(
                        onPressed: () => show2(),
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
                    color: Colors.transparent,
                    height: (MediaQuery.of(context).size.height -
                        customBar.preferredSize.height -
                        320),
                    width: (MediaQuery.of(context).size.width - 50),
                    child: _buildProfileForm()),
                visible: _showContainer,
              ),
              Visibility(
                child: new Container(
                  height: (MediaQuery.of(context).size.height -
                      customBar.preferredSize.height -
                      320),
                  child: _buildNestedListView(),
                ),
                visible: _showSettings,
              )
            ]))));
  }

  Widget _buildNestedListView() {
    return ListView(children: <Widget>[
      new ExpansionTile(
        leading: Icon(Icons.line_style),
        title: Text('DEFAULT CATEGORY',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        
        children: <Widget>[
          new ListTile(
              title: Text('THERAPY',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('WORKOUT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('STUDYING',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('NEGOTIATING',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('MEETING',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              )
        ],
      ),
      new ExpansionTile(
        leading: Icon(Icons.color_lens),
        title: Text('SELECT COLOR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            children: <Widget>[
              ListTile(
              title: Text('BLUE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('RED',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('YELLOW',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('GREEN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('MAGENTA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
      ),
      ExpansionTile(
        leading: Icon(Icons.ring_volume),
        title: Text('ALERT TYPE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        children: <Widget>[
              ListTile(
              title: Text('TEXT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('RINGER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('EMAIL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('NOTIFICATION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('EVERYTHING',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ]
        
      ),
      ExpansionTile(
        leading: Icon(Icons.vibration),
        title: Text('VIBRATION TYPES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          children: <Widget>[
              ListTile(
              title: Text('SIREN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('PULSE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('TRIGGER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('RAPID',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              new ListTile(
              title: Text('HEARTBEAT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ]
      )
    ]);
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

var customBar = AppBar(
  elevation: 60,
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: Colors.black),
  backgroundColor: Colors.white54,
);
