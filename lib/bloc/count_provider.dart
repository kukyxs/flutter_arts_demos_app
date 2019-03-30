import 'package:flutter/material.dart';

class CountProvider with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void changeValue(int value) {
    _value = value;
    notifyListeners();
  }
}
