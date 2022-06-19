import 'dart:io';

import 'package:flutter/services.dart';
import 'package:incredibclap/models/models.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AudioTab {
  final _player = AudioPlayer();

  late final int _id;
  late final String _icon;
  late final String _pathAudio;
  late final Audio _audio;
  Audio get audio => _audio;

  AudioTab({id = -1, pathAudio = "", pathIcon = ""}) {
    initAudio(pathAudio);
    _pathAudio = pathAudio;
    _id = id;
    _icon = pathIcon;
    _audio = Audio(id: id, pathAudio: pathAudio);
  }

  int get id => _id;
  AudioPlayer get player => _player;
  String get icon => _icon;

  void initAudio(String pathAudio) async {
    if (pathAudio != "") {
      var content = await rootBundle.load("assets/audios/$pathAudio");
      final directory = await getApplicationDocumentsDirectory();
      var file = File("${directory.path}/$pathAudio");
      file.writeAsBytesSync(content.buffer.asUint8List());
      await _player.setFilePath(file.path);
    }
  }

  void play() {
    _player.play();
    initAudio(_pathAudio);
  }
}
