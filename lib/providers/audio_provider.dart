import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';

class AudiosProvider with ChangeNotifier {

  List<Audio> _playNow = [];
  final List<Audio> _audios = [
    Audio( id: 1, pathAudio: 'assets/audios/1_Base_cajon.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 2, pathAudio: 'assets/audios/2_Base_palmas.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 3, pathAudio: 'assets/audios/3_Acento_base_palmas.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 4, pathAudio: 'assets/audios/4_Contra_1.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 5, pathAudio: 'assets/audios/5_Contra_2.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 6, pathAudio: 'assets/audios/6_Contra_3.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 7, pathAudio: 'assets/audios/7_Contra_4.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 8, pathAudio: 'assets/audios/8_Tresillo_taconeo_1.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 9, pathAudio: 'assets/audios/9_Tresillo_taconeo_2.mp3', pathIcon: "", pathMusicSheet: ""),
    Audio( id: 10, pathAudio:'assets/audios/10_Cierre.mp3', pathIcon: "", pathMusicSheet: ""),
  ];

  List<Audio> get audios => _audios;
  
  List<Audio> get playNow => _playNow;
  set playNow(List<Audio> value) {
    _playNow = value;
    notifyListeners();
  }



}