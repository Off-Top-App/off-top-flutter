import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

void main() {
  runApp(new AudioRecorder());
}

class AudioRecorder extends StatefulWidget {
  @override
  _AudioRecorderState createState() => new _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  Directory directory;
  bool _isRecording = false;
  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
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

  int getRandomValue(){
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
      setState((){ 
        directory = tempDir;
      });
      String path = await flutterSound.startRecorder(
        uri: date.toString() + '_' +user_id.toString()+'_sound.aac',
        codec: t_CODEC.CODEC_AAC
      );

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

  void startPlayer() async {
    String path = await flutterSound.startPlayer(directory.path);
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          sliderCurrentPosition = e.currentPosition;
          maxDuration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
          this.setState(() {
            this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
    setState(() {});
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
    print('pausePlayer: $result');
  }

  void resumePlayer() async {
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async {
    String result = await flutterSound.seekToPlayer(milliSecs);
    print('seekToPlayer: $result');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Audio Recorder'),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
                  child: Text(
                    this._recorderTxt,
                    style: TextStyle(
                      fontSize: 48.0,
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
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: (){
                      if(!this._isRecording){
                        var user_id = getRandomValue();
                        return this.startRecorder(user_id);
                      }
                      this.stopRecorder();
                    },
                    child:
                        this._isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
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
                  margin: EdgeInsets.only(top: 60.0, bottom: 16.0),
                  child: Text(
                    this._playerTxt,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      startPlayer();
                    },
                    child: Icon(Icons.play_arrow),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      pausePlayer();
                    },
                    child: Icon(Icons.pause),
                  ),
                ),
                Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      stopPlayer();
                    },
                    child: Icon(Icons.stop),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Container(
                height: 56.0,
                child: Slider(
                    value: sliderCurrentPosition,
                    min: 0.0,
                    max: maxDuration,
                    onChanged: (double value) async {
                      await flutterSound.seekToPlayer(value.toInt());
                    },
                    divisions: maxDuration.toInt()))
          ],
        ),
      ),
    );
  }
}