import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:off_top_mobile/components/recordingSession/websocket.dart';
import 'package:off_top_mobile/components/popup/TopicPopup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef RecordingCallback = void Function(bool);

class Recorder extends StatefulWidget {
  const Recorder({Key key, @required this.userId, @required this.ws})
      : super(key: key);

  final MyWebSocket ws;
  final int userId;

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  MyWebSocket ws;
  Directory directory;
  bool _isRecording = false;
  StreamSubscription<RecordStatus> _recorderSubscription;
  StreamSubscription<double> _dbPeakSubscription;
  //StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  int userId;
  String topic;
  String _recorderTxt = '00:00:00';
  double _dbLevel;
  int sessionCounter = 0;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;

  @override
  void initState() {
    super.initState();
    flutterSound = FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
    userId = widget.userId;
    ws = widget.ws;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> startRecorder() async {
    ws.sendFirstMessage(userId);
    try {
      final DateTime now = DateTime.now();
      final String date = DateFormat('yyyy-MM-ddThh:mm').format(now);
      final Directory tempDir = await getTemporaryDirectory();
      setState(() {
        directory = tempDir;
      });
      print('tempdir: $tempDir');
      final String path = await flutterSound.startRecorder(
          uri: tempDir.path +
              '/' +
              date.toString() +
              '_' +
              userId.toString() +
              '_sound.aac',
          codec: t_CODEC.CODEC_AAC);
      print('path: $path');
      _recorderSubscription = flutterSound.onRecorderStateChanged.listen(
        (RecordStatus e) {
          final DateTime date = DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          final String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
          setState(
            () {
              _recorderTxt = txt.substring(0, 8);
            },
          );
        },
      );
      _dbPeakSubscription = flutterSound.onRecorderDbPeakChanged.listen(
        (double value) {
          print('got update -> $value');
          setState(
            () {
              _dbLevel = value;
            },
          );
        },
      );

      setState(
        () {
          _isRecording = true;
        },
      );
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  Future<void> stopRecorder() async {
    print('STOP RECORDER');
    setState(() {
      sessionCounter += 1;
    });
    print('Counter here $sessionCounter');
    if (sessionCounter > 2) {
      // this.setSessionPreferences('Session Complete!');
    }
    try {
      final String result = await flutterSound.stopRecorder();
      final String filePath = result.replaceRange(0, 7, '');
      ws.sendAudioFile(filePath, userId, topic);

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      setState(
        () {
          _isRecording = false;
        },
      );
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  Future<void> setSessionPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session', value);
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
              if (!_isRecording) {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => MyTopicDialog(
                    onTopicChanged: (String childTopic) {
                      topic = childTopic;
                    },
                  ),
                );
                return startRecorder();
              } else {
                stopRecorder();
              }
            },
            child: _isRecording
                ? Icon(Icons.stop)
                : Icon(
                    Icons.mic,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          Container(
            child: AutoSizeText(
              _recorderTxt,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            child: _isRecording
                ? LinearProgressIndicator(
                    value: 100.0 / 160.0 * (_dbLevel ?? 1) / 100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    backgroundColor: Colors.red,
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
