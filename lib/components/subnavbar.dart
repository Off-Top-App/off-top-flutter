import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subnavbar extends StatefulWidget {
  Subnavbar({Key key}) : super(key: key);

  SubnavbarState createState() => SubnavbarState();
}

class SubnavbarState extends State<Subnavbar> {
  String name = 'Henry';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: new Text('Welcome',
              style: TextStyle(fontWeight: FontWeight.bold)),
          margin: EdgeInsets.only(top: 10.0),
        ),
        Container(
          child:
              new Text((name), style: TextStyle(fontWeight: FontWeight.bold)),
          margin: EdgeInsets.only(top: 10.0),
        ),
        Container(
          child:
              new Text('Play', style: TextStyle(fontWeight: FontWeight.bold)),
          margin: EdgeInsets.only(top: 10.0),
        )
      ],
    );
  }

//Future<bool> Preference (String name) async{
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.setString("name", name);

//}

  @override
  void dispose() {
    super.dispose();
  }
}
