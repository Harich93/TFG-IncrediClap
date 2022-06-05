import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/models/s_audios.dart';

class AudiosProvider with ChangeNotifier {
  
  bool _firstPlay = true;
  bool get firstPlay => _firstPlay;
  set firstPlay(bool val) {
    _firstPlay = val;
    notifyListeners();
  }

  bool _isMusicScreen = false;
  bool get isMusicScreen => _isMusicScreen;
  set isMusicScreen(bool isMusicScreen) {
    _isMusicScreen = isMusicScreen;
    notifyListeners();
  }

  late List<Audio> _audios;
  late List<Audio> _nowPlaying;
  late List<AudioTab> _audiosTab;

  AudiosProvider() {
    _audios = lstAudios;
    _audiosTab = lstAudiosTab;
    _nowPlaying = List<Audio>.empty(growable: true);
  }

  List<Audio> get audios => _audios;
  List<AudioTab> get audiostab => _audiosTab;
  List<Audio> get nowPlaying => _nowPlaying; 
  
  void addNowPlaying() {
    _nowPlaying = audios.where( (val) => val.player.volume == 1 ).toList(); 
    notifyListeners();  
  }

  void resetAudiosProvider() {
    for (var item in nowPlaying) {
      if( item.id != -1){
        item.player.setVolume(0.0);
      }
    }
    notifyListeners();
  }

  void changeVolume(Audio audio){
    audio.player.volume == 1
      ? audio.player.setVolume(0)
      : audio.player.setVolume(1);

    notifyListeners();
  }
  
  void playAll(){
    for (Audio audio in _audios) {
      audio.player.play();
    }
    notifyListeners();
  }

  void pauseAll(){
    for (Audio audio in _audios) {
      audio.player.pause();
    }
    notifyListeners();
  }

  void pauseNowPlaying() {
    for (Audio audio in _nowPlaying) {
      audio.player.setVolume(0);
    }
    notifyListeners();
  }
  
  void playNowPlaying() {
    for (Audio audio in _nowPlaying) {
      audio.player.setVolume(1);
    }
    notifyListeners();
  }

  void stopAll(){
    for (Audio audio in _audios) {
      audio.player.setVolume(0);
    }
    notifyListeners();
  }
}