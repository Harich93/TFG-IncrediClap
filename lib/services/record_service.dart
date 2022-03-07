
// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';


class RecordService with ChangeNotifier {

  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool isRecord) {
    _isRecord = isRecord;
    notifyListeners();
  }

  List<Track> listTrack = List.empty(growable: true);
  final String _baseUrl = 'incredibclap-backend-ts.herokuapp.com';


  void addPoint( Duration duration, Audio audio ) {

    Track track = Track( 
      idAudio: audio.id, 
      volume: audio.player.volume, 
      duration: duration.inSeconds.toString() 
    );

    if( _isRecord ) listTrack.add( track );

  }


  Future<Map<String, dynamic>> addAudio() async{

    final Map<String, dynamic> body = {
      'name' : "Pista",
      'track': listTrack,
    };

    final url = Uri.http( _baseUrl, '/audios/add' );

    final resp = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'x-token': Preferences.token
    });

    final Map<String, dynamic> resDecode = await json.decode( resp.body );
    
    return resDecode;

  }

  Future<AudioRecord> getAudio() async{

    final url = Uri.http( _baseUrl, '/audios/62248217efe1b5bc78f1de58' );

    final resp = await http.get(url, headers: { 'Content-Type': 'application/json', });

    final Map<String, dynamic> resDecode = await json.decode( resp.body );

    List<Track> tracks = List<Track>.empty(growable: true);

    for ( var track in resDecode["track"] ) {
      var t = jsonDecode(track);
      Track tr = Track.fromMap(t);
      tracks.add(tr);
    }


    AudioRecord audioRecord = AudioRecord(tracks: tracks, name: "name");
    
    return audioRecord;

  }

   Future<AudioRecord> getAllAudios() async{

    final url = Uri.http( _baseUrl, '/audios' );

    final resp = await http.get(url, headers: { 'Content-Type': 'application/json', });

    final Map<String, dynamic> resDecode = await json.decode( resp.body );

    List<Track> tracks = List<Track>.empty(growable: true);

    for ( var track in resDecode["track"] ) {
      var t = jsonDecode(track);
      Track tr = Track.fromMap(t);
      tracks.add(tr);
    }


    AudioRecord audioRecord = AudioRecord(tracks: tracks, name: "name");
    
    return audioRecord;

  }

}