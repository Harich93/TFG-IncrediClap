import 'package:flutter/material.dart';

class MenuHidden with ChangeNotifier {

  double _hidden = 0;

  double get hidden => _hidden;
  set hidden(double value) {
    _hidden = value;
    notifyListeners();
  }

}

