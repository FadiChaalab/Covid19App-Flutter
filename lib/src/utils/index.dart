import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexSelected with ChangeNotifier {
  int index;
  SharedPreferences prefs;

  IndexSelected() {
    this.index = 0;
    init();
  }
  init() async {
    prefs = await SharedPreferences.getInstance();
    int temp = prefs.getInt("index") ?? 0;
    index = temp;
  }

  setIndex(int x) {
    prefs.setInt("index", x);
    index = x;
    notifyListeners();
  }

  getIndex() {
    return index;
  }
}
