import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/components/recordingSession/websocket.dart';

class OffTopVal extends StatefulWidget{
  int userId;
  MyWebSocket ws;
  OffTopVal({
    Key key,
    @required this.ws,
    @required this.userId
  }) :super(key: key);

  _OffTopState createState() => _OffTopState();
}

class _OffTopState extends State<OffTopVal>{
  MyWebSocket ws;
  int userId;
  int focusScore = 70;
  String focusState = 'On Topic';
  // int incomingData;
  @override
  void initState() {
    this.userId = widget.userId;
    this.ws = widget.ws;
    this.ws.sendFirstMessage(this.userId);
    this.ws.channel.stream.listen((data){
      var incomingData = json.decode(data);
      var focusVal = incomingData['focus_score'];
      if(focusVal == true){
        setState(() {
          focusScore +=5;
        });
      }else{
        setState(() {
          focusScore -=5;
        });
      }
      if( focusScore >= 100){
        setState(() {
          focusScore = 100;
        });
      }
      if( focusScore <= 0){
        focusScore = 0;
      }
      this.determineFocusState(focusScore);
    });
    super.initState();
  }

  void determineFocusState(int focusScore){
    print('focusScore: ${this.focusScore}');
    if(focusScore >= 66){
      setState(() {
        focusState = 'On Topic';
      });
    }else if(focusScore >= 33 && focusScore < 66){
      setState(() {
        focusState = 'Getting Off-Topic';
      });
    }else{
      setState(() {
        focusState = 'Off Topic';
      });
    }
  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Text(
      "Focus Score: $focusScore\nFocus State: $focusState",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }


}