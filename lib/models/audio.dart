import 'dart:io';

import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class Audio {
  final _player = AudioPlayer();

  late final int _id;
  late final String _musicSheet;
  late final String _icon;
  late final String _cite;
  late final String _iconDisable;

  Audio(
      {id = -1,
      pathAudio = "",
      pathMusicSheet = "",
      pathIcon = "",
      pathIconDisable = "",
      cite = ""}) {
    initAudio(pathAudio);
    _cite = cite;
    _id = id;
    _musicSheet = pathMusicSheet;
    _icon = pathIcon;
    _iconDisable = pathIconDisable;
  }

  int get id => _id;
  AudioPlayer get player => _player;
  String get musicSheet => _musicSheet;
  String get icon => _icon;
  String get iconDisable => _iconDisable;
  String get cite => _cite;

  void initAudio(pathAudio) async {
    if (pathAudio != "") {
      var content = await rootBundle.load("assets/audios/$pathAudio");
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/$pathAudio");
      file.writeAsBytesSync(content.buffer.asUint8List());
      await _player.setFilePath(file.path);
      await _player.setLoopMode(LoopMode.all);
      _player.setVolume(0);
    }
  }
}
