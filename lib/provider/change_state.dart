import 'package:flutter/material.dart';

class ChangeState extends ChangeNotifier {
  int selectedCategoryId = 0;
  void updateCategoryId(int selectedCategoryId) {
    this.selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }
}