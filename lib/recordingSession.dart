import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/recordingSession/meter.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'package:off_top_mobile/components/recordingSession/recorder.dart';
import 'package:off_top_mobile/components/recordingSession/websocket.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';

import 'components/NavBarClass.dart';
import 'components/recordingSession/offTop.dart';
import 'components/subnavbar.dart';

class RecordingPage extends StatefulWidget {
  int userId;
  RecordingPage({Key key, @required this.userId}): super(key: key);

  _RecordingPage createState()=> _RecordingPage();
}


class _RecordingPage extends State<RecordingPage>{
  int yes = 0;
  MyWebSocket ws;
  int userId;
  @override
  void initState() {
    this.userId = widget.userId;
    super.initState();
    ws = new MyWebSocket(
      "ws://localhost:9000/name"
      // "ws://10.0.2.2:9000/name"
    );
  }

  @override
  void dispose() {
    ws.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        floatingActionButton: Container(
            width: this.yes * 10.0,
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
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset('assets/placeholderWave.gif'),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Meter(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: OffTopVal(
                userId: userId,
                ws: ws
              )
            ),
            Recorder(
              ws: ws,
              userId: userId
            ),
          ],
        ),
        bottomNavigationBar: AppBarBuilder());
  
    
  }
}


