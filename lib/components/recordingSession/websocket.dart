import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:off_top_mobile/routing/router.dart' as router;

import 'dart:async';
import 'dart:typed_data';

void main() => runApp(WebsocketPage());

class WebsocketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect(
        // "ws://10.0.2.2:9000/name"
        "ws://localhost:9000/name");
    return new MaterialApp(
        onGenerateRoute: router.generateRoute,
        home: MyWebSocketPage(
          title: 'Websocket Page',
          channel: channel,
        ));
  }
}

class MyWebSocketPage extends StatefulWidget {
  final WebSocketChannel channel;
  final String title;

  MyWebSocketPage({Key key, this.title, this.channel}) : super(key: key);

  @override
  _MyWebSocketPage createState() => _MyWebSocketPage();
}

class _MyWebSocketPage extends State<MyWebSocketPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _sendMessage() async {
    final audioData = await this.processAudioFile();
    widget.channel.sink.add(json.encode(
        {"audio_data": audioData, "user_id": 1.toInt(), "topic": "sports"}));
  }

  Future<List<int>> processAudioFile() async {
    String path = "assets/2secondAudio.aac";
    ByteData file = await rootBundle.load(path);

    Uint8List uint8list =
        file.buffer.asUint8List(file.offsetInBytes, file.lengthInBytes);
    List<int> fileBytes = uint8list.cast<int>();

    return fileBytes;
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'OFF-TOP',
          style: TextStyle(
              color: Colors.black45, fontSize: 30, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(children: <Widget>[
        Row(children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(20.0),
          ),
          StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData
                    ? "Server is receiving data"
                    : 'Waiting for connection to establish..',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              );
            },
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Send Data To Websocket'),
              color: Colors.blue,
              onPressed: _sendMessage,
            ),
            FlatButton(
              child: Text("Go To Main Page"),
              color: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RecordingPage()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
