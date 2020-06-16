import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subnavbar extends StatefulWidget {
  const Subnavbar({Key key}) : super(key: key);

  @override
  SubnavbarState createState() => SubnavbarState();
}

class SubnavbarState extends State<Subnavbar> {
  String name = '';
  String _session = 'Start';

  @override
  void initState() {
    super.initState();
    getNamePreference().then(updateName);
    getSessionPreference().then(updateSession);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome: ',
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
              height: 20,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2.0,
              )),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Main Page',
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getSessionPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String session = prefs.getString('session');
    return session;
  }

  Future<String> getNamePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name');
    return name;
  }

  void updateName(String incomingName) {
    setState(
      () {
        name = incomingName;
      },
    );
  }

  void updateSession(String incomingSession) {
    print('updateSession: $incomingSession\n\n');
    setState(
      () {
        _session = incomingSession;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
