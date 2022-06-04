
// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incredibclap/models/s_audios.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';

class PlayerAudio with ChangeNotifier {

  final Duration _zeroDuration = const Duration(seconds: 0);
  late RecordService sRecord;
  late DurationModelPlayer sDuration;
  late Track _currentTrack;
  late Duration _lastDuration;
  late String _title;
  late String _userName;

  late StreamSubscription<Duration> stream;
  Duration _initDuration = const Duration(minutes: 0, seconds: 0, milliseconds: 0);
  List<Track> _tracks = List.empty(growable: true);
  Map _tracksRemove = {};
  List<Audio> _playerAudios = List.empty(growable: true);
  List<AudioTab> _playerAudiosTabs = List.empty(growable: true);
  
  bool _isPlaying = false;
  bool _isFirstPlay = true;


  //^Constructor
  PlayerAudio({required this.sRecord, required this.sDuration }) {

    _playerAudios = lstAudios.toList();
    _playerAudiosTabs = lstAudiosTab.toList();
    
    for(Audio val in _playerAudios ) {
      val.player.play();
    }

    _playRecord();
  }

  //^ Getter & Setters

  bool get isPlaying => _isPlaying;
  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }
  
  Duration get lastDuration => _lastDuration;
  set lastDuration(Duration lastDuration) {
    _lastDuration = lastDuration;
    notifyListeners();
  }

  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String get userName => _userName;
  set userName(String userName) {
    _userName = userName;
    notifyListeners();
  }
  
  // End

  //^ Init & Reset

  void init(){
    _title = sRecord.selectedAudioRecord.title;
    _userName = sRecord.selectedAudioRecord.userName;
    _tracks = sRecord.selectedAudioRecord.tracks.toList();
    _currentTrack = _tracks[0];
    _lastDuration = sRecord.selectedAudioRecord.tracks.last.parseDuration();
    sDuration.soundDuration = _tracks.last.parseDuration();
  }

  void resetTrack(){
    isPlaying = false;
    _isFirstPlay = true; 
    
    for (Audio val in _playerAudios) {
      val.player.setVolume(0);
    }

    _tracks = sRecord.selectedAudioRecord.tracks.toList();
    _currentTrack = _tracks[0];
    stream.pause();
    stream.cancel();
    sDuration.current = _zeroDuration;
    notifyListeners();
  }
  
  // End


  //^ Reproducir

  void playPause() {
    
    if( _isFirstPlay ) {
      _play();
      _playRecord();
    }

    else {
      isPlaying
        ? _pause()
        : _play();
    } 
    notifyListeners();
  }

  void _playRecord() {

    stream = _playerAudios[0].player.createPositionStream().listen( (duration) {  
      if(isPlaying) {
  
        if(_isFirstPlay) {
          _initTracks();
          _initDuration = _zeroDuration - duration;
          _isFirstPlay = false;
        }
        
        sDuration.current = _initDuration + duration;

        if(sDuration.current >= sDuration.soundDuration){resetTrack();}
        else if(_currentTrack.parseDuration().inSeconds == sDuration.current.inSeconds) { 
        
          _currentTrack.idAudio < 8
            ? _playAudio()
            : _playAudioTab();
          
          _nextTrack();
        
        }
      }

    });
    _playerAudios[0].player.createPositionStream().listen((event) { }).cancel();
  }

  void _playAudio(){
    for (Audio audio in _playerAudios) {
      if(_tracksRemove.containsKey(audio.id)) {
        audio.player.setVolume(_tracksRemove[audio.id]);
      }
      else if( audio.id == _currentTrack.idAudio ) {
        audio.player.setVolume(_currentTrack.volume);
      }
    }
  }

  void _playAudioTab() {
    for (AudioTab val in _playerAudiosTabs) {
      if(val.id == _currentTrack.idAudio) val.play();
    }
  }

  void _play(){
    isPlaying = true;
    sDuration.controller.repeat();
    _playAudio();
  }

  void _pause(){
    isPlaying = false;
    sDuration.controller.stop();
    for (Audio val in _playerAudios) { val.player.setVolume(0);}
  }
 
  void _nextTrack() {
    _tracksRemove[_tracks[0].idAudio] = _tracks[0].volume;
    _tracks.removeAt(0);
    _tracks.isNotEmpty
      ? _currentTrack = _tracks[0]
      : null;

  }

  void _initTracks() {
    int aux = 0;
    for(Track t in _tracks) {
      if(t.duration == "0") {
        _tracksRemove[t.idAudio] = t.volume;
        _currentTrack = t;
        _playAudio();
        aux++;
      }   
    }

    for(int i=0; i<aux; i++ ) {
      _tracks.removeAt(0);
    }
  }
  
  // End
}
