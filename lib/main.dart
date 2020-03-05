import 'package:flutter/material.dart';
import 'package:off_top_mobile/routing_constants.dart';
import 'router.dart' as router;
import 'package:flutter_gauge/flutter_gauge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
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
  MyHomePage({Key key, this.title}) : super(key: key);

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
  void dispose(){
    super.dispose();
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
      body: ListView(
        children: <Widget>[
          Row(
            children: [
              Expanded(
              child: FlatButton(
                child: Text("Go To Websocket"),
                color: Colors.blue,
                onPressed: (){
                  Navigator.pushNamed(context, WebsocketRoute);
                },
              ),
              ),
            ]
          ),
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
                    circleColor: updateMeterColor(),//Colors.green,
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

double updateScore() {
  return 37;
}

Color updateMeterColor() {
  return Colors.green;
}
