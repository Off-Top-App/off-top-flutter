import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MyWebSocket {
  MyWebSocket(String channel) {
    this.channel = IOWebSocketChannel.connect(channel);
  }

  WebSocketChannel channel;

  Future<void> sendAudioFile(
      String exportedAudioData, int userID, String topic) async {
    final List<int> audioData = await processAudioFile(exportedAudioData);
    channel.sink.add(
      json.encode(
        {'audio_data': audioData, 'user_id': userID.toInt(), 'topic': topic},
      ),
    );
  }

  void sendFirstMessage(int user_id) {
    // sleep(const Duration(seconds: 3));
    channel.sink.add(
      json.encode(
        {'user_id': user_id.toInt()},
      ),
    );
  }

  Future<List<int>> processAudioFile(String audioData) async {
    final ByteData file = await rootBundle.load(audioData);

    final Uint8List uint8list =
        file.buffer.asUint8List(file.offsetInBytes, file.lengthInBytes);
    final List<int> fileBytes = uint8list.cast<int>();

    return fileBytes;
  }
}
