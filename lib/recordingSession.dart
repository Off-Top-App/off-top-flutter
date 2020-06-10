import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/recordingSession/meter.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:off_top_mobile/components/recordingSession/websocket.dart';

import 'components/subnavbar.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key key, @required this.userId}) : super(key: key);

  final int userId;

  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final GlobalKey<MeterState> meterState = GlobalKey<MeterState>();
  int yes = 0;
  MyWebSocket ws;
  int userId;
  @override
  void initState() {
    userId = widget.userId;
    super.initState();
    ws = MyWebSocket('ws://localhost:9000/name');
    //"ws://10.0.2.2:9000/name");
  }

  @override
  void dispose() {
    ws.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: yes * 10.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //backgroundColor: Colors.white,
      appBar: offTopTitle(context),
      body: Column(
        children: <Widget>[
          const Subnavbar(),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset('assets/placeholderWave.gif'),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Meter(ws: ws, key: meterState),
          ),
          Container(margin: const EdgeInsets.only(bottom: 15)),
          Recorder(
            ws: ws,
            userId: userId,
          ),
        ],
      ),
    );
  }
}
