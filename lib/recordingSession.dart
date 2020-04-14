import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/footer/bottomNavigation.dart';
import 'package:off_top_mobile/components/recordingSession/meter.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';

class RecordingPage extends StatelessWidget {
  int yes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: this.yes * 10.0,
          height: 100,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () {
              //
            },
            backgroundColor: Colors.white,
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: offTopTitle,
      body: Column(
        children: <Widget>[
          Row(children: [
            Expanded(
              child: FlatButton(
                child: Text("Go To Websocket"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, WebsocketRoute);
                },
              ),
            ),
          ]),
          Image.asset('assets/placeholderWave.gif'),
          Meter(),
          Recorder()
        ],
      ),
      bottomNavigationBar:footer
    );
  }
}
