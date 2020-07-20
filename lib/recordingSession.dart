import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/pushNotifications/pushNotificationsManager.dart';
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
  PushNotificationsManager pushNotificationsManager;
  final GlobalKey<MeterState> meterState = GlobalKey<MeterState>();
  MyWebSocket ws;
  int userId;
  @override
  void initState() {
    pushNotificationsManager = PushNotificationsManager();
    pushNotificationsManager.initializePushNotificationsManager();
    pushNotificationsManager.getMessage();
    userId = widget.userId;
    super.initState();
    ws = MyWebSocket('ws://localhost:9000/session-handler');
  }

  @override
  void dispose() {
    ws.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
          Container(
            margin: const EdgeInsets.only(bottom: 15),
          ),
          Recorder(
            ws: ws,
            userId: userId,
          ),
        ],
      ),
    );
  }
}
