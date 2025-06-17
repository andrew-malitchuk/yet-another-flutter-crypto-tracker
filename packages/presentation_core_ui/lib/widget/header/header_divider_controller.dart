import 'package:flutter/material.dart';

class HeaderDividerController extends ChangeNotifier {
  bool isVisibility = false;

  void setVisibility(bool visibility) {
    isVisibility = visibility;
    notifyListeners();
  }

  void setVisible() {
    setVisibility(true);
  }

  void setUnvisible() {
    setVisibility(false);
  }
}