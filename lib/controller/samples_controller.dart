import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';

class SamplesController with ChangeNotifier {

  List<Sample> _currentPlay = [];
  final List<Sample> _samples = [
    Sample( id: 1, pathAudio: 'assets/audios/1_Base_cajon.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 2, pathAudio: 'assets/audios/2_Base_palmas.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 3, pathAudio: 'assets/audios/3_Acento_base_palmas.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 4, pathAudio: 'assets/audios/4_Contra_1.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 5, pathAudio: 'assets/audios/5_Contra_2.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 6, pathAudio: 'assets/audios/6_Contra_3.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 7, pathAudio: 'assets/audios/7_Contra_4.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 8, pathAudio: 'assets/audios/8_Tresillo_taconeo_1.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 9, pathAudio: 'assets/audios/9_Tresillo_taconeo_2.mp3', pathIcon: "", pathMusicSheet: ""),
    Sample( id: 10, pathAudio:'assets/audios/10_Cierre.mp3', pathIcon: "", pathMusicSheet: ""),
  ];

  List<Sample> get samples => _samples;
  
  List<Sample> get currentPlay => _currentPlay;
  set currentPlay(List<Sample> value) {
    _currentPlay = value;
    notifyListeners();
  }



}