import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:off_top_mobile/components/NavBarClass.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';

void main() => runApp(MySettingsPage());

class MySettingsPage extends StatefulWidget {
  //constructor

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  //State and Behavior
  var _showProfile;
  var _showSettings;

  @override
  void initState() {
    _showProfile = false;
    _showSettings = false;
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
          height: MediaQuery.of(context).size.height - 120,
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
                  height: (MediaQuery.of(context).size.height - 390),
                  width: (MediaQuery.of(context).size.width - 50),
                  child: _buildProfileForm()),
              visible: _showProfile,
            ),
            Visibility(
              child: new Container(
                height: (MediaQuery.of(context).size.height - 440),
                child: _buildNestedListView(),
              ),
              visible: _showSettings,
            )
          ]))),
      bottomNavigationBar: AppBarBuilder(),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildField("NAME"),
        _buildField("LOCATION"),
        _buildField("EMAIL"),
        _buildField("PROFESSION"),
        Spacer(),
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

Widget _buildFormButtom(context) {
  return RaisedButton(
    color: Colors.lightBlue,
    textColor: Colors.white,
    splashColor: Colors.red,
    child: Text("SAVE"),
    onPressed: () => null
        

    
  );
}


Widget setupAlertDialoadContainer() {
    return Container(
      height: 100.0,
      width: 100.0, 
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
        return ListView(children: <Widget>[
          new ListTile(title: Text('FOOD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          new ListTile(title: Text('SPORTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          new ListTile(title: Text('COMPUTER SCIENCE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
        ]
          );
        },
      ),
    );
  }

Widget _buildSelectionList() {
  return ListView(
    children: <Widget>[
      new ListTile(onTap: null, title: Text("FOOD")),
      new ListTile(onTap: null, title: Text("SPORTS")),
      new ListTile(onTap: null, title: Text("COMPUTER SCIENCE"))
    ],
  );
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
        ]),
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
        ])
  ]);
}
