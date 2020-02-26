import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect(
      "ws://localhost:8080/name"
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        channel: channel
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;
  final String title;
  MyHomePage({Key key, this.title, this.channel}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: 100,
          height: 100,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white70,
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
      body: Column(
        children: [
          Image.asset('assets/placeholderWave.gif'),
          Image.asset('assets/placeholderMeter.png'),
          StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot){
              print("connection state ${snapshot.connectionState}");
              print("data ${snapshot.data}");
              print("error ${snapshot.error}");
              return Text(
                "Websocket info: " + '${snapshot.data} ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300
                ),
              );
            } ,
          ),
          FlatButton(
            child: Text('Send Data To Websocket'),
            color: Colors.blue,
            onPressed: _sendMessage,
          )
        ],
      ),
      bottomNavigationBar:
        new BottomNavigationBar(
          backgroundColor: Colors.deepPurple, items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Home', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Reports', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30.0,
            ),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.white
          ),
        ]
      ),
    );
  }
  
  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  void _sendMessage() {
    widget.channel.sink.add(
      json.encode({
        "message":"data"
      })
    );
  }
}
