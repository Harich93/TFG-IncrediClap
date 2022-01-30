
import 'package:flutter/material.dart';

class RecordService with ChangeNotifier {

  bool _isRecord = false;
  bool get isRecord => _isRecord;
  set isRecord(bool isRecord) {
    _isRecord = isRecord;
    notifyListeners();
  }

}