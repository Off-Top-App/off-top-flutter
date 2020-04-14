

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'router.dart' as router;

void main() => runApp(SettingsPage());

class SettingsPage extends StatelessWidget{//parent
  @override
  Widget build(BuildContext context){

      return new MaterialApp(
      onGenerateRoute: router.generateRoute,
      home: MySettingsPage(),
      
      );
    // TODO: implement build
    return null;
  }
  
}

class MySettingsPage extends StatefulWidget{//constructor
  MySettingsPage({Key key, this.title = "Demo Settings Page"}) : super(key: key);
  final String title ;

@override 
_MySettingsPageState createState() => _MySettingsPageState();

}


class _MySettingsPageState extends State <MySettingsPage>{//State and Behavior
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  // @override 


  
}



// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }