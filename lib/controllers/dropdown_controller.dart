import 'package:flutter/material.dart';

class DropdownController extends ChangeNotifier {
  List<String> items = [];
  List<String> selectedItems = [];

  void setItems(List<String> newItems) {
    items = newItems;
    notifyListeners();
  }

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }
}
