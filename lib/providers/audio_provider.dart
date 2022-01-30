import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:incredibclap/models/models.dart';

class AudiosProvider with ChangeNotifier {

  final List<Audio> _audios = [
    Audio( id: 0, pathAudio: 'assets/audios/1_Base_cajon.mp3', pathIcon: "1", pathMusicSheet: "assets/sheets/1.jpg"),
    Audio( id: 1, pathAudio: 'assets/audios/2_Base_palmas.mp3', pathIcon: "2", pathMusicSheet: "assets/sheets/2.jpg"),
    Audio( id: 2, pathAudio: 'assets/audios/3_Acento_base_palmas.mp3', pathIcon: "3", pathMusicSheet: "assets/sheets/3.jpg"),
    Audio( id: 3, pathAudio: 'assets/audios/4_Contra_1.mp3', pathIcon: "4", pathMusicSheet: "assets/sheets/4.jpg"),
    Audio( id: 4, pathAudio: 'assets/audios/5_Contra_2.mp3', pathIcon: "5", pathMusicSheet: "assets/sheets/5.jpg"),
    Audio( id: 5, pathAudio: 'assets/audios/6_Contra_3.mp3', pathIcon: "6", pathMusicSheet: "assets/sheets/6.jpg"),
    Audio( id: 6, pathAudio: 'assets/audios/7_Contra_4.mp3', pathIcon: "7", pathMusicSheet:"assets/sheets/7.jpg"),
    Audio( id: 7, pathAudio: 'assets/audios/8_Tresillo_taconeo_1.mp3', pathIcon: "8", pathMusicSheet: "assets/sheets/8.jpg"),
    Audio( id: 8, pathAudio: 'assets/audios/9_Tresillo_taconeo_2.mp3', pathIcon: "9", pathMusicSheet: "assets/sheets/9.jpg"),
    Audio( id: 9, pathAudio:'assets/audios/10_Cierre.mp3', pathIcon: "10", pathMusicSheet: "assets/sheets/10.jpg"),
  ];
  List<Audio> get audios => _audios;

  final List<AudioTab> _audiosTab = [
    AudioTab( id: 0, pathAudio: 'assets/audios/Tabs/Palma_01.wav', pathIcon: "Palma1"),
    AudioTab( id: 1, pathAudio: 'assets/audios/Tabs/Palma_02.wav', pathIcon: "Palma2"),
    AudioTab( id: 2, pathAudio: 'assets/audios/Tabs/Palma_03.wav', pathIcon: "Palma3"),
    AudioTab( id: 3, pathAudio: 'assets/audios/Tabs/Palma_04.wav', pathIcon: "Palma4"),
    AudioTab( id: 4, pathAudio: 'assets/audios/Tabs/Tacon_01.wav', pathIcon: "Tacon1"),
    AudioTab( id: 5, pathAudio: 'assets/audios/Tabs/Tacon_02.wav', pathIcon: "Tacon2"),
  ];
  List<AudioTab> get audiostab => _audiosTab;

  List<dynamic> _dragAudio = List.generate(10, (index) => false);
  List<dynamic> get dragAudio => _dragAudio;
  set dragAudio( List<dynamic> value ){
    _dragAudio = value;
    notifyListeners();
  }

  bool dragContaintAudio( int ind, Audio audio ) {
    return _dragAudio[ind] != false && _dragAudio[ind].id != -1 ? true : false;
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