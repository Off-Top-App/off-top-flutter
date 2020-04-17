import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/NavBarClass.dart';
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
        AppBarBuilder()
    );
  }

}

