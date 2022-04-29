
import 'package:just_audio/just_audio.dart';

class Audio {

  final _player = AudioPlayer();

  late final int _id;
  late final String _musicSheet;
  late final String _icon;
  late final String _iconDisable;
  late int indDrag;

  Audio({ id = -1, pathAudio ="", pathMusicSheet="", pathIcon="" , pathIconDisable=""}) {
    initAudio(pathAudio);
    _id = id;
    _musicSheet = pathMusicSheet;
    _icon = pathIcon;
    _iconDisable = pathIconDisable;
    indDrag = -1;
  }

  int get id => _id;
  AudioPlayer get player => _player;
  String get musicSheet => _musicSheet;
  String get icon => _icon;
  String get iconDisable => _iconDisable;

  void initAudio( pathAudio ) async {
    if(pathAudio != "") {
      await _player.setAsset(pathAudio, preload: true );
      await _player.setLoopMode(LoopMode.all);
      _player.setVolume(0);
    }
  }



}