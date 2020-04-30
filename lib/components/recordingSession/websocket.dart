import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:typed_data';

class MyWebSocket {
  WebSocketChannel channel;

  MyWebSocket(String channel) {
    this.channel = IOWebSocketChannel.connect(channel);
  }

  void sendAudioFile(exportedAudioData, userID, topic) async {
    final audioData = await this.processAudioFile(exportedAudioData);
    this.channel.sink.add(json.encode(
      {"audio_data": audioData, "user_id": userID.toInt(), "topic": topic})
    );
  }

  void sendFirstMessage(user_id){
    // sleep(const Duration(seconds: 3));
    this.channel.sink.add(json.encode(
      {"user_id": user_id.toInt()})
    );
  }

  Future<List<int>> processAudioFile(audioData) async {
    ByteData file = await rootBundle.load(audioData);

    Uint8List uint8list =
        file.buffer.asUint8List(file.offsetInBytes, file.lengthInBytes);
    List<int> fileBytes = uint8list.cast<int>();

    return fileBytes;
  }
}
