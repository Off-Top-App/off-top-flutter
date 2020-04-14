import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:off_top_mobile/routing/router.dart' as router;

void main() => runApp(WebsocketPage());

class WebsocketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect("ws://localhost:9000/name"
        // In case you're unable to connect to websocket try uncommenting this string below
        // "ws://10.0.2.2:8080/name"
        );
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

  void _sendMessage() {
    widget.channel.sink.add(json.encode({"message": "data"}));
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
              print("connection state ${snapshot.connectionState}");
              print("data ${snapshot.data}");
              print("error ${snapshot.error}");
              return Text(
                snapshot.hasData
                    ? "Websocket info: " + '${snapshot.data} '
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
