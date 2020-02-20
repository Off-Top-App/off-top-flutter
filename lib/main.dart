import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OFF TOP',
      home: Scaffold(
        floatingActionButton: Container(
            width: 100,
            height: 100,
            child: FittedBox(
                child: FloatingActionButton(
              onPressed: () {
                //
              },
              child: Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(
            'OFF-TOP',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 30,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            Image.asset('assets/placeholderWave.gif'),
            Image.asset('assets/placeholderMeter.png'),
          ],
        ),
        bottomNavigationBar:
            new BottomNavigationBar(backgroundColor: Colors.deepPurple, items: [
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 30.0,
              ),
              title: Text('Home'),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt,
                color: Colors.white,
                size: 30.0,
              ),
              title: Text('Reports'),
              backgroundColor: Colors.white),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
              title: Text('Settings'),
              backgroundColor: Colors.white),
        ]),
      ),
    );
  }
}
