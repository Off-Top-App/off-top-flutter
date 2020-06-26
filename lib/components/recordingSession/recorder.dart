import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:off_top_mobile/components/recordingSession/websocket.dart';
import 'package:off_top_mobile/components/popup/TopicPopup.dart';

typedef RecordingCallback = void Function(bool);

class Recorder extends StatefulWidget {
  const Recorder({
    @required this.userId,
    @required this.ws,
  });

  final MyWebSocket ws;
  final int userId;

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool _isRecording = false;

  StreamSubscription<dynamic> _recorderSubscription;

  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();

  String _recorderTxt = '00:00:00';
  double _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;
  final Codec _codec = Codec.aacADTS;

  int userId;
  String topic;
  MyWebSocket ws;
  String savePath;

  int sessionCounter = 0;

  Future<void> init() async {
    recorderModule.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
  }

  @override
  void initState() {
    super.initState();
    init();
    initializeDateFormatting();
    userId = widget.userId;
    ws = widget.ws;
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }

  Future<void> releaseFlauto() async {
    try {
      await recorderModule.closeAudioSession();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelRecorderSubscriptions();
    releaseFlauto();
  }

  Future<void> startRecorder() async {
    ws.sendFirstMessage(userId);

    final String now =
        DateFormat('yyyy-MMMM-dd_HH:mm:ss:SSS').format(DateTime.now());
    try {
      final PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }

      final Directory tempDir = await getApplicationDocumentsDirectory();
      final String path =
          '${tempDir.path}/${now}_user_${userId}_recording${ext[_codec.index]}';

      await recorderModule.startRecorder(
        toFile: path,
        codec: _codec,
        bitRate: 16000,
        sampleRate: 16000,
        audioSource: AudioSource.voice_communication,
      );
      print('startRecorder');
      print('Path: ' + path);

      _recorderSubscription = recorderModule.onProgress.listen(
        (RecordingDisposition e) {
          if (e != null && e.duration != null) {
            final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                e.duration.inMilliseconds,
                isUtc: true);
            final String formattedDate =
                DateFormat('mm:ss:SS', 'en_US').format(date);

            //print('got update -> ${e.decibels}');

            setState(() {
              _recorderTxt = formattedDate.substring(0, 8);
              _dbLevel = e.decibels;
            });
          }
        },
      );

      setState(() {
        savePath = path;
        _isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
      setState(() {
        stopRecorder();
        _isRecording = false;
        if (_recorderSubscription != null) {
          _recorderSubscription.cancel();
          _recorderSubscription = null;
        }
      });
    }
  }

  Future<void> stopRecorder() async {
    setState(() {
      sessionCounter += 1;
    });
    print('Counter here $sessionCounter');
    if (sessionCounter > 2) {
      // this.setSessionPreferences("Session Complete!");
    }
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder');

      ws.sendAudioFile(savePath, userId, topic);

      cancelRecorderSubscriptions();
    } catch (err) {
      print('stopRecorder error: $err');
    }
    setState(() {
      _isRecording = false;
    });
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
