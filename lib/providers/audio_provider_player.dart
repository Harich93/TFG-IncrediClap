import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/models/s_audios.dart';

class AudiosProviderPlayer with ChangeNotifier {

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  bool _firstTime = true;
  bool get firstTime => _firstTime;
  set firstTime(bool firstTime) {
    _firstTime = firstTime;
    notifyListeners();
  }

  late List<Audio> _audios;
  late List<AudioTab> _audiosTab;
  

  List<Audio> get audios => _audios;
  List<AudioTab> get audiostab => _audiosTab;
  
  AudiosProviderPlayer() {
    _audios = lstAudios;
    _audiosTab = lstAudiosTab;
  }

  void resetAudios() {
    for (Audio aud in _audios) {
      aud.player.dispose();
    }
    _audios = lstAudios;
  }

  void setAllVolume0(){
    for (var audio in _audios) {
      audio.player.setVolume(0);
    }
  }
  
  void setAllVolume1(){
    for (var audio in _audios) {
      audio.player.setVolume(1);
    }
  }

  void playAll(){
    for (var audio in _audios) {
      audio.player.play();
    }
  }

  void pauseAll(){
    for (var audio in _audios) {
      audio.player.pause();
    }
  }
}