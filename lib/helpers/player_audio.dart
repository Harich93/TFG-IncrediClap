
import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';

class PlayerAudio with ChangeNotifier {

  final Duration _resetDuration = const Duration(seconds: 0);
  final List<String> _pathsAudios = [
    'assets/audios/1_Base_cajon.mp3',
    'assets/audios/2_Base_palmas.mp3',
    'assets/audios/3_Acento_base_palmas.mp3',
    'assets/audios/4_Contra_1.mp3',
    'assets/audios/5_Contra_2.mp3',
    'assets/audios/6_Contra_3.mp3',
    'assets/audios/7_Contra_4.mp3',
    'assets/audios/8_Tresillo_taconeo_1.mp3',
    'assets/audios/9_Tresillo_taconeo_2.mp3',
    'assets/audios/10_Cierre.mp3',
  ];
  final List<AudioTab> _playerAudiosTabs = [
    AudioTab( id: 10, pathAudio: 'assets/audios/Tabs/Palma_01.wav'),
    AudioTab( id: 11, pathAudio: 'assets/audios/Tabs/Palma_02.wav'),
    AudioTab( id: 12, pathAudio: 'assets/audios/Tabs/Palma_03.wav'),
    AudioTab( id: 13, pathAudio: 'assets/audios/Tabs/Palma_04.wav'),
    AudioTab( id: 14, pathAudio: 'assets/audios/Tabs/Tacon_01.wav'),
    AudioTab( id: 15, pathAudio: 'assets/audios/Tabs/Tacon_02.wav'),
  ];

  late RecordService sRecord;
  late DurationModelPlayer sDuration;
  late Track _currentTrack;
  late Duration _lastDuration;
  late String _title;
  late String _userName;

  List<Track> _tracks = List.empty(growable: true);
  List<Audio> _playerAudios = List.empty(growable: true);
  
  bool _isPlaying = false;
  bool _isFirstPlay = true;


  //^Constructor
  PlayerAudio({required this.sRecord, required this.sDuration }) {

    _init();
    _initAudios();
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

  void _init(){
    _title = sRecord.selectedAudioRecord.title;
    _userName = sRecord.selectedAudioRecord.userName;
    _tracks = sRecord.selectedAudioRecord.tracks.toList();
    _currentTrack = _tracks[0];
    _lastDuration = sRecord.selectedAudioRecord.tracks.last.parseDuration();
  }

  void _initAudios(){

    for( Track track in _tracks ) {
      
      track.idAudio < 10 

        ? _playerAudios.add(
            Audio(
              id: track.idAudio, 
              pathAudio: _pathsAudios[track.idAudio]
            )
        ) : null;

    } 
  }

  void resetAudios(){

    _isPlaying = false;
    _isFirstPlay = true; 
    
    for (var audio in _playerAudios) {
      audio.player.setVolume(0);
    }

    _playerAudios = [];

    _init();
    _initAudios();

    sDuration.current = _resetDuration;
    sDuration.soundDuration = _resetDuration;
    
  }
  
  // End


  //^ Reproducir

  void playPause() {
    
    if( _isFirstPlay ) {
      _play();
      _playRecord();
      _isFirstPlay = false;
    }

    else {
      isPlaying
        ? _pause()
        : _play();
    } 

  }

  void _playRecord() {

    sDuration.soundDuration = _tracks.last.parseDuration();

    _playerAudios[0].player.createPositionStream().listen( (duration) {
      
      sDuration.current = duration;

      if( _tracks.isNotEmpty ) {

        if( _currentTrack.parseDuration().inSeconds == duration.inSeconds ) { 

          if(isPlaying) {

            _currentTrack.idAudio < 10 
              ? _playAudio()
              : _playAudioTab();
          
          }

          _nextTrack();
        }
      }
      
      else{
        sDuration.controller.stop();
        _isPlaying = false;
        _isFirstPlay = true;
      }
    });
  }

  void _playAudio(){
    for (Audio audio in _playerAudios) {
      if( audio.id == _currentTrack.idAudio ) audio.player.setVolume(_currentTrack.volume);
    }
  }

  void _playAudioTab() {
    for (AudioTab audioTab in _playerAudiosTabs) {
      if( audioTab.id == _currentTrack.idAudio ) audioTab.play();
    }
  }

  void _play(){

    _isPlaying = true;
    sDuration.controller.repeat();

    for (var audio in _playerAudios) {
      audio.player.play();
    }
  }

  void _pause(){

    _isPlaying = false;
    sDuration.controller.stop();
    
    for (var audio in _playerAudios) {
      audio.player.pause();
    }

  }
 
  void _nextTrack() {
    _tracks.removeAt(0);
    _tracks.isNotEmpty
      ? _currentTrack = _tracks[0]
      : resetAudios();
  }
  // End
}
