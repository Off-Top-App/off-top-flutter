import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/routing_constants.dart';

class RecordingPage extends StatelessWidget {
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
      appBar: offTopTitle,
      body: Column(
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
    );
  }
}
