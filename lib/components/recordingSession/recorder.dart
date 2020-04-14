import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

class Recorder extends StatefulWidget {
  Recorder({Key key}) : super(key: key);

  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  Directory directory;
  bool _isRecording = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

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
  }

  int getRandomValue() {
    Random rnd;
    int min = 0;
    int max = 10;
    rnd = new Random();
    var r = min + rnd.nextInt(max - min);
    return r;
  }

  void startRecorder(user_id) async {
    try {
      var now = new DateTime.now();
      var date = DateFormat("yyyy-MM-ddThh:mm").format(now);
      Directory tempDir = await getTemporaryDirectory();
      setState(() {
        directory = tempDir;
      });
      print('tempdir: ${tempDir}');
      String path = await flutterSound.startRecorder(
          // uri: tempDir.path +'/'+date.toString() + '_' + user_id.toString() + '_sound.aac',
          uri: tempDir.path +'/'+date.toString() + '_' + user_id.toString() + '_sound.aac',
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
      print('stopRecorder: $result');

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
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 2.0, color:Colors.black)
        )  
      ),
      child: Column(
      children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            width: 56.0,
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 10.0
            ),
            child: FloatingActionButton(
              heroTag: 'recorder',
              onPressed: () {
                if (!this._isRecording) {
                  return this.startRecorder(3);
                }
                this.stopRecorder();
              },
              child: this._isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              this._recorderTxt,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
          _isRecording
              ? LinearProgressIndicator(
                  value: 100.0 / 160.0 * (this._dbLevel ?? 1) / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  backgroundColor: Colors.red,
                )
              : Container()
        ],
      ),
    ])
    );
  }
}
