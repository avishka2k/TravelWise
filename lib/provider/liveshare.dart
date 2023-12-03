import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  int myLocation = 1;

  void updateVariable(int newValue) {
    myLocation = newValue;
    notifyListeners(); 
  }
}