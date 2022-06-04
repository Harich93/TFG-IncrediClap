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
  late List<Audio> dragAudio;

  List<Audio> get audios => _audios;
  List<AudioTab> get audiostab => _audiosTab;
  
  AudiosProviderPlayer() {
    _audios = lstAudios.toList();
    _audiosTab = lstAudiosTab.toList();
    dragAudio = List.generate(8, (index) => Audio(id: -1));
  }

  void resetAudios() {
    for (Audio aud in _audios) {
      aud.player.dispose();
    }
    _audios = lstAudios.toList();
  }


  bool dragContaintAudio( int ind ) {
    return dragAudio[ind].id != -1 ? true : false;
  }

  void resetAudiosProviderPlayer() {
    for (var item in dragAudio) {
      if( item.id != -1){
        item.player.setVolume(0.0);
      }
    }
    dragAudio = List.generate(8, (index) => Audio(id: -1));
    notifyListeners();
  }

  bool isDragAudiosEmpty() {

    int cont = 0;

    for (var a in dragAudio) {
      a.id == -1 ? cont++ : null;
    }
    
    return cont == 8 ? true : false;

  }
  
  void playAll(){
    for (var audio in _audios) {
      audio.player.play();
    }
  }

  void stopAll(){
    for (var audio in _audios) {
      // audio.player.dispose();
      audio.player.setVolume(0);
    }
  }

  void pauseAll(){
    for (var audio in _audios) {
      // audio.player.dispose();
      audio.player.pause();
    }
  }
}