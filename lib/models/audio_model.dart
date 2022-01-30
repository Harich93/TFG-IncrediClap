
import 'package:just_audio/just_audio.dart';

class Audio {

  final _player = AudioPlayer();

  late final int _id;
  late final String _musicSheet;
  late final String _icon;
  late int indDrag;

  Audio({ id = -1,pathAudio ="", pathMusicSheet="", pathIcon="" }) {
    initAudio(pathAudio);
    _id = id;
    _musicSheet = pathMusicSheet;
    _icon = pathIcon;
    indDrag = -1;
  }

  int get id => _id;
  AudioPlayer get player => _player;
  String get musicSheet => _musicSheet;
  String get icon => _icon;

  void initAudio( pathAudio ) async {
    if(pathAudio != "") {
      await _player.setAsset(pathAudio, preload: true );
      _player.setVolume(0);
      _player.play();
    }
  }

}