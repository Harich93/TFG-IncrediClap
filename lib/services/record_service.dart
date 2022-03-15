
// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';


class RecordService with ChangeNotifier {

  RecordService(){
    getAllAudios();
    getAudiosUser();
  }

  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool isRecord) {
    _isRecord = isRecord;
    notifyListeners();
  }

  List<Track> listTrack = List.empty(growable: true);
  List<AudioRecord> allAudios = List.empty(growable: true);
  List<AudioRecord> userAudios = List.empty(growable: true);

  List<AudioRecord> selectedListRecord = [];

  late AudioRecord selectedAudioRecord = AudioRecord(tracks: [], title: "");

  final String _baseUrl = 'incredibclap-backend-ts.herokuapp.com';


  void addPoint( Duration duration, Audio audio ) {

    Track track = Track( 
      idAudio: audio.id, 
      volume: audio.player.volume, 
      duration: duration.inSeconds.toString() 
    );

    if( _isRecord ) listTrack.add( track );

  }


  Future<Map<String, dynamic>> addAudio( String title ) async{

    final Map<String, dynamic> body = {
      'title' : title,
      'track' : listTrack,
    };

    final url = Uri.http( _baseUrl, '/audios/add' );

    final resp = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'x-token': Preferences.token
    });

    final Map<String, dynamic> resDecode = await json.decode( resp.body );
    
    listTrack = List.empty(growable: true);

    return resDecode;

  }


  //! <-- Pedir audios guardados --> 

  //^ Todos los audios
  Future<List<AudioRecord>> getAllAudios() async{

    final url = Uri.http( _baseUrl, '/audios/all' );

    final resp = await http.get(url, headers: { 'Content-Type': 'application/json', });

    final Map<String, dynamic> resDecode = await json.decode( resp.body );

    List<dynamic> audios = resDecode["audios"];

    allAudios = List.empty(growable: true);
    return await _parseResponse(audios, allAudios);

  }

  //^ Audios usuario
  Future<List<AudioRecord>> getAudiosUser() async{

    final url = Uri.http( _baseUrl, '/audios/' );

    final resp = await http.get(url, headers: { 
      'Content-Type': 'application/json', 
      'x-token': Preferences.token 
    });

    final List<dynamic> audios = await json.decode( resp.body );


    userAudios = List.empty(growable: true);
    return await _parseResponse(audios, userAudios);
  }
  

  //! <-- Funciones auxiliares ->

  //^ Parseo de respuesta
  Future<List<AudioRecord>> _parseResponse( List<dynamic> audios, List<AudioRecord> listAudios ) async {

    List<Track> tracks = List<Track>.empty(growable: true);
    AudioRecord audioRecord;


    
    for( var audio in audios ) {

      tracks = _parseTracks(audio);
      
      audioRecord = AudioRecord(
        tracks: tracks, 
        title: audio["title"], 
        userName: audio["user_name"]
      );

      if( !listAudios.contains(audioRecord) ) {
        listAudios.add(audioRecord);
      }

      tracks = List<Track>.empty(growable: true);

    }

    return listAudios;
  }

  //^ Paseo respuesta tracks
  List<Track> _parseTracks( dynamic data ) {

    List<Track> tracks = List<Track>.empty(growable: true);

    for ( var track in data["track"] ) {
      var t = jsonDecode(track);
      Track tr = Track.fromMap(t);
      tracks.add(tr);
    }

    return tracks;

  }

}