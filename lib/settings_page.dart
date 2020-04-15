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
    });
  }
  void show2() {
    setState(() {
      _showSettings = !_showSettings;
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
                child:
                new Container(
                  color: Colors.black,
                  height: (MediaQuery.of(context).size.height -
                      customBar.preferredSize.height -
                      320),
                ),
                visible: _showContainer,
              )
              ,Visibility(
                child:
                new Container(
                  color: Colors.yellow,
                  height: (MediaQuery.of(context).size.height -
                      customBar.preferredSize.height -
                      320),
                ),
                visible: _showSettings,
              )
            ])));
  }
}

var customBar = AppBar(
  elevation: 60,
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: Colors.black),
  backgroundColor: Colors.white54,
);
