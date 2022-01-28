
import 'package:just_audio/just_audio.dart';

class Sample {

  final _player = AudioPlayer();

  late final int _id;
  late final String _musicSheet;
  late final String _icon;

  Sample({ id ,pathAudio, pathMusicSheet, pathIcon }) {
    initAudio(pathAudio);
    _id = id;
    _musicSheet = pathMusicSheet;
    _icon = pathIcon;
  }

  int get id => _id;
  AudioPlayer get audio => _player;
  String get musicSheet => _musicSheet;
  String get icon => _icon;

  void initAudio( pathAudio ) async {
    await _player.setAsset(pathAudio, preload: true);
    _player.setVolume(0);
    _player.play();
  }

}