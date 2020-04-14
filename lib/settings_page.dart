import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'router.dart' as router;
import 'package:off_top_mobile/components/offTopTitle.dart';

void main() => runApp(SettingsPage());

class SettingsPage extends StatelessWidget {
  //parent
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent[100],
          title: Text('settings'),
        ),
        body: new Container(
            height: 200.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 100,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top:30,),
                    child:offTopTitle1),
                ),
                new Container(
                    height: 100, width: 100,
                    color: Colors.white, 
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: ),
                ),

              ],
            )));
  }
}

// class MySettingsPage extends StatefulWidget{//constructor

// @override
// _MySettingsPageState createState() => _MySettingsPageState();
// }

// class _MySettingsPageState extends State <MySettingsPage>{//State and Behavior

//   @override
//   Widget build(BuildContext context) {
//     return new Text();

//   }

// }
