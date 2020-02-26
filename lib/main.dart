import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect(
      "ws://localhost:8080/name"
    );
    return MaterialApp(
      title: 'Flutter Demo',
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
  MyHomePage({Key key, this.title, this.channel}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _sendMessage() {
    widget.channel.sink.add(
      json.encode({
        "message": {"data": "hello from flutter"},
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot){
                print("connection state ${snapshot.connectionState}");
                print("data ${snapshot.data}");
                print("error ${snapshot.error}");
                return Text("here: " + '${snapshot.data}');
                // return Text(snapshot.hasData ? "here: " + '${snapshot.data}' : 'Waiting for data');
              } ,
            ),
            FlatButton(
              child: Text('test websocket'),
              color: Colors.blue,
              onPressed: _sendMessage,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
