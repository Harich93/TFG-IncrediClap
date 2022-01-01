
// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioPlayerModel extends ChangeNotifier {

  bool _playing = false;
  Duration _soundDuration = const Duration(milliseconds: 0);
  Duration _current = const Duration(milliseconds: 0);

  String get soundTotalDuration => _printDuration( _soundDuration );
  String get currentSecond => _printDuration( _current );

  double get porcentaje => _soundDuration.inSeconds > 0 
                            ? _current.inSeconds / _soundDuration.inSeconds
                            : 0;

  late AnimationController _controller;
  set controller( AnimationController value ) {
    _controller = value;
  }

  AnimationController get controller => _controller;

  bool get playing => _playing;
  set playing( bool value ) {
    _playing = value;
    notifyListeners();
  }

  Duration get soundDuration => _soundDuration; 
  set soundDuration( Duration value ) {
    _soundDuration = value;
    notifyListeners();
  }
  Duration get current => _current;
  set current( Duration value ) {
    _current = value;
    notifyListeners();
  }

  String _printDuration( Duration duration ) {
    String towoDigits(int n) {
      if( n>=10 ) return '$n';
      return '0$n';
    }

    String twoDigitMinutes = towoDigits( duration.inMinutes.remainder(60) );
    String twoDigitSeconds = towoDigits( duration.inSeconds.remainder(60) );

    return '$twoDigitMinutes:$twoDigitSeconds';

  }

}