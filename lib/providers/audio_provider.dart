import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:incredibclap/models/models.dart';

class AudiosProvider with ChangeNotifier {

  final List<Audio> _audios = [
    Audio( id: 0, pathAudio: 'assets/audios/1_Base_cajon.mp3', pathIcon: "1", pathMusicSheet: ""),
    Audio( id: 1, pathAudio: 'assets/audios/2_Base_palmas.mp3', pathIcon: "2", pathMusicSheet: ""),
    Audio( id: 2, pathAudio: 'assets/audios/3_Acento_base_palmas.mp3', pathIcon: "3", pathMusicSheet: ""),
    Audio( id: 3, pathAudio: 'assets/audios/4_Contra_1.mp3', pathIcon: "4", pathMusicSheet: ""),
    Audio( id: 4, pathAudio: 'assets/audios/5_Contra_2.mp3', pathIcon: "5", pathMusicSheet: ""),
    Audio( id: 5, pathAudio: 'assets/audios/6_Contra_3.mp3', pathIcon: "6", pathMusicSheet: ""),
    Audio( id: 6, pathAudio: 'assets/audios/7_Contra_4.mp3', pathIcon: "7", pathMusicSheet: ""),
    Audio( id: 7, pathAudio: 'assets/audios/8_Tresillo_taconeo_1.mp3', pathIcon: "8", pathMusicSheet: ""),
    Audio( id: 8, pathAudio: 'assets/audios/9_Tresillo_taconeo_2.mp3', pathIcon: "9", pathMusicSheet: ""),
    Audio( id: 9, pathAudio:'assets/audios/10_Cierre.mp3', pathIcon: "10", pathMusicSheet: ""),
  ];
  List<Audio> get audios => _audios;

  List<dynamic> _dragAudio = List.generate(10, (index) => false);
  List<dynamic> get dragAudio => _dragAudio;
  set dragAudio( List<dynamic> value ){
    _dragAudio = value;
    notifyListeners();
  }

  bool dragContaintAudio( int ind, Audio audio ) {
    return _dragAudio[ind] != false && audio.indDrag != -1 ? true : false;
  }

  Audio setInitAudioDrag( int indDrag ) {
    return _dragAudio[indDrag] == false ? Audio() : _dragAudio[indDrag];
  }

  void addAudioInDrag( Audio audio, int indDrag ) {
    audio.indDrag = indDrag;
    _dragAudio[indDrag] = audio;
    notifyListeners();
  }

  void removeAudioInDrag( Audio value) {
    _dragAudio = _dragAudio.mapIndexed( (index, element) => index == value.indDrag ? false : element ).toList();
    value.indDrag = -1;
    notifyListeners();
  }
  
  
}