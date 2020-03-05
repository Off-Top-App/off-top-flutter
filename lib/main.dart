import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/routing_constants.dart';
import 'router.dart' as router;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: HomeRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => MyApp()),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title, onGeneratedRoute}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: 100,
          height: 100,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          )
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'OFF-TOP',
          style: TextStyle(
              color: Colors.black45, fontSize: 30, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text("Go To Wfebsocket"),
            onPressed: (){
              Navigator.pushNamed(context, WebsocketRoute);
            },
          ),
          Image.asset('assets/placeholderWave.gif'),
          Image.asset('assets/placeholderMeter.png'),
        ],
      ),
      bottomNavigationBar:
        new BottomNavigationBar(
          backgroundColor: Colors.deepPurple, items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Home', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Reports', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
        ]
      ),
    );
  }

}
