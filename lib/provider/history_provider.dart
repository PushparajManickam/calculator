import 'package:flutter/material.dart';

class HistoryProvider with ChangeNotifier {
  List _dataHistory = [];
  get getDataHistory => _dataHistory;
  set setDataHistory(value) {
    _dataHistory = value;
    notifyListeners();
  }
}
