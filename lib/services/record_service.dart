
// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:incredibclap/models/audio_model.dart';

class PointRecord {

  late Audio audio;
  late Duration duration;

  PointRecord({ required audio, required duration }){
    this.audio = audio;
    this.duration = duration;
  }

} 

class RecordService with ChangeNotifier {

  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool isRecord) {
    _isRecord = isRecord;
    notifyListeners();
  }

  List<PointRecord> listRecord = List.empty(growable: true);

  void addPoint( Duration duration, Audio audio ) {
    if( _isRecord ) listRecord.add(PointRecord(audio: audio ,duration: duration));
  }

}