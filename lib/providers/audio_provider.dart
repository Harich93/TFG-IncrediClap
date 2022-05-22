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
  late List<AudioTab> _audiosTab;

  AudiosProvider() {
    _audios = lstAudios.toList();
    _audiosTab = lstAudiosTab.toList();
  }

  List<Audio> get audios => _audios;
  List<AudioTab> get audiostab => _audiosTab;
  List<Audio> get nowPlaying => audios.where( (val) => val.player.volume == 1 ).toList();

 
  bool dragContaintAudio( int ind ) {
    return nowPlaying[ind].id != -1 ? true : false;
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
  }

  void stopAll(){
    for (Audio audio in _audios) {
      // audio.player.setVolume(0);
      audio.player.dispose();
    }
  }
}