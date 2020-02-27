import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.black45, fontSize: 30, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Image.asset('assets/placeholderWave.gif'),
              )
            ]
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlutterGauge(
                    circleColor: Colors.green,
                    secondsMarker: SecondsMarker.none,
                    hand: Hand.short,
                    number: Number.none,
                    width: 200,
                    index: updateScore(),
                    fontFamily: "Iran",
                    counterStyle: TextStyle(color: Colors.black, fontSize: 35),
                    counterAlign: CounterAlign.bottom,
                    isDecimal: false),
              ),
            ],
          ),
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
    );
  }
}

int updateScore() {
  return 37;
}
