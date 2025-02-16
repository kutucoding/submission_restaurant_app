import 'package:flutter/widgets.dart';

class ImageSliderProvider extends ChangeNotifier{
  int _currentSlide = 0;

  int get currentSlide => _currentSlide;

  void updateCurrentSlide (int newValue) {
    _currentSlide = newValue;
    notifyListeners();
  }
}