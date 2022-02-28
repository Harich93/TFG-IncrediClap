
import 'package:incredibclap/models/audio_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioTab {

  final _player = AudioPlayer();
  
  late final int _id;
  late final String _icon;
  late final String _pathAudio;
  late final Audio _audio;
  Audio get audio => _audio;

  AudioTab({ id = -1, pathAudio = "",  pathIcon="" }) {
    initAudio(pathAudio);
    _pathAudio = pathAudio;
    _id = id;
    _icon = pathIcon;
    _audio = Audio(id: id, pathAudio: pathAudio);
  }

  int get id => _id;
  AudioPlayer get player => _player;
  String get icon => _icon;

  void initAudio( String pathAudio ) async {
    if(pathAudio != "") {
      await _player.setAsset(pathAudio, preload: true );
    }
  }

  void play(){
    _player.play();
    initAudio(_pathAudio);
  }

}