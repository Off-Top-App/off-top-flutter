import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subnavbar extends StatefulWidget {
  Subnavbar({Key key}) : super(key: key);

  SubnavbarState createState() => SubnavbarState();
}

class SubnavbarState extends State<Subnavbar> {
  String name = "";
  String session = "Start";
  @override
  initState() {
    super.initState();
    getNamePreference().then(updateName);
    getSessionPreference().then(updateSession);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: new Text(
              'Welcome: ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )),
          Container(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: new Text(
              name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )),
          Container(
              height: 20,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2.0,
              )),
          Container(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: new Text(
              session,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )),
        ],
      ),
    );
  }

  Future<String> getSessionPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session");
    return session;
  }
  

  Future<String> getNamePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");

    return name;
  }

  void updateName(String incomingName) {
    setState(() {
      name = incomingName;
    });
  }

  void updateSession(String incomingSession) {
    setState(() {
      session = incomingSession;
    });

  }

  @override
  void dispose() {
    super.dispose();
  }
}
