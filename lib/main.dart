import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OFF TOP',
      home: Scaffold(
        floatingActionButton: Container(
            width: 200,
            height: 200,
            child: FittedBox(
                child: FloatingActionButton(
              onPressed: () {
                //
              },
              child: Icon(
                Icons.play_arrow,
                color: Colors.blueGrey,
              ),
              backgroundColor: Colors.orange,
              hoverColor: Colors.orangeAccent,
            ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('OFF TOP'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Image.asset('assets/placeholderWave.gif'),
          // Align(alignment: Alignment.topCenter, child:Image.asset('assets/placeholderMeter.'))
          // child: new Image(image: new AssetImage("placeholderWave.gif")),
          // child: Text('welcome to offTop main page wip!'),
        ),
        bottomNavigationBar: new BottomNavigationBar(items: [
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.green,
                size: 30.0,
              ),
              title: Text('Home')),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt,
                color: Colors.grey,
                size: 30.0,
              ),
              title: Text('Reports')),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.purple,
                size: 30.0,
              ),
              title: Text('Settings')),
        ]),
      ),
    );
  }
}
