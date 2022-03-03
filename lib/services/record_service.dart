
// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:incredibclap/services/services.dart';


class PointRecord {

  late int idAudio;
  late Duration duration;

  PointRecord({ required idAudio, required duration }){
    this.idAudio = idAudio;
    this.duration = duration;
  }

  factory PointRecord.fromJson(String str) => PointRecord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PointRecord.fromMap(Map<String, dynamic> json) => PointRecord(
      idAudio: json["idAudio"],
      duration: json["duration"],
  );

  Map<String, dynamic> toMap() => {
      "idAudio": idAudio,
      "duration": duration.inSeconds.toInt(),
  };


} 

class RecordService with ChangeNotifier {

  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool isRecord) {
    _isRecord = isRecord;
    notifyListeners();
  }

  List<PointRecord> listRecord = List.empty(growable: true);
  final String _baseUrl = 'incredibclap-backend-ts.herokuapp.com';


  void addPoint( Duration duration, int idAudio ) {
    if( _isRecord ) listRecord.add(PointRecord(idAudio: idAudio ,duration: duration));
  }


   Future<Map<String, dynamic>> addAudio() async{

    final Map<String, dynamic> body = {
      'track': listRecord,
    };

    final url = Uri.http( _baseUrl, '/audios/add' );

    final resp = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'x-token': Preferences.token
    });

    final Map<String, dynamic> resDecode =  json.decode( resp.body );
    
    return resDecode;

  }


}