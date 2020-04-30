import 'dart:convert';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:off_top_mobile/components/recordingSession/websocket.dart';
import 'package:off_top_mobile/components/popup/TopicPopup.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

class Recorder extends StatefulWidget {
  int userId;
  MyWebSocket ws;
  Recorder({
    Key key, 
    @required this.userId,
    @required this.ws
  }) : super(key: key);

  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  MyWebSocket ws;
  Directory directory;
  bool _isRecording = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  int userId;
  String topic;
  String _recorderTxt = '00:00:00';
  double _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;


  
  @override
  void initState() {
    super.initState();
    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
    this.userId = widget.userId;
    this.ws = widget.ws;
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getRandomValue() {
    Random rnd;
    int min = 0;
    int max = 10;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    return r;
  }

  void startRecorder() async {
    this.ws.sendFirstMessage(this.userId);
    try {
      var now = new DateTime.now();
      var date = DateFormat("yyyy-MM-ddThh:mm").format(now);
      Directory tempDir = await getTemporaryDirectory();
      setState(() {
        directory = tempDir;
      });
      print('tempdir: ${tempDir}');
      String path = await flutterSound.startRecorder(
          uri: tempDir.path +
              '/' +
              date.toString() +
              '_' +
              userId.toString() +
              '_sound.aac',
          codec: t_CODEC.CODEC_AAC);
      print('path: ${path}');
      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });
      _dbPeakSubscription =
          flutterSound.onRecorderDbPeakChanged.listen((value) {
        print("got update -> $value");
        setState(() {
          this._dbLevel = value;
        });
      });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    print('STOP RECORDER');
    try {
      String result = await flutterSound.stopRecorder();
      final filePath = result.replaceRange(0, 7, '');
      this.ws.sendAudioFile(filePath, this.userId, this.topic);

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'recorder',
          onPressed: () async {
            if (!this._isRecording) {
              await showDialog(
                context: context,
                builder: (BuildContext context) => 
                  MyTopicDialog(
                    onTopicChanged: (childTopic){
                      this.topic = childTopic;
                    }
                  )
              );
              return this.startRecorder();
            }
            
            this.stopRecorder();
            
          },
          child: this._isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
        ),
        Container(
          child: AutoSizeText(
            this._recorderTxt,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
        ),
        Container(
            child: _isRecording ? LinearProgressIndicator(
                    value: 100.0 / 160.0 * (this._dbLevel ?? 1) / 100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    backgroundColor: Colors.red,
                  )
                : Container())
      ],
    ));
    
  }
  
}
