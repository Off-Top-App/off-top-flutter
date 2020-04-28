import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/recordingSession/meter.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';

import 'components/NavBarClass.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key key}) : super(key: key);

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final GlobalKey<MeterState> meterState = GlobalKey<MeterState>();
  int yes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
            width: yes * 10.0,
            child: FittedBox(
                child: FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.white,
            ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        appBar: offTopTitle,
        body: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: const Text('Go To Websocket'),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, WebsocketRoute);
                  },
                ),
              ),
            ]),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset('assets/placeholderWave.gif'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height / 4,
              child: Meter(key: meterState),
            ),
            Recorder((bool isOnTopic) {
              setState(() {
                meterState.currentState.updateScore(isOnTopic);
              });
            }),
          ],
        ),
        bottomNavigationBar: AppBarBuilder());
  }
}
