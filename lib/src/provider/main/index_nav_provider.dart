import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexButtomNavBar = 0;

  int get indexBottomNavBar => _indexButtomNavBar;

  set setIndexBottomNavBar(int value) {
    _indexButtomNavBar = value;
    notifyListeners();
  }
}
