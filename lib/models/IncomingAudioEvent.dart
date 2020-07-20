class IncomingAudioEvent{
  IncomingAudioEvent(
    this.audioData,
    this.userId,
    this.topic,
    this.timeExported
  );

  List<int> audioData;
  int userId;
  String topic;
  String timeExported;


  Map<String, dynamic> toJson() => {
    'audio_data': audioData,
    'user_id': userId,
    'topic': topic,
    'time_exported': timeExported
  };
}